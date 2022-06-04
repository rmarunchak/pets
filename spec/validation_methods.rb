# frozen_string_literal: true

def asc_validation(response)
  prices_array = response.body.flat_map { |response| response['price'] }
  prices_array[0] < prices_array[1]
end

def prices_response(response)
  @prices_array = response.body.flat_map { |response| response['price'] }
end

def desc_validation(response)
  prices_array = response.body.flat_map { |response| response['price'] }
  prices_array[0] > prices_array[1]
end

def price_lt_validation(response, num)
  prices_array = response.body.flat_map { |response| response['price'] }
  prices_array.all? { |elem| elem < num }
end

def price_gt_validation(response, num)
  prices_array = response.body.flat_map { |response| response['price'] }
  prices_array.all? { |elem| elem > num }
end