class AddDeviceTokenAndDeviceTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :device_token, :string
    add_column :users, :device_type, :string, limit: 16, default: 'ios'
    add_index :users, :device_type
  end
end
