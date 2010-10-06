require 'rubygems'
require 'rake'

desc "Build Titanium Mobile SDOC file"
task :build_sdoc do
  require "json"
  require "lib/titanium_mobile.rb"

  if !File.directory?( "dist" )
    raise "nah nah, you need a directory named 'dist' men!"
  end
  
  if !File.file?( "dist/api.json" )
    raise "nah nah, you need the 'api.json' file, get it here: http://developer.appcelerator.com/apidoc/mobile/latest"
  end

  if !File.directory?( "dump" )
    Dir.mkdir( "dump", 0700 )
  end

  begin
    puts "=> building sdoc..."
    File.open( "dump/titanium-mobile.sdoc", "w+" ) do |f|
      api = JSON.parse( File.read( "dist/api.json" ) )
      data = TitaniumMobile::SDoc.process_data( api )
      data.each do |d|
        f.puts( TitaniumMobile::SDoc.build_block( d ) + "\n" )
      end
    end
    puts "=> done"
    puts "=> copy dump/titanium-mobile.sdoc file to your project"
  rescue Exception => e
    raise e
  end
end

task :default => "build_sdoc"