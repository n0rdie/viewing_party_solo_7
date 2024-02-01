class User < ApplicationRecord
    validates_presence_of :title, :rating
end
 