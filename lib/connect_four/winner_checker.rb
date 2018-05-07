module ConnectFour
  module WinnerChecker
    def check_for_winner
      rows = self.rows
      horizontal    = check_horizontal(rows)
      vertical      = check_vertical(rows)
      diagonal_asc  = check_diagonal_asc(rows)
      diagonal_desc = check_diagonal_desc(rows)
      horizontal || vertical || diagonal_asc || diagonal_desc
    end

    def check_horizontal(rows)
      rows.reverse_each.with_index do |row, row_index|
        return nil unless row.any?
        row.each_with_index do |slot, slot_index|
          next unless slot
          break if slot_index == row.size - 3
          next unless row[slot_index + 1] == slot
          next unless row[slot_index + 2] == slot
          next unless row[slot_index + 3] == slot
          hit_coordinates = []
          4.times do |i|
            hit_coordinates << [row_index, slot_index - 1 + i]
          end
          return { winner: @players[slot - 1],
                   hit_coordinates: hit_coordinates }
        end
      end
    end

    def check_vertical(rows)
      rows.reverse_each.with_index do |row, row_index|
        return nil if row_index == rows.size - 3
        row.each_with_index do |slot, slot_index|
          next unless slot
          rev_rows = rows.reverse
          next unless rev_rows[row_index + 1][slot_index] == slot
          next unless rev_rows[row_index + 2][slot_index] == slot
          next unless rev_rows[row_index + 3][slot_index] == slot
          return winner = @players[slot - 1]
        end
      end
    end

    def check_diagonal_asc(rows)
      rows.reverse_each.with_index do |row, row_index|
        return nil if row_index == rows.size - 3
        row.each_with_index do |slot, slot_index|
          break if slot_index == row.size - 3
          next unless slot
          rev_rows = rows.reverse
          next unless rev_rows[row_index + 1][slot_index + 1] == slot
          next unless rev_rows[row_index + 2][slot_index + 2] == slot
          next unless rev_rows[row_index + 3][slot_index + 3] == slot
          return winner = @players[slot - 1]
        end
      end
    end

    def check_diagonal_desc(rows)
      rows.each_with_index do |row, row_index|
        return nil if row_index == rows.size - 3
        row.each_with_index do |slot, slot_index|
          break if slot_index == row.size - 3
          next unless slot
          next unless rows[row_index + 1][slot_index + 1] == slot
          next unless rows[row_index + 2][slot_index + 2] == slot
          next unless rows[row_index + 3][slot_index + 3] == slot
          return winner = @players[slot - 1]
        end
      end
    end
  end
end
