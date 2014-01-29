require 'digest/sha2'

class Person < ActiveRecord::Base

  ENCRYPT = Digest::SHA256

  attr_reader :password
  attr_accessible :name, :email, :password
  
  has_many :sessions, :dependent => :destroy

  validates_uniqueness_of :name, :message => 'this username already exists'
  validates_uniqueness_of :email, :message => 'this email already exists'

  validates_format_of :name, :with => /^([a-z0-9_]{2,16})$/i,
    :message => "must be 4 to 16 letters, numbers or underscores and have no spaces"

  validates_format_of :password, :with => /^([\x20-\x7E]){4,16}$/,
    :message => "must be 4 to 16 characters",
    :unless => :password_set?

  validates_confirmation_of :password

  before_save :lower_name
  after_save :wipe_password

  def password=(password)
    @password = password
    unless password_set?
      self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
      self.pass_hash = ENCRYPT.hexdigest(password + self.salt)
    end
  end

  def self.match(name, password)
    person = self.find_by_name(name)
    if person and person.pass_hash == ENCRYPT.hexdigest(password + person.salt)
      return person
    end
  end

  private

  def lower_name
    self.name.downcase!
  end

  def wipe_password
    @password = @password_confirm = nil
  end

  def password_set?
    self.id and self.password.blank?
  end

end