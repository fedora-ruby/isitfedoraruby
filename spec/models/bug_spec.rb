# == Schema Information
#
# Table name: bugs
#
#  id            :integer          not null, primary key
#  summary       :string(255)
#  bugzilla_id   :string(255)
#  fedora_rpm_id :integer
#  is_review     :boolean
#  created_at    :datetime
#  updated_at    :datetime
#  last_updated  :string(255)
#  component     :string(255)
#  status        :string(255)
#  needs_sponsor :boolean
#  assigned_to   :string(255)
#  opened_by     :string(255)
#  reported_on   :datetime
#  modified_on   :datetime
#

require 'rails_helper'

describe Bug do

  it 'has valid factory' do
    expect(create(:bug)).to be_valid
  end

  it 'has valid bugzilla url' do
    @bug = create(:bug)
    @bugzilla_url = 'https://bugzilla.redhat.com/show_bug.cgi?id='
    expect(@bug.url).to match(/#{Regexp.quote(@bugzilla_url)}\d+/)
  end

  it 'has status NEW and is a Review Request' do
    @bug = create(:new_review)
    expect(@bug.is_review).to eq true
    expect(@bug.status).to eq 'NEW'
  end

  it 'has status ASSIGNED and is a Review Request' do
    @bug = create(:assigned_review)
    expect(@bug.is_review).to eq true
    expect(@bug.status).to eq 'ASSIGNED'
  end

  it 'has status NEW and is not a Review Request' do
    @bug = create(:new_bug_not_review)
    expect(@bug.status).to eq 'NEW'
    expect(@bug.is_review).to_not eq true
  end

  it 'has status ASSIGNED and is not a Review Request' do
    @bug = create(:assigned_bug_not_review)
    expect(@bug.status).to eq 'ASSIGNED'
    expect(@bug.is_review).to_not eq true
  end

  context 'component Review Request' do

    before(:all) do
      @bug = create(:bug)
    end

    it 'is_review set to true' do
      @bug.component = 'Review Request'
      expect(@bug.review_request?).to eq true
    end

    it 'is_review set to false' do
      @bug.component = 'Bogus Component'
      expect(@bug.review_request?).to eq false
    end
  end

end
