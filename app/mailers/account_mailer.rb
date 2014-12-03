class AccountMailer < ActionMailer::Base
  default charset: 'ISO-2022-JP', from: Planets::MailFrom
  
  def test_user
    mail(to: "wakkunndesu_cadd9@yahoo.co.jp", subject: "Planets テストメール")
  end
  
  def new_email(new_email)
    @new_email = new_email
    mail(to: new_email.address, subject: "Planets 登録")
  end
end