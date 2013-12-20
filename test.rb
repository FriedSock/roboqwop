require 'selenium-webdriver'
require 'debugger'
require 'tesseract'

browser = Selenium::WebDriver.for :chrome

#Unfortunately, the swf has dependencies.
browser.get 'http://www.foddy.net/Athletics.html'

# Click to start the game

e = Tesseract::Engine.new {|e|
    e.language  = :eng
    e.blacklist = '|'
}

root = browser.find_element id: 'test'
root.click

(1..20).each do |i|
  root.send_keys 'ooooooooooooo'
end

browser.save_screenshot 'screenshot.png'

`convert screenshot.png -negate -crop 650x500+203+140 screenshot.png`
`convert screenshot.png -crop 300x50+360+170 crop.png`
fall = e.text_for 'screenshot.png'
distance = e.text_for 'crop.png'

distance = distance.match(/(\S*) metres/)[1]
puts "Distance travelled: " + distance

if fall.include? 'showing real courage'
  puts "Roboqwop fell over"
else
  puts "Roboqwop was still running"
end

browser.quit
