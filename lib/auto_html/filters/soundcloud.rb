require 'uri'
require 'net/http'

AutoHtml.add_filter(:soundcloud).with({}) do |text, options|
  # set these options
  # :maxwidth => '', :maxheight => '', :auto_play => false, :show_comments => false
  text.gsub(/(https?:\/\/)?(www.)?soundcloud\.com\/.*/) do |match|
    begin
      new_uri = match.to_s
      new_uri = (new_uri =~ /^https?\:\/\/.*/) ? URI(new_uri) : URI("http://#{new_uri}")
      new_uri.normalize!

      uri = URI("http://soundcloud.com/oembed")
      params = {:format => 'json', :url => new_uri}
      params = params.merge options
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get(uri)
    rescue
    end

    if !response.blank?
      JSON.parse(response)["html"]
    else
      match
    end
  end
end