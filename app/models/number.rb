class Number < ApplicationRecord
  FIRST_NUMBER = 1_111_111_111
  LAST_NUMBER  = 9_999_999_999
  validates :number,
            uniqueness: true,
            numericality: true,
            inclusion: FIRST_NUMBER..LAST_NUMBER

  class << self
    def stringified(number)
      number.to_s.insert(3, '-').insert(7,'-')
    end

    def convert_to_integer(number)
      return unless number

      number.tr('^0-9', '').to_i
    end
  end
end
