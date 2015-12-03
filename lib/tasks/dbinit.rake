require 'find'
desc 'db init file db/data'
task :dbinit, [:table] => :environment do |t, args|
  folder = Rails.root.to_s + "/db/data/"
  files = Find.find(folder).select{|f| File.file?(f)}
  files = [ "#{folder}#{args[:table]}.yml" ] unless args[:table].nil?
  files.each do |file|
    file_name = file.split('/').last
    model = file_name.split('.').first
    datas = YAML.load File.read(file)
    datas = datas['data']
    is_repeat = eval "#{model}.where(#{datas.first}).count == 0"
    if is_repeat
      datas.each{ |item| eval("#{model}.create(#{item})") }
      puts "----- #{model}----- is OK count: #{datas.size}----"
    else
      puts "----- #{model}----- is repeat! ----"
    end
  end
end