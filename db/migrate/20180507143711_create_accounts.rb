class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :admin_user
      t.string :user
      t.string :password
      t.boolean :isvalid

      t.timestamps
    end
  end
end
