class ContactsController < ApplicationController

  def create
    @mail = params[:contact]
    AdminMailer.contact_mail(@mail).deliver
    redirect_to contacto_path, :notice => "Tu coreo ha sido enviado correctamente."
  end
end
