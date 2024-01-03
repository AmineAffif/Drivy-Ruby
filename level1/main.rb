require 'json'

file = File.read('data/input.json')
data = JSON.parse(file)

pp data