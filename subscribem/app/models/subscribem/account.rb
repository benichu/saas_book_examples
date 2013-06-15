module Subscribem
  class Account < ActiveRecord::Base
    belongs_to :owner, :class_name => 'Subscribem::User'
    accepts_nested_attributes_for :owner
    attr_accessible :name, :owner_attributes, :subdomain
    validates :subdomain, :presence => true, :uniqueness => true

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
  end
end
