class Card < ApplicationRecord
  validates :original, :translated, :review, presence: true 
  validates :original, :translated, uniqueness: { case_sensitive: false }

  before_create do
    self.review = self.created_at +  86400 * 3
  end

  before_validation  :no_equal

  protected

  def no_equal
    if self.original.downcase == self.translated.downcase
      self.errors.add( :original, 'Оригинальный и переведённый тексты не должны быть равны друг другу')
    end
  end
end
