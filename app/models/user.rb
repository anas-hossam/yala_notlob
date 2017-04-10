class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable
 #devise :omniauthable, :omniauth_providers => [:facebook]
 acts_as_followable
 acts_as_follower
  has_many :groups#method return arr of obj
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :orders, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :order_details, dependent: :destroy


# def name
#   email.split('@')[0]
# end



end
