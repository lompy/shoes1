require 'spec_helper'

describe HasCrudableView do

  before(:each) do
    class Model; include HasCrudableView; end
    @model = Model
  end

  after(:each) do
    @model = nil
    Object.send(:remove_const, :Model)
  end

  describe 'class methods added' do
    it 'defines static .has_collections method' do
      expect(@model).to respond_to(:has_collections)
    end

    it 'defines static .has_fields method' do
      expect(@model).to respond_to(:has_fields)
    end
  end

  describe '.has_fields' do
    it 'defines #fileds method' do
      expect(@model.new).to respond_to(:fields)
    end

    it 'defines .fields_names method' do
      expect(@model).to respond_to(:fields_names)
    end

    context 'with empty params' do
      it 'returns [] with #fields' do
        expect(@model.new.fields).to eq([])
      end

      it 'returns [] with .fields_names' do
        expect(@model.fields_names).to eq([])
      end
    end

    context 'with many params' do
      before { @model.has_fields(:param_1, :param_2) }
      it 'returns array with #fields' do
        expect(@model.new.fields).to be_instance_of(Array)
      end

      it 'returns Field objects in array with #fields' do
        expect(@model.new.fields[0]).to be_instance_of(HasCrudableView::Field)
        expect(@model.new.fields[1]).to be_instance_of(HasCrudableView::Field)
      end

      it 'returns proper Field objects in array with #fields' do
        expect(@model.new.fields[0].name).to be(:param_1)
        expect(@model.new.fields[1].name).to be(:param_2)
      end

      it 'returns array with .fields_names' do
        expect(@model.fields_names).to be_instance_of(Array)
      end

      it 'returns array of params with .fields_names' do
        expect(@model.fields_names).to eq([:param_1, :param_2])
      end
    end

    context 'with selectable params' do
      before { @model.has_fields(selectable: [:param_1]) }

      it 'returns array with #fields' do
        expect(@model.new.fields).to be_instance_of(Array)
      end

      it 'returns Field objects in array with #fields' do
        expect(@model.new.fields[0]).to be_instance_of(HasCrudableView::Field)
      end

      it 'returns proper Field objects in array with #fields' do
        expect(@model.new.fields[0].name).to be(:param_1)
        expect(@model.new.fields[0].selectable).to be(true)
      end

      it 'returns array with .fields_names' do
        expect(@model.fields_names).to be_instance_of(Array)
      end

      it 'returns array of params with .fields_names' do
        expect(@model.fields_names).to eq([:param_1])
      end
    end

    context 'with invisible params' do
      before { @model.has_fields(invisible: [:param_1]) }

      it 'returns array with #fields' do
        expect(@model.new.fields).to be_instance_of(Array)
      end

      it 'returns Field objects in array with #fields' do
        expect(@model.new.fields[0]).to be_instance_of(HasCrudableView::Field)
      end

      it 'returns proper Field objects in array with #fields' do
        expect(@model.new.fields[0].name).to be(:param_1)
        expect(@model.new.fields[0].invisible).to be(true)
      end

      it 'returns array with .fields_names' do
        expect(@model.fields_names).to be_instance_of(Array)
      end

      it 'returns array of params with .fields_names' do
        expect(@model.fields_names).to eq([:param_1])
      end
    end
  end

  describe '.has_collections' do
    it 'defines #collections method' do
      expect(@model.new).to respond_to(:collections)
    end

    it 'defines .collections_names method' do
      expect(@model).to respond_to(:collections_names)
    end

    context 'calling .has_collections with empty params' do
      it 'returns [] with .collections_names' do
        expect(@model.collections_names).to eq([])
      end
    end

    context 'calling .has_collections with many params' do
      before { @model.has_collections(:param_1, :param_2) }

      it 'returns array of params with .collections_names' do
        expect(@model.collections_names).to eq([:param_1, :param_2])
      end

      it 'returns Collections object with .new.collections' do
        expect(@model.new.collections).to be_instance_of(HasCrudableView::Collections)
      end

      it 'creates proper Collections object with .new' do
        obj = @model.new
        collections = obj.collections
        expect(collections.instance_variable_get('@obj')).to be(obj)
      end
    end

    context 'calling .has_collections with editable hash' do
      before { @model.has_collections(editable: [:param_1]) }

      it 'returns array of params with .collections_names' do
        expect(@model.collections_names).to eq([:param_1])
      end

      it 'returns indicator array with .collections_editable' do
        expect(@model.collections_editable).to eq([true])
      end
    end
  end
end

describe HasCrudableView::Collections do
  context 'init from empty params' do
    it 'raises error' do
      expect{ HasCrudableView::Collections.new() }.to raise_error(ArgumentError)
    end
  end

  context 'init from any object and []' do
    let(:obj){ 'any obj' }
    let(:collections){ HasCrudableView::Collections.new(obj, []) }

    describe '#each' do
      it 'returns []' do
        expect(collections.each{}).to eq([])
      end
    end
    describe '#[]' do
      it 'returns nil' do
        expect(collections[0]).to be_nil
      end
    end
  end

  context 'init from any object and not []' do
    let(:obj){ 'any obj' }
    let(:array){ [:method_name] }
    let(:collections){ HasCrudableView::Collections.new(obj, array) }
    before { obj.stub(:method_name){ :result } }

    describe '#each' do
      it 'calls each method from array on object' do
        d = double(obj)
        expect(d).to receive(:method_name)
        collections = HasCrudableView::Collections.new(d, array)
        collections.each do |c|
          c
        end
      end

      it 'yields object.method to block' do
        collections.each do |c|
          expect(c).to eq(:result)
        end
      end
    end
    describe '#[]' do
      it 'returns object.send(array[])' do
        expect(collections[0]).to eq(:result)
      end
    end
  end
end

describe HasCrudableView::Field do
  describe '.new' do
    context 'invalid params' do
      it 'raises an error with empty params' do
        expect { HasCrudableView::Field.new }.to raise_error
      end
    end

    context 'valid params' do
      it 'sets name' do
        expect(HasCrudableView::Field.new(:name).name).to eq(:name)
      end

      it 'sets label' do
        expect(HasCrudableView::Field.new(:name).label).to eq(:name)
      end

      it 'sets selectable' do
        expect(HasCrudableView::Field.new(:name, true).selectable).to eq(true)
      end

      it 'sets invisible' do
        expect(HasCrudableView::Field.new(:name, false, true).invisible).to eq(true)
      end
    end
  end
end
