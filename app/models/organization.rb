class Organization < ActiveRecord::Base
  attr_accessible :name, :address, :telephone, :linkman

  def admin
    User.where(:organization_id => id, :role => 'admin').first
  end

  def members
    User.where(:organization_id => id, :role => 'member')
  end

  def self.create_with_admin(org_params, admin_params)
    organization = Organization.new(org_params)
    transaction do
      organization.save!

      admin = User.new(admin_params)
      admin.password = ADMIN_DEFAULT_PASSWORD
      admin.role = 'admin'
      admin.organization_id = organization.id
      admin.save!(:validate => false)
    end

    organization
  end

  def saved?
    id && valid?
  end

  ADMIN_DEFAULT_PASSWORD = '12345678'

end
