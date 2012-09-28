class Ability
    include CanCan::Ability

    def initialize(user)
        can :read, :all

        if user.try(:admin?)
            can :manage, :all
        end
    end
end
