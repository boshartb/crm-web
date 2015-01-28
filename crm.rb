require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
require "sinatra/reloader"

$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))


get '/' do
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @contacts = $rolodex.contacts

  erb :contacts
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get '/contacts/new' do
  erb :new_contact
end
