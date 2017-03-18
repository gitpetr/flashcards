class AddTermReviewToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :term_review, :integer, default: 0
  end
end
