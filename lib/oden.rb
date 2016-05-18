require "oden/version"

module Oden
  require 'open-uri'
  require 'nokogiri'
  require 'rubygems'
  require "FileUtils"

  def self.scrap(url, save_path)
    scrap_target_page = Nokogiri::HTML(open(url))
    images_list = Array.new
    scrap_target_page.css('img.MTMItemThumb').each do |anchor|
    	images_list.push(anchor[:src])
      save_image(anchor[:src], save_path)
    end
    if images_list.empty?
      puts "Sorry... empty...."
      false
    else
      puts "Exist!! Success!!"
      true
    end
  end

  def self.save_image(url, save_path)
  	file_name = File.basename(url) + ".jpg"
  	file_path = save_path + file_name
  	FileUtils.mkdir_p(save_path) unless FileTest.exist?(save_path)
  	open(file_path, 'wb') do |output|
  		open(url) do |data|
  			output.write(data.read)
  		end
  	end
  end
end
