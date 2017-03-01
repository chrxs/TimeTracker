class TimeRecordSerializer < ActiveModel::Serializer
  attributes :id, :project_id, :amount, :project_name

  def project_name
    object.project.name
  end
end
