ActiveAdmin.register User do
  index do    
    column :email
    column :password
    column :active
    default_actions
  end


    form do |f|
      f.inputs "Details" do
        f.input :email
        f.input :password
        f.input :active
      end
      f.actions
    end
  
end
