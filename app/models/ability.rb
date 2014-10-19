class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :goddess
      can :manage, :all
    elsif user.has_role? :user
      cannot :manage, Page
      can :manage, Post, :project => { :projects_users => { :user_id => user.id, is_admin: true } }
      can :manage, Project, :projects_users => { :user_id => user.id, is_admin: true}
    end

  end
end
