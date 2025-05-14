# frozen_string_literal: true

RSpec.describe "README" do
  let(:readme) { File.read(readme_path) }
  let(:readme_path) { File.join(__dir__, "../README.md") }

  readme = File.read(File.join(__dir__, "../README.md"))
  valid_codes = readme.scan(/```rb\n(.*?)\n```/m).flatten
  valid_codes.each do |code|
    it "returns true for code #{code.inspect}" do
      expect(eval(code)).to be(true)
    end
  end
end
