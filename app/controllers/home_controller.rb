class HomeController < ApplicationController
  def home
  end

  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    #check if email is blank in the form
    if email.blank?
      flash[:alert] = t('.no_email_error')
    else
      ContactMailer.contact_email(email,name,telephone,message).deliver_now
      flash[:notice] = t('.thank_you_message')
    end
    redirect_to root_path
  end
end
