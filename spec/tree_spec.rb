require './lib/tree'

RSpec.describe Tree do
  subject(:node) { described_class.new([1, 2, 3]) }
  
  describe '#root', root: true do
    context 'when @root is not set' do
      it 'returns nil' do
        expect(node.root).to eq(nil)
      end
    end

    context 'when @root is set' do
      before do
        allow(node).to receive(:build_tree).and_return('tree')
      end

      it 'returns the value of @root' do
        expect(node.root).to eq('tree')
      end
    end
  end
end
