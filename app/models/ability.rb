class Ability
    include CanCan::Ability

    def initialize(user)
        can :read, Healthcat

        if user.try(:admin?)
            can :manage, :all
        end
    end
end
