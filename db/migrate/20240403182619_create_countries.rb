class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :alpha_code_2, null: false
      t.string :alpha_code_3, null: false
      t.string :currency_code, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
