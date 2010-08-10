namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :production_populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # Step 0: clear any old data in the db
    [User, Administrator, Announcement].each(&:delete_all)
    
    # Step 1: add a default admin
    # first, create a new user
    Administrator.populate 1 do |admin|
      admin.first_name = "Bob"
      admin.last_name = "Phelps"
      admin.active = true
      User.populate 1 do |u|
        u.username = "bphelps"
        u.email = "principal@pucs.org"
        u.persistence_token = "d5ddba13ed4408ea2b0a12ab18ed2d2eda086279736bdc121ca726a11f1e4b99217d9c534c2cc4ebb22729349c8c5fdbe1529e1f2c3c5859c62ef4dd9feea25c"
        u.crypted_password = "3d16c326648cccafe3d4b4cb024475c381dda92f430dfedf6f933e1f61203bacb6bae2437849bdb43b06be335e23790e4aa03902b3c28c3bbbbe27d501e521f3"
        u.password_salt = "n6z_wtpWoIsHgQb5IcFd"
        admin.user_id = u.id
        u.role = "admin"
        u.active = true
      end
    end
           
    # Step 2: add 2 bogus announcements (easy to delete later; just so dashboard not blank at start)
    Announcement.populate 2 do |a|
      a.contents = Faker::Lorem.paragraph
      a.start_date = Time.now.to_date
      a.end_date = 1.day.from_now..14.days.from_now
      a.created_at = Time.now
      a.updated_at = Time.now
    end
  end
end
