class Search < ApplicationRecord
  def self.all_except_last
    limit(count - 1)
  end
end
