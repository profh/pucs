namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # Step 0: clear any old data in the db
    [User, Household, Guardian, Student].each(&:delete_all)
    
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
       
    # Step 2: add 100 households and guardians to the system
    Household.populate 100 do |hh|
      # get some fake data using the Faker gem
      hh.street = Faker::Address.street_address
      hh.city = Faker::Address.city
      # assume PA since this is an urban school in Pittsburgh
      hh.state = "PA"
      # randomly assign one of four area zip codes
      hh.zip = ["15213", "15212", "15090", "15237"]
      # want to store phone as 10 digits in db and use rails helper
      # number_to_phone to format it properly in views
      hh.home_phone = rand(10 ** 10).to_s.rjust(10,'0')
      # assume photo is 'no_image.jpg'
      hh.photo_file_name = "no_image.jpg"
      # Assume that approximately half of households are in the free lunch program
      get_free_lunch = rand(2)  # will generate numbers 0,1 at random
      if get_free_lunch.zero?   # household's number came up... 
        hh.free_lunch = true
      else
        hh.free_lunch = false
      end
      # Assume that approximately 1 in 3 households are in single family households
      is_single_family = rand(3)  # will generate numbers 0,1,2 at random
      if is_single_family.zero?   # household's number came up... 
        hh.status = 1 # set status to single family
        # now create a user and guardian for family
        Guardian.populate 1 do |g|
          g.last_name = Faker::Name.last_name
          g.household_id = hh.id
          g.ethnicity = [1,2,3,4,5,6]
          g.mobile_phone = rand(10 ** 10).to_s.rjust(10,'0')
          g.work_phone = rand(10 ** 10).to_s.rjust(10,'0')
          g.is_primary = true  
          # determine gender and relationship
          g.is_female = [true, false]
          if g.is_female
            g.relationship = [1,3]
            g.first_name = %w[Anne Cindy Jeria Sharon Kathy Betsy Beth Deb Valerie Jane Diane Elizabeth Karen Mary Nancy Nicole Angie Ann Amy Samantha Patrica]
          else
            g.relationship = [2,4]
            g.first_name = %w[Larry Carl Tim Tom Evan Charles John Kevin Joseph Christopher Conrad Blake Greg David Peter Jacob Stafford Ari Ashton Arvind Daniel Lyle Kyle Michael Mitchell Douglas]
          end
          # add in the user account info; password is 'secret'
          User.populate 1 do |u|
            u.username = "#{g.first_name.downcase}.#{g.last_name.downcase}"
            u.email = "#{g.first_name.downcase}.#{g.last_name.downcase}@example.com"
            u.persistence_token = "d5ddba13ed4408ea2b0a12ab18ed2d2eda086279736bdc121ca726a11f1e4b99217d9c534c2cc4ebb22729349c8c5fdbe1529e1f2c3c5859c62ef4dd9feea25c"
            u.crypted_password = "3d16c326648cccafe3d4b4cb024475c381dda92f430dfedf6f933e1f61203bacb6bae2437849bdb43b06be335e23790e4aa03902b3c28c3bbbbe27d501e521f3"
            u.password_salt = "n6z_wtpWoIsHgQb5IcFd"
            g.user_id = u.id
            u.role = "guardian"
            u.active = true
          end
          # set the user_id and make active
          #g.user_id = u.id
          g.active = true
          g.security_form = true
          # set the timestamps
          g.created_at = Time.now
          g.updated_at = Time.now
        end
      else
        hh.status = 2
        # now create two users for family; start with dad
        Guardian.populate 1 do |g1|
          g1.first_name = %w[Larry Carl Tim Tom Evan Charles John Kevin Joseph Christopher Conrad Blake Greg David Peter Jacob Stafford Ari Ashton Arvind Daniel Lyle Kyle Michael Mitchell Douglas]
          g1.last_name = Faker::Name.last_name
          g1.household_id = hh.id
          g1.ethnicity = [1,2,3,4,5,6]
          g1.mobile_phone = rand(10 ** 10).to_s.rjust(10,'0')
          g1.work_phone = rand(10 ** 10).to_s.rjust(10,'0')
          g1.is_primary = true  
          g1.is_female = false
          g1.relationship = 2
          # add in the user account info; password is 'secret'
          User.populate 1 do |u1|
            u1.username = "#{g1.first_name.downcase}.#{g1.last_name.downcase}"
            u1.email = "#{g1.first_name.downcase}.#{g1.last_name.downcase}@example.com"
            u1.persistence_token = "d5ddba13ed4408ea2b0a12ab18ed2d2eda086279736bdc121ca726a11f1e4b99217d9c534c2cc4ebb22729349c8c5fdbe1529e1f2c3c5859c62ef4dd9feea25c"
            u1.crypted_password = "3d16c326648cccafe3d4b4cb024475c381dda92f430dfedf6f933e1f61203bacb6bae2437849bdb43b06be335e23790e4aa03902b3c28c3bbbbe27d501e521f3"
            u1.password_salt = "n6z_wtpWoIsHgQb5IcFd"
            g1.user_id = u1.id
            u1.role = "guardian"
            u1.active = true
          end
          # set the user_id and make active
          # g1.user_id = u1.id
          g1.active = true
          g1.security_form = true
          # set the timestamps
          g1.created_at = Time.now
          g1.updated_at = Time.now
          
          # now add mom...
          Guardian.populate 1 do |g2|
            g2.first_name = %w[Anne Cindy Jeria Sharon Kathy Betsy Beth Deb Valerie Jane Diane Elizabeth Karen Mary Nancy Nicole Angie Ann Amy Samantha Patrica]
            # only 1 out of 8 women keep their maiden names
            keep_maiden_name = rand(8)
            if keep_maiden_name.zero?
              g2.last_name = Faker::Name.last_name
            else
              g2.last_name = g1.last_name
            end
            g2.ethnicity = [1,2,3,4,5,6]
            g2.household_id = hh.id
            g2.mobile_phone = rand(10 ** 10).to_s.rjust(10,'0')
            g2.work_phone = rand(10 ** 10).to_s.rjust(10,'0')
            g2.is_primary = false  
            g2.is_female = true
            g2.relationship = 1
            # add in the user account info; password is 'secret'
            User.populate 1 do |u2|
              u2.username = "#{g2.first_name.downcase}.#{g2.last_name.downcase}"
              u2.email = "#{g2.first_name.downcase}.#{g2.last_name.downcase}@example.com"
              u2.persistence_token = "d5ddba13ed4408ea2b0a12ab18ed2d2eda086279736bdc121ca726a11f1e4b99217d9c534c2cc4ebb22729349c8c5fdbe1529e1f2c3c5859c62ef4dd9feea25c"
              u2.crypted_password = "3d16c326648cccafe3d4b4cb024475c381dda92f430dfedf6f933e1f61203bacb6bae2437849bdb43b06be335e23790e4aa03902b3c28c3bbbbe27d501e521f3"
              u2.password_salt = "n6z_wtpWoIsHgQb5IcFd"
              g2.user_id = u2.id
              u2.role = "guardian"
              u2.active = true
            end
            # set the user_id and make active
            # g2.user_id = u2.id
            g2.active = true
            g2.security_form = true
            # set the timestamps
            g2.created_at = Time.now
            g2.updated_at = Time.now
          end
        end
      end    
      # assume all the households are active
      hh.active = true
      # set the timestamps
      hh.created_at = Time.now
      hh.updated_at = Time.now
    end
     
    # Step 3: add 1 to 3 students to each household in the system
    Household.all.each do |family|
      Student.populate 1..3 do |s|
        # s.first_name = Faker::Name.first_name
        s.last_name = family.guardians.map{|g| g.last_name}
        s.household_id = family.id
        s.grade = (0..8).to_a
        s.dob = 12.years.ago..5.year.ago
        s.ethnicity = (1..6).to_a
        s.is_female = [true, false]
        if s.is_female
          s.first_name = %w[Anne Cindy Jeria Sharon Kathy Betsy Beth Deb Valerie Jane Diane Elizabeth Karen Mary Nancy Nicole Angie Ann Amy Samantha Patrica]
        else
          s.first_name = %w[Larry Carl Tim Tom Evan Charles John Kevin Joseph Christopher Conrad Blake Greg David Peter Jacob Stafford Ari Ashton Arvind Daniel Lyle Kyle Michael Mitchell Douglas]
        end
        s.engrade_id = rand(5 ** 10).to_s.rjust(7,'0')
        s.active = true
        s.created_at = Time.now
        s.updated_at = Time.now
      end
    end
    
    # Step 4: add privacy settings to each household in the system
    Household.all.each do |house|
      PrivacySetting.populate 1 do |ps|
        ps.household_id = house.id
        ps.public_address = true
        ps.public_names = true
        ps.public_children = true
        ps.public_emails = [true, false]
        ps.public_demographics = true
        ps.public_home_phone = [true, false]
        ps.public_other_phones = [true, false]
        ps.created_at = Time.now
        ps.updated_at = Time.now
      end
    end
    
    # Step 5: add 12 bogus announcements
    Announcement.populate 12 do |a|
      a.contents = Faker::Lorem.paragraph
      a.start_date = Time.now.to_date
      a.end_date = 1.day.from_now..14.days.from_now
      a.created_at = Time.now
      a.updated_at = Time.now
    end
  end
end
