class Ability
    include CanCan::Ability

    def initialize(user)
        can :read, :all
        can :health, Article

        if user.try(:admin?)
            can :manage, :all
        end
    end
end
