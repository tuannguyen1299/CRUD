require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { described_class.new()}

  describe "#title" do
    it "must exist" do
      expect(subject.valid?).to eq(false)
      expect(subject.errors.messages[:title].present?).to eq(true)
    end
  end

  describe "#describe" do
    it "must exist" do
      expect(subject.valid?).to eq(false)
      expect(subject.errors.messages[:describe].present?).to eq(true)
    end
  end

  describe "#content" do
    it "must exist" do
      expect(subject.valid?).to eq(false)
      expect(subject.errors.messages[:content].present?).to eq(true)
    end
  end

  describe "#image" do
    it "must small 1MB" do
      subject.image = File.open(Rails.root + 'spec/factories/fixtures/images/anh1.png')
      expect(subject.errors.messages[:image].present?).to eq(false)
    end
  end

  describe "#image" do
    it "must bigger 1MB" do
      subject.image = File.open(Rails.root + 'spec/factories/fixtures/images/anh2.jpg')
      expect(subject.valid?).to eq(false)
    end
  end
end
