newuser = Admin.new({ :email => 'admins@cahoots.com',
                     :password => 'carina1',
                     :password_confirmation => 'carina1'})
newuser.save!