class Card < ApplicationRecord
  validates :original, :translated, presence: true 
  validates :original, :translated, uniqueness: { case_sensitive: false }
  validate :on_review, on: :create
  validate  :no_equal, on: [:create, :update]
  
  scope :for_review, -> { where( 'review <= ?', Time.now ) }
  scope :for_all,    -> { where( 'review > ?', Time.now ) }
  scope :one_card,   -> { order('RANDOM()').first }
  
  def comparison(txt)
    self.original == txt
  end

  def update_date_review
      self.update_attributes(review: 3.days.from_now) 
  end

  protected

  def on_review 
    self.review = 3.days.from_now
  end

  def no_equal
    if self.original.downcase == self.translated.downcase
      self.errors.add( :original, 'Оригинальный и переведённый тексты не должны быть равны друг другу')
    end
  end

end
