class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.avatar = Avatarly.generate_avatar(user.email, opts={})
        user.confirm
        user.admin!
      end
  end
end
