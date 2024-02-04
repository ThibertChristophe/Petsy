class CreateJoinTablePetPost < ActiveRecord::Migration[7.1]
  def change
    create_join_table :pets, :posts do |t|
      t.index %i[pet_id post_id]
      t.index %i[post_id pet_id]
    end
  end
end
