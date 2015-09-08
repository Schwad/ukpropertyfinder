require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "This task is called by the Heroku scheduler add-on"

  task :clear_data => :environment do
    Tag.destroy_all
    Listing.destroy_all
    puts "Data destroyed!"
  end

  task :clear_outcodes => :environment do
    Outcode.destroy_all
    puts "Outcoes destroyed!"
  end

  task :build_outcodes => :environment do
    build_outcodes_now
  end

  task :build_listings => :environment do


  end
