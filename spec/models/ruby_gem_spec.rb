# == Schema Information
#
# Table name: ruby_gems
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text(255)
#  homepage    :string(255)
#  version     :string(255)
#  has_rpm     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  downloads   :integer
#  source_uri  :string(255)
#

require 'rails_helper'

describe RubyGem do

  describe 'Validations' do
    it { should have_one(:fedora_rpm).dependent(:destroy) }
    it { should have_many(:dependencies).dependent(:destroy) }
    it { should have_many(:gem_versions).dependent(:destroy) }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :name }
  end

  describe '#to_param' do
    it 'returns the name of the gem stored in db' do
      expect(build(:ruby_gem).name).to eq('rails')
    end
  end

  describe 'load_or_create' do
  end

  describe '#on_rubygems?' do

    it 'gem is found' do
    end

    it 'gem is not found' do
    end
  end

  describe '#rubygems_uri' do
    it "returns the gem's rubygems.org uri" do
      expect(build(:foo).rubygems_uri).to eq('https://rubygems.org/gems/foo')
    end
  end

  describe 'retrieve_metadata' do
  end

  describe 'retrieve_rpm' do
  end

  describe 'retrieve_versions' do
  end

  describe 'update_from_source' do
  end

  describe 'search' do
  end

  describe 'gem_name' do
  end

  describe '#rpm?' do
    it 'has a matching rpm' do
      expect(build(:foo).rpm?).to eq true
    end

    it 'does not have a matching rpm' do
      gem = build(:foo)
      gem.has_rpm = false
      expect(gem.rpm?).to eq false
    end
  end

  describe 'version_in_fedora' do
  end

  describe 'upto_date_in_fedora' do
  end

  describe 'depencency_packages' do
  end

  describe 'dependent_packages' do
  end

  describe 'description_string' do

    it 'gem has a description' do
      gem = build(:foo)
      expect(gem.description_string).to eq gem.description
    end

    it 'gem does not have a description' do
      gem = build(:foo)
      gem.description = ''
      expect(gem.description_string).to eq "#{gem.name} does not have a description yet"
    end

  end

end
