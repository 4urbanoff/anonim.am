class Contact < ActiveRecord::Base

  include Nali::Model
  
  belongs_to :contact
  belongs_to :user
  belongs_to :dialog
  
  validates :active,  inclusion: { in: [ true, false ] }
  validates :counter, numericality: { only_integer: true }
  
  after_destroy do
    self.user.client and self.user.client[ :user ].contacts.reload
  end
  
  def access_level( client )
    if user = client[ :user ]
      return :owner   if self.user == user
      return :contact if self.contact and self.contact.user == user
    end
    :unknown
  end
  
end
