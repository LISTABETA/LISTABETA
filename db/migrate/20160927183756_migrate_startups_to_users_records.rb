class MigrateStartupsToUsersRecords < ActiveRecord::Migration
  def up
    add_reference :startups, :user, index: true
    add_foreign_key :startups, :users

    # Migrate the current startup to new users
    Startup.find_each do |startup|
      User.new(name: startup.name, email: startup.email,
               encrypted_password: startup.encrypted_password)
          .save(validate: false)

      user = User.find_by(email: startup.email)

      startup.user = user
      startup.save(validate: false)
    end

    # Remove Devise columns from Startups
    [:encrypted_password, :reset_password_token, :reset_password_sent_at,
     :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
     :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at].each do |column|
       remove_column :startups, column
     end
  end

  def down
    # Add back Devise columns
    add_column :startups, :created_at, :datetime
    add_column :startups, :updated_at, :datetime
    add_column :startups, :sign_in_count, :integer
    add_column :startups, :last_sign_in_at, :datetime
    add_column :startups, :last_sign_in_ip, :string
    add_column :startups, :current_sign_in_at, :datetime
    add_column :startups, :current_sign_in_ip, :string
    add_column :startups, :encrypted_password, :string
    add_column :startups, :remember_created_at, :datetime
    add_column :startups, :reset_password_token, :string
    add_column :startups, :reset_password_sent_at, :string

    # Migrate back the Users to Startups
    User.find_each do |user|
      user.startups.each do |startup|
        startup.encrypted_password = user.encrypted_password
        startup.save(validate: false)
      end
    end

    # Remove the reference of User's on Startups
    remove_column :startups, :user_id

    # Drop the user's table
    drop_table :users
  end
end
