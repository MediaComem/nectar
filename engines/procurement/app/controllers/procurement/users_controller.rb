require_dependency 'procurement/application_controller'

module Procurement
  class UsersController < ApplicationController

    before_action only: [:index, :create] do
      unless procurement_or_leihs_admin?
        # raise Errors::ForbiddenError
        flash.now[:error] = _('You are not authorized for this action.')
        render action: :root
      end
    end

    def index
      respond_to do |format|
        format.html do
          @requester_accesses = Access.requesters.joins(:user) \
                                  .order('users.firstname')
          @admins = User.not_as_delegations \
                        .joins('INNER JOIN procurement_accesses ON ' \
                               'users.id = procurement_accesses.user_id')
                        .where(procurement_accesses: { is_admin: true })
                        .order(:firstname)
        end
        format.json do
          render json: User.not_as_delegations.filter(params) \
                        .to_json(only: [:id, :firstname, :lastname])
        end
      end
    end

    def create
      Access.requesters.delete_all
      params[:requesters].each do |param|
        next if param[:name].blank? or param[:_destroy] == '1'
        access = Access.requesters.find_or_initialize_by(user_id: param[:user_id])
        parent = Organization.find_or_create_by(name: param[:department])
        org = parent.children.find_or_create_by(name: param[:organization])
        access.update_attributes(organization: org)
      end

      Procurement::Organization.cleanup

      existing_admin_ids = Access.admins.pluck(:user_id)
      admin_ids = (params[:admin_ids] || '').split(',')
      (existing_admin_ids - admin_ids).each do |user_id|
        Access.admins.find_by(user_id: user_id).destroy
      end
      (admin_ids - existing_admin_ids).each do |user_id|
        Access.admins.create(user_id: user_id)
      end

      flash[:success] = _('Saved')
      redirect_to users_path
    end

    # rubocop:disable Metrics/MethodLength
    def choose
      @category = Procurement::Category.find(params[:category_id])

      unless @category.inspectable_by?(current_user)
        # raise Errors::ForbiddenError
        flash.now[:error] = _('You are not authorized for this action.')
        render action: :root
      end

      @budget_period = BudgetPeriod.find(params[:budget_period_id])

      @requester_accesses = Procurement::Access.requesters
      if params[:sort_by] and params[:sort_dir]
        @requester_accesses = @requester_accesses.sort do |a, b|
          case params[:sort_by]
          when 'user'
              a.user.to_s <=> b.user.to_s
          when 'organization'
              a.organization.to_s <=> b.organization.to_s
          when 'department'
              a.organization.parent.to_s <=> b.organization.parent.to_s
          else
              a.send(params[:sort_by]) <=> b.send(params[:sort_by])
          end
        end
        @requester_accesses.reverse! if params[:sort_dir] == 'desc'
      end
    end
    # rubocop:enable Metrics/MethodLength

  end
end
