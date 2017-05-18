class TimeRecordSerializer < ActiveModel::Serializer
  attributes :id, :amount, :project

  def project
    ProjectSerializer.new(object.project)
  end
end
