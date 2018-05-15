class AccountsController < ApplicationController

  before_action :authenticate_user!, :except => [:check, :regist]
  protect_from_forgery :except => [:check, :regist]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def manage
    @account = Account.where(admin_user: current_user.email)
  end

  def check
    if request.post? then
      user = params[:user]
      password = params[:password]
      check = Account.find_by(user: user, password: password)
      if check != nil then
        if check.isvalid == true then
          head 200   # 200を返す
        else
          head 304   # 200を返す
        end
      else
        head 304   # 200を返す
      end
    end
  end

  def regist
    if request.post? then
      user = params[:user]
      password = params[:password]
      admin = params[:admin_user]
      user = Account.find_or_initialize_by(user: user, password: password, admin_user: admin)
      if user.new_record? # 新規作成の場合は保存
        user.save!
      end
    end
  end

  def create
    @master = current_user.email
    @account = Account.new
    if request.post? then
      account = user_params[:user]
      user = Account.find_or_initialize_by(admin_user:current_user.email, user: account)
      logger.debug(account)
      user.update(password:user_params[:password], isvalid:user_params[:isvalid])
    end
  end

  def update
    @master = current_user.email
    @account = Account.new
    if request.post? then
      account = user_params[:user]
      user = Account.find_or_initialize_by(admin_user:current_user.email, user: account)
      logger.debug(account)
      if params[:commit] == '更新する' then
        user.update(isvalid:user_params[:isvalid])
      else
        user.delete
      end
    end
  end

  private
  def user_params
     params.require(:account).permit(:admin_user, :user, :password, :isvalid)
  end

end
