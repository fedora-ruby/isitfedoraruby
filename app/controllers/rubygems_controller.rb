class RubygemsController < ApplicationController

  def index
    @page_title = 'Ruby Gems'
    @gems = RubyGem.search(params[:search]).paginate(:page => params[:page], :per_page => 50, :order => 'name')
  end

  def show
    @id = params[:id]
    @gem = RubyGem.find_by_id(@id, :include => :gem_comments)
    @page_title = @gem.name
  end

end