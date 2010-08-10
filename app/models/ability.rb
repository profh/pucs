class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
  		can :manage, :all
  	elsif user.role? :guardian
  		can :read, Student do |student|
        user.guardian.students.map{|s|s.id}.include? student.id
     	end
   	 	can :read, Household do |household|
        user.guardian.household_id == household.id
   	 	end
  		can :read, Guardian do |guardian|
        user.guardian.id == guardian.id
     	end
     	can :edit, Guardian do |guardian|
        user.guardian.id == guardian.id
     	end
  		can :update, Student do |student|
        user.guardian.students.map{|s|s.id}.include? student.id
     	end
      can :update, Household do |household|
        user.guardian.household_id == household.id
  	  end
  	else
      can :read, :all #Assume this person is a teacher and can read anything
    end
  end
end