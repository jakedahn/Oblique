require 'rubygems'
require 'sinatra'

namespace 'db' do
  desc "Create db schema"
  task :create do        
    require 'active_record'
    require 'config/config.rb'
  
    ActiveRecord::Migration.create_table :strategies do |t|
      t.string :strategy
    end

    ActiveRecord::Migration.create_table :subscribers do |t|
      t.string :email
    end
    Subscriber.new(:email => "phonenumber@tmomail.net").save        
    
  end  
end