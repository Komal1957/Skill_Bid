class BidPolicy < ApplicationPolicy
    def create?
        user.is_a?(Freelancer) # Only Freelancers can bid
    end

    def destroy?
        user.is_a?(Freelancer) && record.user == user
    end

    class Scope < Scope
        def resolve
            scope.all
        end
    end
end        