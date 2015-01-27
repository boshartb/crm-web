require 'sinatra'
require "sinatra/reloader"

get '/' do
	@crm_app_name = "My CRM"
  erb :index
end

get "/contacts/new" do
	erb :contacts
end

get "/contacts" do
	erb :contacts
end