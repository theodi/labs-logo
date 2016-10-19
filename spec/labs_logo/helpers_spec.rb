class TestHelper
  include LabsLogo::Helpers
end

module LabsLogo
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'says hello' do
      expect(helpers.hello).to eq 'Hello'
    end
  end
end
