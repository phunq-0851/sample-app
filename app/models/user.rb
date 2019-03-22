class User < ApplicationRecord
  before_save {email.downcase!}
<<<<<<< 36af26222c2e241daa4e5587a922570fcfb18042
  validates :name, presence: true, length: {maximum: Settings.fifty}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.twohundredfiftyfive},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.six}
end
