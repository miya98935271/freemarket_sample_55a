class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  private

  def callback_for(provider)
    oauth = request.env["omniauth.auth"]
    oauth_url = request.env["omniauth.origin"]
    uid = oauth.uid
    # provider = oauth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first

    if snscredential.present?
      user_sns = User.where(id: snscredential.user_id).first
    else
      user = User.where(email: oauth.info.email).first
    end

    if user.present? && (oauth_url == login_url)
      if user_sns.present?
        sign_in_and_redirect user, event: :authentication
      end
      SnsCredential.create(
        uid: uid,
        provider: provider,
        user_id: user.id
        )

      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?

    elsif user.blank? && (oauth_url == step1_registrations_url)
      session[:nickname] = oauth.info.name
      session[:email] = oauth.info.email
      session[:password_token] = Devise.friendly_token[0, 20]
      session[:uid] = uid
      session[:provider] = provider
      redirect_to step2_registrations_path

    elsif user.present? && (oauth_url == step1_registrations_url)
      redirect_to root_path, notice: "ユーザーは既に存在しています"

    elsif user.blank? && (oauth_url == login_url)
      redirect_to root_path, notice: "ユーザーは存在しません"
    end
  end

  def failure
    redirect_to root_path and return
  end
end
