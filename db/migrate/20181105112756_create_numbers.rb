class CreateNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :numbers do |t|
      t.bigint  :number
      t.string  :user_name
      t.boolean :custom_number

      t.timestamps
    end

    add_index :numbers, %i( number user_name ), unique: true, using: :btree
  end
end
