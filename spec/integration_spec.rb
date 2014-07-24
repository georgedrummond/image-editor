require 'spec_helper'

describe CustomEditor do
  subject(:custom_editor) { CustomEditor.new }

  describe 'example 1' do
    before do
      custom_editor.commands '>I56 >L23A'
      custom_editor.run_commands!
    end

    its(:canvas) do
      should eq [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 'A', 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]
    end
  end

  describe 'example 2' do
    before do
      custom_editor.commands '>I56 >L23A'
      custom_editor.commands '>F33J >V234W >H342Z'
      custom_editor.run_commands!
    end

    its(:canvas) do
      should eq [
        ['J', 'J', 'J', 'J', 'J'],
        ['J', 'J', 'Z', 'Z', 'J'],
        ['J', 'W', 'J', 'J', 'J'],
        ['J', 'W', 'J', 'J', 'J'],
        ['J', 'J', 'J', 'J', 'J'],
        ['J', 'J', 'J', 'J', 'J']
      ]
    end
  end
end
