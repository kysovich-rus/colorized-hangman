if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
require_relative 'lib/console_interface'
require_relative 'lib/game'
require 'colorize'

puts <<~INTRO

    Однажды в далеком королевстве жил-был король, бла-бла-бла...
  Сразу к делу: его величество Тимлид I приговорил вас к смерти за пренебрежение кодинг-стайлом
  и злостное нарушение дедлайнов.
  Король предлагает угадать слово, которое он выбрал из шляпы с бумажками.
  Угадаете - получите амнистию. Не успеете - пойдете искать новую работу (на том свете).
  Удачи!

INTRO
  .colorize(:green)

word = File.readlines("#{__dir__}/data/words.txt", encoding: 'UTF-8', chomp: true).sample

game = Game.new(word)
console_interface = ConsoleInterface.new(game)

puts "Слово загадано! У вас #{Game::MAX_ATTEMPTS} попыток!".colorize(:green)

until game.over?
  console_interface.draw
  letter = console_interface.get_input
  game.try!(letter)
end

console_interface.draw
