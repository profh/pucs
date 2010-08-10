class PostOfficeController < ApplicationController
  def create
    if @post_ofice.save
      #Provide an email confirmation if all is good...
      PostOffice.deliver_new_friend_msg(@post_office)
      
      #Now a page confirmation as well...
      flash[:notice] = 'Friends were sccessfully created and an email was sent to notify them.'
      
    end
  end
  


end
