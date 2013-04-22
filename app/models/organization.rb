class Organization < ActiveRecord::Base
  attr_accessible :name, :address, :telephone, :linkman

  ##------------------------------查询方法-----------------------------
  def admin
    User.where(:organization_id => id, :role => 'admin').first
  end

  def members
    User.where(:organization_id => id, :role => 'member')
  end

  def self.create_with_admin(org_params, admin_params)
    organization = Organization.new(org_params)
    admin = User.new(admin_params)

    if organization.valid? && admin.valid?
      transaction do
        organization.save!

        admin.password = ADMIN_DEFAULT_PASSWORD
        admin.role = 'admin'
        admin.organization_id = organization.id
        admin.save!(:validate => false)
      end
    end

    organization
  end

  def saved?
    id && valid?
  end

  ADMIN_DEFAULT_PASSWORD = '12345678'

  #-------------------------校验---------------------------------
  validates :name, :address, :telephone, :linkman, presence: true
  validates :name, :address, :linkman, length: { maximum: 100 }
  validates :telephone, length: { maximum: 11 }, numericality: { only_integer: true }
end
