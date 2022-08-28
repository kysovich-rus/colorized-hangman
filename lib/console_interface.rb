class ConsoleInterface
  FIGURES = Dir["#{__dir__}/../data/figures/*.txt"].sort.map { |filename| File.read(filename) }

  def initialize(game)
    @game = game
  end

  def draw
    puts <<~GAME_SCREEN

      Слово: #{show_word}
      #{figure}
    GAME_SCREEN
      .colorize(:yellow)

    puts <<~ERROR_MSG
      Ошибки (#{@game.wrongs.size}): #{show_wrongs}
      Осталось ошибок: #{@game.attempts_left}

    ERROR_MSG
      .colorize(:red)

    if @game.won?
      puts 'Победа!'.colorize(:light_green)
    elsif @game.lost?
      puts "Помянем молодого, словом было #{@game.word}".colorize(:red)
    end
  end

  def get_input
    print 'Введите букву: '.colorize(:blue)
    $stdin.gets[0].upcase
  end

  def figure
    FIGURES[@game.wrongs.size]
  end

  def show_word
    @game.unguessed_letters.map{ |letter| letter || '_' }.join(' ')
  end

  def show_wrongs
    @game.wrongs.join(', ')
  end
end
