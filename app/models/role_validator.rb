class RoleValidator < ActiveModel::Validator
  def validate(record)
    unless ROLES.include? record.role
      record.errors[:role] << (options[:message] || "Incorrect Role")
    end
  end
end