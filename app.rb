require 'rubygems'
require 'sinatra'
require 'sass'
require 'active_record'

load 'config/config.rb'
load 'models.rb'

module Oblique
  class App < Sinatra::Default
    set :sessions, false
    set :run, false

    get '/style.css' do
      content_type 'text/css'
      sass :style
    end

    get '/' do
      @strategy = Strategy.find(:all, :order => 'random()').first
      haml :index
    end
    
    get '/about' do
      haml :about
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