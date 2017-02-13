class Card < ApplicationRecord
  validates :original, :translated, presence: true 
  validates :original, :translated, uniqueness: { case_sensitive: false }

  validate :on_review, on: :create

  validate  :no_equal, on: [:create, :update]

  scope :atrandom, -> { where('review <= current_date').order('RANDOM()').first }

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
