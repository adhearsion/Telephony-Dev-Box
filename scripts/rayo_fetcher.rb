module RayoFetcher
  %w(json net/http open-uri).each { |lib| require lib }

  def self.download(opts = {})
    latest = get_latest
    opts = {
      full_url: latest[:url],
      to: "/opt/voxeo/prism/apps"
    }.merge opts
    puts "Fetching rayo-server b#{latest[:build]}..."
    `curl -C - -o #{opts[:to]}/rayo.war #{opts[:full_url]}`
  end

  def self.get_latest
    latest = {}
    Net::HTTP.start("ci.voxeolabs.net") do |http|
      body = JSON.parse http.get("/jenkins/job/Rayo/api/json").body
      latest[:path]   = "#{body["builds"].first["url"]}"
      latest[:build]  = "#{body["builds"].first["url"]}".split("Rayo")[1].gsub("/", "")
      latest[:url]    = "#{latest[:path]}artifact/rayo-war/target/rayo_b#{latest[:build]}.war"
    end
    latest
  end
end
