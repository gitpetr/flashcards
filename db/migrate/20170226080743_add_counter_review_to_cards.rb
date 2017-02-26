class AddCounterReviewToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :counter_review, :integer, default: 0
  end
end
