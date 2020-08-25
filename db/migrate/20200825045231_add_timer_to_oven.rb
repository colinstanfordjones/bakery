class AddTimerToOven < ActiveRecord::Migration[5.1]
  def change
    add_column :ovens, :timer, :datetime
  end
end
