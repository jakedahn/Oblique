require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'active_record'

load 'config/config.rb'
load 'models.rb'
load 'methods.rb'

module Oblique
  class App < Sinatra::Default
    set :sessions, false
    set :run, false

    before do
      @flash = get_flash.nil? ? "" : "<span class='flash'>#{get_flash}</span>"  
    end

    get '/' do
      @strategy = Strategy.find(:all, :order => 'random()').first
      haml :index
    end
    
    get '/about' do
      haml :about
    end

    get '/subscribe' do
      haml :subscribe
    end
    
    post '/subscribe' do
      email = params[:phone]+params[:provider]

      Subscriber.new(:email => email).save ? set_flash("You are now subscribed, expect your first txt at 2pm PST.") : set_flash("Sorry but there was an error, please re-enter your phone number.")
      redirect("/subscribe")

    end
    
    get '/show/:id' do
      @strategy = Strategy.find(params[:id])
      haml :index
    end
    
    get '/docs' do
      haml :docs
    end
    
    get '/api/random' do
      content_type :json
      Strategy.find(:all, :order => 'random()').first.to_json
    end

    get '/api/:id' do
      content_type :json
      Strategy.find(params[:id]).to_json
    end

  end
end