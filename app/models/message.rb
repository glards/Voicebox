class Message
  include Mongoid::Document
  field :callsid, :type => String
  field :received, :type => Time
  field :url, :type => String

  belongs_to :user
end
