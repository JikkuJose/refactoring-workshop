require 'csv'
require_relative "row_per_day_formatter"

# 1. Create a class with same initialization arguments as BIGMETHOD
# 2. Copy & Paste the method's body in the new class, with no arguments
# 3. Replace original method with a call to the new class
# 4. Apply "Intention Revealing Method" to the new class. Woot!
class Formatter
  # More code, methods, and stuff in this big class

  def row_per_day_format(file_name)
    RowPerDayFormatter.new(file_name).format
  end

  # More code, methods, and stuff in this big class
end
