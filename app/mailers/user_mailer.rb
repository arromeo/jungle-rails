class UserMailer < ApplicationMailer
  default from: 'no-reply@aidoandofnausdnfuasndufinansdfu.com'

  def receipt_email(params)
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Order# #{@order.id}')
  end
end
