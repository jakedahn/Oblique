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
        
  end  
end