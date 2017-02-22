class Card < ApplicationRecord

  has_attached_file :image,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    styles: { medium: "360x360>" }, default_url: "/images/:style/missing.png"

    def s3_credentials
      {s3_region: 'us-east-1', bucket: ENV['S3_BUCKET_NAME'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']}
    end


  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :original, :translated, :user_id, presence: true 
  validates :original, :translated, uniqueness: { case_sensitive: false }
  validate  :on_review, on: :create
  validate  :no_equal, on: [:create, :update]

  belongs_to :user
  
  scope :for_review, -> { where( 'review <= ?', Time.now ) }
  
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
