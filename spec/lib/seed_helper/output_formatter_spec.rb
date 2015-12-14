require 'spec_helper'

describe SeedHelper do

  describe '#output' do
    subject { SeedHelper.output(message, options) }
    let(:message) { "message" }
    let(:options) { {} }

    context 'options[:prefix] is provided' do
      let(:options) { {:prefix => "a prefix "} }
      it "prefixes the message with options[:prefix]" do
        expect($stdout).to receive(:puts).with(/a prefix message/)
        subject
      end
    end
    context 'options[:suffix] is provided' do
      let(:options) { {:suffix => " a suffix"} }
      it "suffixes the message with options[:suffix]" do
        expect($stdout).to receive(:puts).with(/message a suffix/)
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:options) { {:color => :blue} }
      it "prints the message with the provided color" do
        expect($stdout).to receive(:puts).with("\e[0;34;49mmessage\e[0m")
        subject
      end
    end
    context 'options[:color] is not provided' do
      let(:options) { {:color => nil} }
      it "prints the message in white by default" do
        expect($stdout).to receive(:puts).with("\e[0;37;49mmessage\e[0m")
        subject
      end
    end
  end

  describe '#message' do
    subject { SeedHelper.message(message, options) }
    let(:message) { "message" }
    let(:options) { {:prefix => prefix, :color => color} }
    let(:prefix)  { nil }
    let(:color)   { nil }
    context 'options[:prefix] is provided' do
      let(:prefix) { "a prefix " }
      it 'passes options[:prefix] to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:prefix => prefix))
        subject
      end
    end
    context 'options[:prefix] is not provided' do
      it 'passes a default prefix through to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:prefix => "*** "))
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:color) { :blue }
      it 'passes options[:color] to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:color => color))
        subject
      end
    end
    context 'options[:color] is not provided' do
      it 'passes a default color through to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:color => :white))
        subject
      end
    end
  end

  describe '#success' do
    subject { SeedHelper.success(message, options) }
    let(:message) { "message" }
    let(:options) { {:prefix => prefix, :color => color} }
    let(:prefix)  { nil }
    let(:color)   { nil }
    context 'options[:prefix] is provided' do
      let(:prefix) { "a prefix " }
      it 'passes options[:prefix] to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:prefix => prefix))
        subject
      end
    end
    context 'options[:prefix] is not provided' do
      it 'passes a default prefix through to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:prefix => "  + "))
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:color) { :blue }
      it 'passes options[:color] to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:color => color))
        subject
      end
    end
    context 'options[:color] is not provided' do
      it 'passes a default color through to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:color => :green))
        subject
      end
    end
  end

  describe '#error' do
    subject { SeedHelper.error(message, options) }
    let(:message) { "message" }
    let(:options) { {:prefix => prefix, :color => color} }
    let(:prefix)  { nil }
    let(:color)   { nil }
    context 'options[:prefix] is provided' do
      let(:prefix) { "a prefix " }
      it 'passes options[:prefix] to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:prefix => prefix))
        subject
      end
    end
    context 'options[:prefix] is not provided' do
      it 'passes a default prefix through to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:prefix => "  - "))
        subject
      end
    end
    context 'options[:color] is provided' do
      let(:color) { :blue }
      it 'passes options[:color] to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:color => color))
        subject
      end
    end
    context 'options[:color] is not provided' do
      it 'passes a default color through to output' do
        expect(SeedHelper).to receive(:output).with(anything, hash_including(:color => :red))
        subject
      end
    end
  end

end