require_relative 'rolodex'
require 'sinatra'
require "sinatra/reloader"
require 'pry'
require "data_mapper"

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize(first_name, last_name, email, note)
    @id = nil
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
end



# end of datamapper setup
$rolodex = Rolodex.new


#begin sinatra routes

get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @contacts = $rolodex.contacts

  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end


post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end


get "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if !@contact.nil?
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end


get "/contacts/:id/edit" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = $rolodex.find(params[:id].to_i)
  if @contact
    $rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end