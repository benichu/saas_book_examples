class CreateSubscribemPlans < ActiveRecord::Migration
  def change
    create_table :subscribem_plans do |t|
      t.string :name
      t.string :braintree_id
      t.float :price

      t.timestamps
    end
  end
end
