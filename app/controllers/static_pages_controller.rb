class StaticPagesController < ApplicationController
  before_filter :respond_to_ajax

private
  def respond_to_ajax
    render layout: !request.xhr?
  end
end
