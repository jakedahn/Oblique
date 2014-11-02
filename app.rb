require 'rubygems'
require 'sinatra'
require 'haml'
require 'active_record'

load 'config/config.rb'
load 'models.rb'
load 'methods.rb'


class Oblique < Sinatra::Base
  set :sessions, false
  set :run, false

  before do
    @flash = get_flash.nil? ? "" : "<span class='flash'>#{get_flash}</span>"  
  end

  get '/' do
    @strategy = Strategy.offset(rand(Strategy.count)).first
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
    Strategy.offset(rand(Strategy.count)).first.to_json
  end

  get '/api/:id' do
    content_type :json
    Strategy.find(params[:id]).to_json
  end

end
