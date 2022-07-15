# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, uniqueness: true, presence: true
    validate :long_url_check

    after_initialize :generate_short_url

    def self.random_code
        short = SecureRandom::urlsafe_base64
        if ShortenedUrl.exists?(short)
            short = SecureRandom::urlsafe_base64
        end
        short
    end



    private
    def generate_short_url
        self.short_url ||= ShortenedUrl.random_code
    end
end
