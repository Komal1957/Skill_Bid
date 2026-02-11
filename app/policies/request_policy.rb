class RequestPolicy < ApplicationPolicy
    def index?
        true # everyone can view requests
    end

    def show?
        true # everyone can view a specific request
    end

    def create?
        user.is_a?(Client) # Only client can post
    end

    def update?
        user.is_a?(Client) && record.user == user
    end

    def destroy?
        user.is_a?(Client) && record.user == user
    end

    class Scope < Scope
        def resolve
            scope.all
        end
    end
end
