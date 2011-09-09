module Rayo
  %w(json net/http open-uri).each{|lib| require lib}

  def download opts={}
    opts={
      :full_url=>get_latest[:url],
      :to_here=>"/opt/voxeo/prism/apps"
    }.merge!(opts)
    writeOut = open("#{opts[:to_here]}/rayo.war", "wb")
    writeOut.write(open(opts[:full_url]).read)
    writeOut.close
  end

  def get_latest
    latest={}
    Net::HTTP.start("hudson.voxeolabs.com") { |http|
      latest[:path] = "#{(JSON.parse(http.get("/hudson/job/Rayo/api/json").body)["builds"].first["url"])}"
      latest[:build] = "#{(JSON.parse(http.get("/hudson/job/Rayo/api/json").body)["builds"].first["url"])}".split("Rayo")[1].gsub("/","")
      latest[:url] = "#{latest[:path]}artifact/rayo-war/target/rayo_b#{latest[:build]}.war"
    }
    latest
  end
end

include Rayo

directory = File.expand_path(File.dirname(__FILE__))
install_dir = File.join(directory, "../",'components_to_be_installed',"rayo")

Rayo::download :to_here =>install_dir