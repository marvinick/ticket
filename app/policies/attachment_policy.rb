class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	user.try(:admin?) || record.stub.project.has_member?(user)
  end
end
