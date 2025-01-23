class RoleType < ApplicationRecord
  ROLE_DATA = {
    administrator: 10, # can delete lists, list itmes, members, change membership roles, add roles,
    editor: 20, # Can add lists, add items, vote
    contributor: 30, # can add items
    voter: 40, # can vote on items
    member: 50 # Can view invisible lists
  }

  validates :name, uniqueness: true
  scope :ordered, -> { order(order: :asc) }
  default_scope { ordered }
end

# == Schema Information
#
# Table name: role_types
#
#  id    :bigint           not null, primary key
#  name  :string           not null
#  order :integer          default(0), not null
#
# Indexes
#
#  index_role_types_on_name  (name) UNIQUE
#
