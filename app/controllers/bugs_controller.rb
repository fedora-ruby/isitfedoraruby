class BugsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    @bugs = Bug.paginate(page: params[:page], per_page: 50)
               .order(sort_column + ' ' + sort_direction)
  end

  private

  def sort_column
    %w(bugzilla_id opened_by assigned_to status reported_on).include?(params[:sort]) ?
        params[:bugzilla_id] : ''
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
