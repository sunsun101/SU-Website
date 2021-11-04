class ContactController < ApplicationController
  def form
    @complain = Complain.new
  end
end
