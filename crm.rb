require 'sinatra'
require "sinatra/reloader"
require 'pry'
require "data_mapper"

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial 
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

# end of datamapper setup


#begin sinatra routes

get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @contacts = Contact.all

  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end


post '/contacts' do
  # new_contact = Contact.get(params[:id].to_i)
  # if @contact
  # @contact.first_name => params[:first_name],
  # @contact.last_name params[:last_name],
  # @contact.email params[:email],
  # @contact.note params[:note]
  # @contact.save
  # 
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
  )
  redirect to('/contacts')
end



get "/contacts/:id" do
   @contact = Contact.get(params[:id].to_i)
  if !@contact.nil?
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end


get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  @contact.destroy
  if @contact
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end