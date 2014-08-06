namespace :build do
  SHA = `git show -q | head -n1 | awk '{print $2}' | cut -c -7`.chomp

  file 'secrets' do
    client = Fog::Storage.new(provider: 'AWS')
    secrets = client.directories.get('magic-eight-bar').files.get('secrets')
    File.open('secrets', 'w') { |file| file.write(secrets.body) }
  end

  task :docker => 'secrets' do
    puts "Building magic:#{SHA}"

    IO.popen("docker build -t magic:#{SHA} .") do |io|
      while line = io.gets
        puts line
      end
    end
  end
end
