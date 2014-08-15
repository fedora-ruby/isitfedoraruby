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

require 'faker'

FactoryGirl.define do
  factory :bug do
    summary 'Review Request: rubygem-foo - Short summary'
    bugzilla_id '12345'
    last_updated '6 days and 3 hours'
    assigned_to Faker::Internet.email
    opened_by Faker::Internet.email

    trait :review_true do
      is_review true
      component 'Package Review'
    end

    trait :review_false do
      is_review false
    end

    trait :status_new do
      status 'NEW'
    end

    trait :status_assigned do
      status 'ASSIGNED'
    end

    trait :sponsor_true do
      needs_sponsor true
    end

    trait :sponsor_false do
      needs_sponsor false
    end

    factory :new_review_needs_sponsor,
      traits: [:review_true, :status_new, :sponsor_true]

    factory :assigned_review_needs_sponsor,
      traits: [:review_true, :status_assigned, :sponsor_true]

    factory :new_review,
      traits: [:review_true, :status_new, :sponsor_false]

    factory :assigned_review,
      traits: [:review_true, :status_assigned, :sponsor_false]

    factory :new_bug_not_review,
      traits: [:review_false, :status_new, :sponsor_false]

    factory :assigned_bug_not_review,
      traits: [:review_false, :status_assigned, :sponsor_false]

  end
end
