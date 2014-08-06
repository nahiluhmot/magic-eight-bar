namespace :build do
  file 'secrets' do
    client = Fog::Storage.new(provider: 'AWS')
    secrets = client.directories.get('magic-eight-bar').files.get('secrets')
    File.open('secrets', 'w') { |file| file.write(secrets) }
  end

  task :docker => 'secrets' do
    sha = `git show -q | head -n1 | awk '{print $2}' | cut -c -7`.chomp
    puts "Building magic:#{sha}"

    IO.popen("docker build -t magic:#{sha} .") do |io|
      while line = io.gets
        puts line
      end
    end
  end
end
