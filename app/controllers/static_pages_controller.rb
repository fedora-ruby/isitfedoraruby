class StaticPagesController < ApplicationController
  def successes
    @page_title = 'Success Stories'
  end

  def about
    @page_title = 'About'
  end
end
