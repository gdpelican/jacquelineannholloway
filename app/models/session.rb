class Session < ActiveRecord::Base

  attr_accessor :name, :password, :person
  attr_accessible :name, :password

  belongs_to :person

  before_validation :authenticate_person

  validates_presence_of :person, :message => 'Invalid username / password combination!'

  before_save :begin_session

  private

  def authenticate_person
    unless self.person
      self.person = Person.match(self.name, self.password)
    end
  end

  def begin_session     
    self.person_id ||= self.person.id
  end

end
