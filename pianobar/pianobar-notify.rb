#!/usr/bin/ruby

trigger = ARGV.shift

if trigger == 'songstart'
  songinfo = {}

    STDIN.each_line { |line| songinfo.store(*line.chomp.split('=', 2))}
    `terminal-notifier -title "Now Playing" -message "#{songinfo['title']}\nby #{songinfo['artist']}"`
end
