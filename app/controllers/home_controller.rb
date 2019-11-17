class HomeController < ApplicationController
  def home
  end

  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    if email.blank?
      flash[:alert] = "You must supply an email address"
    else
      flash[:notice] = "Thank you. We will be in touch shortly"
    end

    redirect_to root_path
  end
end
