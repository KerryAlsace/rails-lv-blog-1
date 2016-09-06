class StaticController < ApplicationController
  def about
    render 'content/about'
  end

  def team
    render 'content/team'
  end
end
