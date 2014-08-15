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

# Find bugs assigned to each packaged gem
class Bug < ActiveRecord::Base
  belongs_to :fedora_rpm

  def url
    "https://bugzilla.redhat.com/show_bug.cgi?id=#{bugzilla_id}"
  end

  def review_request?
    is_review = component == 'Review Request'
  end

end
