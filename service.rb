require 'rubygems'
require 'cuba'
require 'haml'
require 'rqrcode'
#require 'fileutils'
#require 'RMagick'
require './helper'

Cuba.define do
  on get do
    on '' do
      res.write haml('main')
    end
   # on 'cleanup' do
   #   Dir["codes/*.png"].each do |file|
   #     FileUtils.rm_rf file
   #   end
   #   res.redirect '/'
   # end
   # on "codes", extension("png") do |file|
   #   res.headers["Content-Type"] = "image/png"
   #   res.write File.read("codes/#{file}.png")
   # end
    on "main.css" do
      res.headers["Content-Type"] = "text/css; charset=utf-8"
      res.write <<-EOS
table {
  border-width: 0;
  border-style: none;
  border-color: #0000ff;
  border-collapse: collapse;
}
td {
  border-width: 0;
  border-style: none;
  border-color: #0000ff;
  border-collapse: collapse;
  padding: 0;
  margin: 0;
  width: 10px;
  height: 10px;
}
td.black { background-color: #000; }
td.white { background-color: #fff; }
EOS
    end
  end
  on post do
    on '' do
      on param("text") do |text|
        @qr = RQRCode::QRCode.new(text, :size => 3)
        #@image_file = "codes/#{text.hash}.png"
        #to_image_file(@image_file,@qr)
        @message = text
        res.write haml('main')
      end
    end
  end
  on default do
    not_found
  end
end
