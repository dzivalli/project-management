class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
      if user.root?
        can :manage, :all
      elsif  user.admin?
        can :manage, :all
        cannot :index, Client
      elsif user.customer?
        can :read, Project
        can :manage, Ticket
        can :manage, Message
        can do |action, klass, project|
          action = action.to_s
          # kind of alias, 'show' and 'index' are 'read'
          action = [action, 'read'] if (action == 'show') || (action == 'index')
          if project
            Permission.where(action: action, company: user.company, subject_id: project.id, subject_class: klass.name.downcase).any?
          else
            Permission.where(action: action, company: user.company, subject_class: klass.name.downcase).any?
          end
        end
      elsif user.staff?
        can :read, Project
        can :manage, Ticket
        can :manage, Message
        can do |action, klass, obj|
          Permission.where(user: user, action: action, subject_class: klass.name.downcase).any?
        end
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
