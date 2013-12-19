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
text = 'screenshot.png'
browser.save_screenshot text
`convert screenshot.png -negate screenshot.png`
raw = e.text_for(text)

distance = raw.match(/(\S*) metres/)[1]
puts "Distance travelled: " + distance

if raw.include? 'showing real courage'
  puts "Roboqwop fell over"
else
  puts "Roboqwop was still running"
end

browser.quit
