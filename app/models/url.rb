class Url < ActiveRecord::Base

  after_create :create_bitly

  def create_bitly
    code = SecureRandom.hex(3)
    if  Url.where(short_url: code).first
      self.create_bitly
    else
      self.update_attributes({short_url: code})
    end
  end

  def increase_hit
    self.update_attributes({hits: self.hits + 1})
  end
end
