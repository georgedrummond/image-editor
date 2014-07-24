require 'spec_helper'

describe ImageEditor do
  subject(:image_editor) { ImageEditor.new }

  describe '#commands' do
    before { image_editor.commands '>I23 >L34E >S' }
    
    its(:processed_commands) {
      should eq [
        { command_key: 'I', arguments: [2, 3] },
        { command_key: 'L', arguments: [3, 4, 'E'] },
        { command_key: 'S', arguments: [] }
      ]
    }
  end

  its(:canvas) { should eq [] }
end
