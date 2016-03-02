class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user

    can [:profile, :update_profile], User, id: user.id
    can :switch, User

    if user.current.is_admin?
      can [:read, :create], Relocation, organization_id: user.current.organization_id
      can [:read, :dashboard], Organization do |org|
        org.memberships.include?(Membership.where(user_id: user.id, role: 'admin', organization_id: org.id).first)
      end
      # can [:read, :dashboard], Organization, id: user.current.organization_id
      can [:read, :create, :update], User, company_id: user.current.organization_id
      cannot [:show], User
      can [:read, :update], Employee, organization_id: user.current.organization_id
      can [:read, :create, :update], Membership, organization_id: user.current.organization_id
      can [:read], Relationship, :parent => {:id => user.current.organization_id}
      can [:read, :create, :update, :edit, :update, :show], Policy, organization_id: user.current.organization_id
    elsif user.current.is_manager?
      can [:read, :create], Relocation, id: user.current.organization_id
    elsif user.current.is_worker?
      can :read, Relocation, id: user.current.organization_id
    elsif user.current.is_transferee?
      can [:show, :update, :dashboard], Relocation, employee_id: user.employee.id
      can [:update], Employee, id: user.employee.id
      can :show, :steps
    end
  end
end
