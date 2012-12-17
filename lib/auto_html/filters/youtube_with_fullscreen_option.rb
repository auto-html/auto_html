AutoHtml.add_filter(:youtube_with_fullscreen_option).with(:width => 420, :height => 315, :frameborder => 0, :wmode => nil) do |text, options|
  regex = /https?:\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/
  text.gsub(regex) do
    youtube_id = $3
    width = options[:width]
    height = options[:height]
    frameborder = options[:frameborder]
		wmode = options[:wmode]
		src = "//www.youtube.com/embed/#{youtube_id}rel=0&fs=1"
		src += "?wmode=#{wmode}" if wmode
    %{<iframe width="#{width}" height="#{height}" src="#{src}" frameborder="#{frameborder}" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>}
  end
end
