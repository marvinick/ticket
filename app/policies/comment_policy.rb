class CommentPolicy < StubPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
