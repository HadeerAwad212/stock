class CreateInvestments < ActiveRecord::Migration[5.1]
  def change
    create_table :investments do |t|
      t.float :money
      t.float :stocks
      t.references :asset, foreign_key: true
      t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
