class CreateNumberService
  def self.call(number_params)
    params_hash = number_params.to_h.symbolize_keys

    new(params_hash).call
  end

  def initialize(user_name:, number: nil)
    @user_name = user_name
    @number    = Number.convert_to_integer(number)
  end

  def call
    Number.create(
      user_name:     user_name,
      number:        pick_number,
      custom_number: custom_number?
    )
  end

  private

  attr_reader :user_name, :number

  def pick_number
    return number if custom_number?

    last_non_custom_number = Number.where(custom_number: false).last

    return Number::FIRST_NUMBER unless last_non_custom_number

    find_next_number(last_non_custom_number.number)
  end

  def find_next_number(phone_number)
    i = 1

    next_number = phone_number + i

    until Number.new(number: next_number).valid?
      next_number = phone_number + i

      i += 1
    end

    next_number
  end

  def custom_number?
    number.present? && Number.new(number: number).valid?
  end
end
