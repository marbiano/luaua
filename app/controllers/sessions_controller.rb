class SessionsController < Devise::SessionsController
 # POST /resource/sign_in
# Post /sign_in
 def create
  user = User.where(email: params[:user][:email]).first
  if user.active? 
   self.resource = warden.authenticate!(auth_options)
   set_flash_message(:notice, :signed_in) if is_navigational_format?
   sign_in (user)
   redirect_to new_product_path
   else
    redirect_to root_path, :notice => "Usted no ha sido dado de alta"
   end
 end
end

