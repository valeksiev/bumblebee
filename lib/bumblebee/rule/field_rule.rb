module Bumblebee

  class FieldRule < Rule

    def run(data, extra_data_lambda = nil)
      value = if is_compound?
                handle_compound(data)
              else
                data[@key]
              end
      value = @lambda.call(value) unless @lambda.nil?
      { @property => value }
    end
  end
end
