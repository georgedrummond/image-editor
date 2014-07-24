require_relative './image_editor'

class CustomEditor < ImageEditor

  rule 'I', action: :create_white_canvas
  rule 'C', action: :clear_table_white
  rule 'L', action: :color_xy_pixel
  rule 'V', action: :draw_vertical_line
  rule 'H', action: :draw_horizontal_line
  rule 'F', action: :fill_region_with_color
  rule 'S', action: :print_canvas
  rule 'X', action: :end_session

  # Create a new M x N image with all 
  # pixels coloured white (O). !
  #
  def create_white_canvas(m, n)
   @canvas = n.times.map do
      m.times.map { 0 }
    end
  end

  # Clears the table, setting all 
  # pixels to white (O)
  #
  def clear_table_white
    @canvas = @canvas.map do |row|
      row.map { 0 }
    end
  end

  # Colours the pixel (X,Y) with colour C
  #
  def color_xy_pixel(x, y, c)
    x_index = x - 1
    y_index = y - 1

    @canvas = @canvas.each_with_index.map do |cy, yi|
      cy.each_with_index.map do |cx, xi|
        if x_index == xi && y_index == yi
          c
        else
          cx
        end
      end
    end
  end

  # Draw a vertical segment of colour C in 
  # column X between rows Y1 and Y2 (inclusive)
  #
  def draw_vertical_line(x, y1, y2, c)
    x_index   = x - 1
    y_1_index = y1 - 1
    y_2_index = y2 - 1

    @canvas = @canvas.each_with_index.map do |cy, yi|
      cy.each_with_index.map do |cx, xi|
        if x_index == xi && yi >= y_1_index && yi <= y_2_index
          c
        else
          cx
        end
      end
    end
  end

  # Draw a horizontal segment of colour C in 
  # row Y between columns X1 and X2 (inclusive)
  #
  def draw_horizontal_line(x1, x2, y, c)
    x_1_index = x1 - 1
    x_2_index = x2 - 1
    y_index   = y - 1

    @canvas = @canvas.each_with_index.map do |cy, yi|
      cy.each_with_index.map do |cx, xi|
        if y_index == yi && xi >= x_1_index && xi <= x_2_index
          c
        else
          cx
        end
      end
    end
  end


  # Fill the region R with the colour C. R is 
  # defined as: Pixel (X,Y) belongs to R. Any 
  # other pixel which is the same colour as (X,Y) 
  # and shares a common side with any pixel in 
  # R also belongs to this region
  #
  def fill_region_with_color(x, y, c, old_color=nil)
    x_index = x - 1
    y_index = y - 1

    old_color ||= @canvas[x_index][y_index]
    current_color = @canvas[x_index][y_index]

    if old_color == current_color
      @canvas[x_index][y_index] = c

      fill_region_with_color(x-1, y, c, old_color) if x > 0
      fill_region_with_color(x+1, y, c, old_color) if x <= @canvas[0].length
      fill_region_with_color(x, y-1, c, old_color) if y > 0
      fill_region_with_color(x, y+1, c, old_color) if y <= @canvas.length
    end
  end

  # Show the contents of the current image
  #
  def print_canvas
    puts @canvas.map { |row| row.join }.join("\n")
  end

  #  Terminate the session
  #
  def end_session
    exit
  end
end
