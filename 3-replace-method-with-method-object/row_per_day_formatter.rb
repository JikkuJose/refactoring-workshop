class RowPerDayFormatter
  BRUTO = '1'
  CONSISTIDO = '2'

  def initialize(file_name)
    @file = File.open(file_name, 'r:ISO-8859-1')
    @hash = {BRUTO => {}, CONSISTIDO => {}}
    @dates = []
    @str = ''
  end

  def format
    csv_parse

    @dates.each do |date|
      @str << date.to_s
      left, right = bruto(date)
      @str << "\t#{left}\t#{right}" << "\n"
    end

    @str
  end

  private

  def bruto(date)
    @hash[BRUTO][date]
  end

  def csv_parse
    CSV.parse(@file, col_sep: ';').each do |row|
      next if row.empty?
      next if row[0] =~ /^\/\//

      date = Date.parse(row[2])

      (13..43).each do |i|
        measurement_date = date + (i - 13)
        @dates << measurement_date

        value  = row[7].nil? ? -99.9 : row[i]
        status = row[i + 31]

        hash_value = [value, status]

        @hash[row[1]][measurement_date] = hash_value
      end

      @dates.uniq!
    end
  end
end
