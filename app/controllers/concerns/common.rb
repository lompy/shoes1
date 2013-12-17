module Common
  extend ActiveSupport::Concern
  include Crud
  include Setters

  included do
    private :set_model_and_relation, :set_record, :record_params
    before_filter :set_model_and_relation
    before_filter :set_record, only: [:show, :edit, :update, :destroy]
  end
end
