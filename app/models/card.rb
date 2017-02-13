class Card < ApplicationRecord
  validates :original, :translated, presence: true 
  validates :original, :translated, uniqueness: { case_sensitive: false }

  validate :on_review, on: :create

  validate  :no_equal, on: [:create, :update]

  scope :for_review, -> { where(' review <= current_date or review > current_date ').order('RANDOM()').first }

  def comparison(txt)
    if self.original == txt
        self.update_attributes(review: 3.days.from_now)
     end
        
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
