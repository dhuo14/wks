class CreateUser < ActiveRecord::Migration
  def change
    create_table :user do |t|

      t.timestamps
    end
  end
end
