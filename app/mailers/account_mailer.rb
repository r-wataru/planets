class AccountMailer < ActionMailer::Base
  default charset: 'ISO-2022-JP', from: Planets::MailFrom

  def test_user
    mail(to: "wakkunndesu_cadd9@yahoo.co.jp", subject: "Planets テストメール")
  end

  def new_email(new_email)
    @new_email = new_email
    mail(to: new_email.address, subject: "Planets 登録")
  end

  def forgot_password(user_token)
    @user_token = user_token
    mail(to: user_token.email.address, subject: "Planets パスワード再設定")
  end

  def internal_server_error(exception, request, current_user)
    @exception = exception
    @current_user = current_user
    @request = request
    mail(to: Planets::DeveloperMail, subject: "Planets - Internal Server Error")
  end

  def newspaper(news)
    @news = news
    addresses = Email.where(main: true).pluck(:address)
    mail(to: addresses, subject: "Planets サイト更新のお知らせ")
  end

  def inquiry(inquiry)
    @inquiry = inquiry
    address = @inquiry.email
    mail(to: address, subject: "Planets 問い合わせ完了のお知らせ")
  end
end