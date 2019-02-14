require 'erb'
require 'digest'

urls = [
"https://google.com",
"https://web.dev/",
"https://typist.tech",
"https://github.com/pricing",
]

urls.uniq!

# Create template.
template = %q{
  version: 2.1

  orbs:
    lighthouse-keeper: itinerisltd/lighthouse-keeper@0.1

  workflows:
    lighthouse-keeper:
      triggers:
        - schedule:
            # Hourly
            cron: "0 0 * * *"
            filters:
              branches:
                only: master
      jobs:
        - lighthouse-keeper/commit:
            name: commit
            git_user_email: CHANGE_ME
            git_user_name: CHANGE_ME
            git_ssh_fingerprint: CHANGE_ME
            requires:
              <%- urls.each do |url| -%>
              - <%= url %>
              <%- end -%>

        <%- urls.each do |url| -%>
        - lighthouse-keeper/measure:
            name: <%= url %>
            id: <%= Digest::MD5.hexdigest(url) %>
            url: <%= url %>
        <%- end -%>
}.gsub(/^  /, '')

erb = ERB.new(template, nil, '-')

File.open('change-me.yml', 'w') do |f|
  f.write erb.result
end
