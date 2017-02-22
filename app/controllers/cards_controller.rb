class CardsController < ApplicationController
  before_action :require_login
  before_action :set_card, except: [:index, :new, :create]
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @cards = current_user.cards.order('review , original') 
  end

  def show 
  end

  def new
    @card = current_user.cards.build
  end

  def create 
    @card = current_user.cards.build card_params
    if @card.save
      flash.now[:success] = 'карточка создана'
      redirect_to @card, success:  'карточка создана'
    else 
      flash.now[:danger] = 'ошибка создания карточки'
      render :new, danger: 'ошибка создания карточки'
    end
  end

  def update 
    if @card.update card_params
      redirect_to @card 
    else
      render :edit
    end
  end

  def destroy 
    @card.destroy
    redirect_to cards_path
  end

  private

  def owner
      @card = current_user.cards.find_by(id: params[:id])
      redirect_to root_path, danger: "У вас нет разрешения на изменение этой карточки" if @card.nil?
  end

  def set_card 
    @card = Card.find(params[:id])
  end

  def card_params 
    params.require(:card).permit(:original, :translated, :review, :image)
  end
end
