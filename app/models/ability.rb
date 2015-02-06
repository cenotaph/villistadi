class Ability
  include CanCan::Ability
  
  def initialize(user)
    
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    user ||= User.new # guest user (not logged in)
    if user.has_role? :goddess
      can :manage, :all
      can :view, Place, :published => false
      can :manage, Authentication
    elsif user.has_role? :user
      cannot :destroy, Authentication
      cannot :manage, Page
      can :create, Event
      can :crud, Post, :project => { :projects_users => { :user_id => user.id, is_admin: true } }
      #can :manage, Project, :projects_users => { :user_id => user.id, is_admin: true}
      can :view, Project, private: false
      cannot :view, Project, private: true
      can :create, Forumpost, :project => { :projects_users => { :user_id => user.id } }
      can :create, Comment, :commentable_type => 'Forumpost', :commentable => {:project => { :projects_users => { :user_id => user.id } } }
      cannot :view, Place, :published => false
    end

  end
end
