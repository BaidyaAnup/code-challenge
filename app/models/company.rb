class Company < ApplicationRecord
  EMAIL_REGEX = /\w+@getmainstreet.com/.freeze

  has_rich_text :description

   validate :validate_email

   before_save :set_city_state_using_zip_code


   def set_city_state_using_zip_code
   	zip_code = ZipCodes.identify(self.zip_code)
   	if zip_code.present?
   		self.city = zip_code[:city]
   		self.state = zip_code[:state_code]
   	end
   end


  private

  def validate_email
  	if email.present?
  	 self.errors.add(:email,"Email should only be a @getmainstreet.com domain") unless email.match(EMAIL_REGEX)
  	 	
  	end
  end


end
