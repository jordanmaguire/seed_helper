require 'rubygems'
require 'bundler'
Bundler.require
require 'rails/all'

require 'seed_helper'

# Create an in-memory database to do some basic tests with a real model
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

class User < ActiveRecord::Base
  def to_s
    email
  end
end

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string :email
    t.string :name
  end

end

RSpec.configure do |config|

  # DIY Database Cleaner
  config.before(:each) { User.delete_all }

end