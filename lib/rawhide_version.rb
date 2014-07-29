require 'open-uri'

class RawhideVersion
  # Retrieve rawhide version
  def self.version
    uri = 'https://admin.fedoraproject.org/pkgdb/api/collections?pattern=master'
    result = JSON.load(open(uri))
    result['collections'][0]['dist_tag'].gsub(/\.fc/, '').to_i
  end

  # Create file containting rawhide version for easy traversal
  def self.create_file
    version = self.version.to_s
    filename = 'rawhide'
    directory = Rails.root + 'public/version/'
    path = File.join(directory, filename)
    File.open(path, 'w') { |f| f.write(version) }
  end
end
