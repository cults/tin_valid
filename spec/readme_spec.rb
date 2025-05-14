# frozen_string_literal: true

RSpec.describe "README" do
  readme = File.read(File.join(__dir__, "../README.md"))
  code_blocks = readme.scan(/```rb\n(.*?)\n```/m).flatten
  code_blocks.each do |code|
    it "returns true for code #{code.inspect}" do
      expect(eval(code)).to be(true)
    end
  end
end
