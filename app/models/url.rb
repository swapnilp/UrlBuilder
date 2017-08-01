class Url < ActiveRecord::Base

  after_create :create_bitly
  
  # After create records url code is generated
  def create_bitly
    code = SecureRandom.hex(3)
    if  Url.where(short_url: code).first
      self.create_bitly
    else
      self.update_attributes({short_url: code})
    end
  end

  # increaes count of hits
  def increase_hit
    self.update_attributes({hits: self.hits + 1})
  end
end
