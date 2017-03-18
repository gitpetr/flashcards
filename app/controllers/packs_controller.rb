class PacksController < ApplicationController
  before_action :require_login
  before_action :set_pack, except: [:index, :new, :create]
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @packs = current_user.packs.order(:name) 
  end

  def show 
  end

  def new
    @pack = current_user.packs.build
  end

  def create 
    @pack = current_user.packs.build pack_params
    if @pack.save
      redirect_to @pack, success:  'колода создана'
    else 
      flash.now[:danger] = 'ошибка создания колоды'
      render :new 
    end
  end

  def update 
    if @pack.update pack_params
      redirect_to @pack 
    else
      render :edit
    end
  end

  def destroy 
    @pack.destroy
    redirect_to packs_path
  end

  private

  def owner
      @pack = current_user.packs.find_by(id: params[:id])
      redirect_to root_path, danger: "У вас нет разрешения на изменение этой колоды" if @pack.nil?
  end

  def set_pack 
    @pack = Pack.find(params[:id])
  end

  def pack_params 
    params.require(:pack).permit(:name)
  end
end
