module HasCrudableView
  extend ActiveSupport::Concern

  def to_s
    name
  end

  module ClassMethods
    def has_collections(*collections_references)
      collections_editable = []
      collections_references = collections_references.each_with_object([]) do |c,result|
        if Hash === c && Array === c[:editable]
          c[:editable].each { |e| result << e; collections_editable << true}
        else
          result << c
          collections_editable << false
        end
      end
      self.define_singleton_method(:collections_names){ collections_references }
      self.define_singleton_method(:collections_editable){ collections_editable }
      self.send(:define_method, :collections) do
        Collections.new(self, collections_references)
      end
    end

    def has_fields(*fields_references)
      fields = fields_references.each_with_object([]) do |f,result|
        if Hash === f
          f.each do |key, value|
            if key == :invisible
              value.each { |e| result << Field.new(e, false, true) }
            elsif key == :selectable
              value.each { |e| result << Field.new(e, true) }
            end
          end
        else
          result << Field.new(f)
        end
      end
      self.define_singleton_method(:fields_names){ fields.map(&:name) }
      self.send(:define_method, :fields){ fields }
    end
  end

  included do
    has_collections
    has_fields
  end

  class Collections
    include Enumerable

    def initialize(obj, collection_references)
      @obj = obj
      @collection_references = collection_references
    end

    def each
      @collection_references.each do |c_ref|
        yield @obj.send(c_ref)
      end
    end

    def [](index)
      if @collection_references[index]
        @obj.send(@collection_references[index])
      else
        nil
      end
    end
  end

  class Field
    attr_reader :name, :label, :selectable, :invisible

    def initialize(name, selectable = false, invisible = false)
      @name = name
      @label = name
      @selectable = selectable
      @invisible = invisible
    end
  end
end
