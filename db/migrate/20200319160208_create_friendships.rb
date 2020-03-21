class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user
      t.references :friend
      t.integer :status, default: 0, limit: 1

      t.timestamps
    end
  end
end
