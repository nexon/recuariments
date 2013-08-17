class UniquenessFieldName < ActiveModel::Validator
  def validate(record)
    unless record.project.fields.find_by_field_name(record.name.parameterize.gsub("-","_")).blank?
      record.errors[:base] << "name can't be repeated"
    end
  end
end