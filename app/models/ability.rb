class Ability
  include CanCan::Ability

  def initialize(user)
    # define user abilities here ....
    if user
      can :manage, Follower do |follower|
        follower.user == user
      end
    end
  end
end
