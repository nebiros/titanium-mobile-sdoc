require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

spec = Gem::Specification.new do |s|
  s.name = 'titanium-mobile-sdoc'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'Titanium Mobile SDOC builder'
  s.description = s.summary
  s.author = 'Juan Felipe Alvarez Saldarriaga'
  s.email = 'nebiros@gmail.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "titanium-mobile-sdoc Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

desc "Build Titanium Mobile SDOC file"
task :build_sdoc do
  require "json"
  require "lib/titanium_mobile.rb"

  File.open( "dump/titanium-mobile.sdoc", "w+" ) do |f|
    api = JSON.parse( File.read( "dist/api.json" ) )
    data = TitaniumMobile::SDoc.process_data( api )
    data.each do |d|
      f.puts( TitaniumMobile::SDoc.build_block( d ) + "\n" )
    end
  end
end

task :default => "build_sdoc"