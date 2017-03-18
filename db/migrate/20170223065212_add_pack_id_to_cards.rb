class AddPackIdToCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :pack, foreign_key: true
  end
end
