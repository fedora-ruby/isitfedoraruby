require 'rails_helper'

describe 'RawhideVersion' do
  it 'returns the latest fedora version as a number', :vcr do
    uri = 'https://admin.fedoraproject.org/pkgdb/api/collections?pattern=master'
    json = JSON.load(open(uri))
    rawhide = json['collections'].first['dist_tag'].gsub(/\.fc/, '')
    expect(rawhide.to_i).to eq 22
  end

  context 'file with rawhide version' do
    before(:each) do
      @file_path = Rails.root + 'public/version/rawhide'
    end

    it 'exists' do
      expect(File.exist?(@file_path)).to be true
    end

    it 'contains the right version' do
      expect(File.read(@file_path)).to eq '22'
    end

    it 'contains the wrong version' do
      expect(File.read(@file_path)).to_not eq '12'
    end
  end
end
