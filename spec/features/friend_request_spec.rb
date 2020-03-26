require 'rails_helper'

RSpec.feature "Listing Articles" do

    before do 
        @maya = User.create(email:"maya@gmail.com",password:"123456")
     end

end