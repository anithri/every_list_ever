class ApplicationForm
  include ActiveModel::Model

  def to_model
    self
  end
  def persisted?
    false
  end
end
