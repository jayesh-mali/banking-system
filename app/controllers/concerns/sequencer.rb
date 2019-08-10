module Sequencer
  include ActiveSupport::Concern

  def generate_sequence_no(column_name)
    model = self.class
    model_object = model.select(:id, column_name).last
    if model_object.present?
      model_object.with_lock do
        self[column_name] = model_object[column_name] + 1
      end
    else
      self[column_name] = 100000000000
    end
  end
end
