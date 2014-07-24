require 'spec_helper'

describe CustomEditor do
  subject(:custom_editor) { CustomEditor.new }

  before { custom_editor.create_white_canvas(4, 6) }

  describe '#create_white_canvas' do
    its(:canvas) do
      should eq [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    end
  end

  describe 'clear_table_white' do
    before do
      custom_editor.color_xy_pixel(2, 3, 'E')
      custom_editor.clear_table_white
    end

    its(:canvas) do
      should eq [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    end
  end

  describe 'color_xy_pixel' do
    before do
      custom_editor.color_xy_pixel(2, 3, 'E')
      custom_editor.color_xy_pixel(4, 2, 'R')
    end

    its(:canvas) do
      should eq [
        [0, 0, 0, 0],
        [0, 0, 0, 'R'],
        [0, 'E', 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    end
  end

  describe 'draw_vertical_line' do
    before { custom_editor.draw_vertical_line(3, 2, 5, 'T') }

    its(:canvas) do
      should eq [
        [0, 0, 0, 0],
        [0, 0, 'T', 0],
        [0, 0, 'T', 0],
        [0, 0, 'T', 0],
        [0, 0, 'T', 0],
        [0, 0, 0, 0]
      ]
    end
  end

  describe 'draw_horizontal_line' do
    before { custom_editor.draw_horizontal_line(1, 3, 3, 'K') }

    its(:canvas) do
      should eq [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        ['K', 'K', 'K', 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    end
  end

  describe 'fill_region_with_color' do
    before do
      custom_editor.draw_horizontal_line(1, 3, 3, 'K')
      custom_editor.fill_region_with_color(1, 3, 'R')
    end

    its(:canvas) do
      should eq [
        ['R', 'R', 'R', 'R'],
        ['R', 'R', 'R', 'R'],
        ['K', 'K', 'K', 'R'],
        ['R', 'R', 'R', 'R'],
        ['R', 'R', 'R', 'R'],
        ['R', 'R', 'R', 'R'],
      ]
    end
  end

  describe 'print_canvas' do
    before { custom_editor.draw_horizontal_line(1, 3, 3, 'K') }

    let(:output) do
"0000
0000
KKK0
0000
0000
0000"
    end

    it do
      STDOUT.should_receive(:puts).with(output)
      custom_editor.print_canvas
    end
  end
end
