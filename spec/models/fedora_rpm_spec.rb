# == Schema Information
#
# Table name: rubygem_rpms
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  source_uri          :string(255)
#  last_commit_message :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  author              :string(255)
#  last_committer      :string(255)
#  last_commit_date    :datetime
#  last_commit_sha     :string(255)
#  homepage            :string(255)
#  ruby_gem_id         :integer
#  commits             :integer
#  fedora_user         :string(255)
#  summary             :text(255)
#  description         :text(255)
#

require 'rails_helper'

describe FedoraRpm do

  let!(:rpm) { create(:rubygem_foo) }

  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }

  it 'is invalid without a name' do
    rpm.name = nil
    expect(rpm).to be_invalid
  end

  it 'must have at least one koji build' do
  end

  describe 'source files of rubygem-foo' do
    it 'base uri points to pkgs.fp.o' do
      expect(rpm.base_uri).to eq 'http://pkgs.fedoraproject.org/cgit/'
    end

    it 'has proper source uri' do
      base_uri = 'http://pkgs.fedoraproject.org/cgit/'
      expect(rpm.source_uri).to eq "#{base_uri}#{rpm.name}.git"
    end

    it 'spec url points spec file at pkgs.fp.o' do
      expect(rpm.spec_uri).to eq 'http://pkgs.fedoraproject.org/cgit/rubygem-foo.git/tree/rubygem-foo.spec'
    end

  end

  describe '#to_param' do
    it 'returns the name stored in db' do
      expect(rpm.name).to eq 'rubygem-foo'
    end
  end

  describe '#shortname' do
    it 'returns foo if rpm name is rubygem-foo' do
      shortname = rpm.name.gsub(/rubygem-/, '')
      expect(shortname).to eq 'foo'
    end
  end

  describe '#retrieve_builds' do
    it 'returns the koji builds of supported Fedora versions' do
    end
  end

  describe '#fedora_versions' do

    context 'support latest 3 Fedora versions' do

      it 'has exactly 3 keys' do
        expect(FedoraRpm.fedora_versions.keys.count).to eq(3)
      end
    end
  end

  describe '#fas_name' do
    it "returns the owner's FAS name" do
    end
  end

  describe '#update_bugs' do
    it 'calls retrieve_bugs' do
      expect(rpm).to receive(:retrieve_bugs)
      rpm.update_bugs
    end

    it 'rescues errors' do
      allow(rpm).to receive(:retrieve_bugs).and_raise(StandardError)
      expect { rpm.update_bugs }.to_not raise_error
    end
  end

  describe '#update_builds' do
    it 'calls retrieve_builds' do
      expect(rpm).to receive(:retrieve_builds)
      rpm.update_builds
    end

    it 'rescues errors' do
      allow(rpm).to receive(:retrieve_builds).and_raise(StandardError)
      expect { rpm.update_builds }.to_not raise_error
    end
  end

  describe '#update_commits' do
    it 'calls commits_metadata' do
      expect(rpm).to receive(:commits_metadata).with(kind_of(String))
      rpm.update_commits
    end

    it 'rescues errors' do
      allow(rpm).to receive(:commits_metadata).and_raise(StandardError)
      expect { rpm.update_commits }.to_not raise_error
    end
  end

  describe '#update_dependencies' do
    it 'calls retrieve_dependencies' do
      expect(rpm).to receive(:retrieve_dependencies)
      rpm.update_dependencies
    end

    it 'rescues errors' do
      allow(rpm).to receive(:retrieve_dependencies).and_raise(StandardError)
      expect { rpm.update_dependencies }.to_not raise_error
    end
  end

  describe '#update_gem' do
    it 'calls retrieve_gem' do
      expect(rpm).to receive(:retrieve_gem)
      rpm.update_gem
    end

    it 'rescues errors' do
      allow(rpm).to receive(:retrieve_gem).and_raise(StandardError)
      expect { rpm.update_gem }.to_not raise_error
    end
  end

  describe '#update_versions' do
    it 'calls store_all_versions' do
      expect(rpm).to receive(:store_all_versions)
      rpm.update_versions
    end

    it 'rescues errors' do
      allow(rpm).to receive(:store_all_versions).and_raise(StandardError)
      expect { rpm.update_versions }.to_not raise_error
    end
  end

  describe '#update_from_source' do
    it 'updates all the things' do
      expect(rpm).to receive(:update_commits)
      expect(rpm).to receive(:update_specs)
      expect(rpm).to receive(:update_gem)
      expect(rpm).to receive(:update_bugs)
      expect(rpm).to receive(:update_builds)
      rpm.update_from_source
    end
  end

end # FedoraRpm
