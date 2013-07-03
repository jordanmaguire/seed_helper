require 'spec_helper'

class TestClass
  include SeedFormatter
end

describe SeedFormatter do

  let(:tc) { TestClass.new }

  describe '#output' do
    subject { tc.output message, options }
    let(:message) { "message" }
    let(:options) { {} }

    context 'options[:prefix] is provided' do
      let(:options) { {:prefix => "a prefix "} }
      it "prefixes the message with options[:prefix]" do
        $stdout.should_receive(:puts).with(/a prefix message/)
        subject
      end
    end
    context 'options[:suffix] is provided' do
      let(:options) { {:suffix => " a suffix"} }
      it "suffixes the message with options[:suffix]" do
        $stdout.should_receive(:puts).with(/message a suffix/)
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:options) { {:color => :blue} }
      it "prints the message with the provided color" do
        $stdout.should_receive(:puts).with("\e[34mmessage\e[0m")
        subject
      end
    end
    context 'options[:color] is not provided' do
      let(:options) { {:color => nil} }
      it "prints the message in white by default" do
        $stdout.should_receive(:puts).with("\e[37mmessage\e[0m")
        subject
      end
    end
  end

  describe '#message' do
    subject { tc.message message, options }
    let(:message) { "message" }
    let(:options) { {:prefix => prefix, :color => color} }
    let(:prefix)  { nil }
    let(:color)   { nil }
    context 'options[:prefix] is provided' do
      let(:prefix) { "a prefix " }
      it 'passes options[:prefix] to output' do
        tc.should_receive(:output).with(anything, hash_including(:prefix => prefix))
        subject
      end
    end
    context 'options[:prefix] is not provided' do
      it 'passes a default prefix through to output' do
        tc.should_receive(:output).with(anything, hash_including(:prefix => "*** "))
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:color) { :blue }
      it 'passes options[:color] to output' do
        tc.should_receive(:output).with(anything, hash_including(:color => color))
        subject
      end
    end
    context 'options[:color] is not provided' do
      it 'passes a default color through to output' do
        tc.should_receive(:output).with(anything, hash_including(:color => :white))
        subject
      end
    end
  end

  describe '#success' do
    subject { tc.success message, options }
    let(:message) { "message" }
    let(:options) { {:prefix => prefix, :color => color} }
    let(:prefix)  { nil }
    let(:color)   { nil }
    context 'options[:prefix] is provided' do
      let(:prefix) { "a prefix " }
      it 'passes options[:prefix] to output' do
        tc.should_receive(:output).with(anything, hash_including(:prefix => prefix))
        subject
      end
    end
    context 'options[:prefix] is not provided' do
      it 'passes a default prefix through to output' do
        tc.should_receive(:output).with(anything, hash_including(:prefix => "  + "))
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:color) { :blue }
      it 'passes options[:color] to output' do
        tc.should_receive(:output).with(anything, hash_including(:color => color))
        subject
      end
    end
    context 'options[:color] is not provided' do
      it 'passes a default color through to output' do
        tc.should_receive(:output).with(anything, hash_including(:color => :green))
        subject
      end
    end
  end

  describe '#error' do
    subject { tc.error message, options }
    let(:message) { "message" }
    let(:options) { {:prefix => prefix, :color => color} }
    let(:prefix)  { nil }
    let(:color)   { nil }
    context 'options[:prefix] is provided' do
      let(:prefix) { "a prefix " }
      it 'passes options[:prefix] to output' do
        tc.should_receive(:output).with(anything, hash_including(:prefix => prefix))
        subject
      end
    end
    context 'options[:prefix] is not provided' do
      it 'passes a default prefix through to output' do
        tc.should_receive(:output).with(anything, hash_including(:prefix => "  - "))
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:color) { :blue }
      it 'passes options[:color] to output' do
        tc.should_receive(:output).with(anything, hash_including(:color => color))
        subject
      end
    end
    context 'options[:color] is not provided' do
      it 'passes a default color through to output' do
        tc.should_receive(:output).with(anything, hash_including(:color => :red))
        subject
      end
    end
  end

  describe '#spacer' do
    subject { tc.spacer }
    it 'prints a blank line' do
      $stdout.should_receive(:puts).with(/^$/)
      subject
    end
  end

end