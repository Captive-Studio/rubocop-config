require 'net/http'
require 'json'

def get_latest_version(gem_name)
  uri = URI("https://rubygems.org/api/v1/versions/#{gem_name}/latest.json")
  begin
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data['version'] if data
  rescue StandardError => e
    puts "Unable to fetch latest version for #{gem_name}: #{e.message}"
    nil
  end
end

def update_gemspec(file_path)
  content = File.read(file_path)
  updated_content = content.gsub(/add_dependency\(["'](.*?)["'], ["']~> (.*?)["']\)/) do |match|
    gem_name = $1
    old_version = $2
    latest_version = get_latest_version(gem_name)
    if latest_version && latest_version != old_version
      puts "Updating #{gem_name} from ~> #{old_version} to ~> #{latest_version}"
      "add_dependency(\"#{gem_name}\", \"~> #{latest_version}\")"
    else
      match
    end
  end

  File.write(file_path, updated_content)
end

gemspec_file = 'rubocop-config-captive.gemspec'
update_gemspec(gemspec_file)
exec "bundle install"
