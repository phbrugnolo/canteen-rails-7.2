class Customer < ApplicationRecord
  include Activable

  has_many :sales

  validates :name, presence: true
  validates :matriculation, presence: true, uniqueness: true

  # def period_sales_total_price(start_date, end_date)
  #   total_value = 0
  #   sales.where(created_at: start_date..end_date).each do |sale|
  #     total_value += sale.total_price
  #   end
  #   total_value
  # end

  # def month_sales_total_price
  #   month_value = 0
  #   start_date = Date.new(Date.current.year, Date.current.month, 1)
  #   sales.where(created_at: start_date..Date.current).each do |sale|
  #     month_value += sale.total_price
  #   end
  #   month_value
  # end

  # def total_price_in_words(value)
  #   total_price_int = value.to_i

  #   total_price_decimal = ((value - total_price_int) * 100).to_i

  #   total_price_int_words = I18n.with_locale(:"pt-BR") { total_price_int.to_words }

  #   real_or_reais = total_price_int == 1 ? "real" : "reais"

  #   if total_price_decimal.positive?
  #     total_price_decimal_words = I18n.with_locale(:"pt-BR") { total_price_decimal.to_words }
  #     centavo_or_centavos = total_price_decimal == 1 ? "centavo" : "centavos"
  #     "#{total_price_int_words} #{real_or_reais} e #{total_price_decimal_words} #{centavo_or_centavos}"
  #   else
  #     "#{total_price_int_words} #{real_or_reais}"
  #   end
  # end
end
