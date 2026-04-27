class GdsRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :gds, reading: :gds }
end