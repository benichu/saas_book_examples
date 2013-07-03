module Subscribem
  class Account < ActiveRecord::Base
    belongs_to :owner, :class_name => 'Subscribem::User'
    belongs_to :plan, :class_name => 'Subscribem::Plan'
    accepts_nested_attributes_for :owner
    attr_accessible :name, :owner_attributes, :subdomain, :plan_id
    validates :subdomain, :presence => true, :uniqueness => true
    validates :name, :presence => true

    has_many :members, :class_name => "Subscribem::Member"
    has_many :users, :through => :members

    def self.create_with_owner(params={})
      account = new(params)
      if account.save
        account.users << account.owner
      end
      account
    end

    def create_schema
      Apartment::Database.create(subdomain)
    end

    def owner?(user)
      owner == user
    end
  end
end
