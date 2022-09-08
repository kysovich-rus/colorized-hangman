class Game
  MAX_ATTEMPTS = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def attempts_left
    MAX_ATTEMPTS - wrongs.size
  end

  def normalize_letter(letter)
    return 'E' if letter == 'Ё'
    return 'И' if letter == 'Й'

    letter
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  def try!(letter)
    unless over? || @user_guesses.include?(normalize_letter(letter)) || normalize_letter(letter).strip.empty?
      @user_guesses << normalize_letter(letter)
    end
  end

  def unguessed_letters
    @letters.map { |letter| letter if @user_guesses.include?(normalize_letter(letter)) }
  end

  def word
    @letters.join
  end

  def wrongs
    @user_guesses - normalized_letters
  end

  def over?
    won? || lost?
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def lost?
    attempts_left.zero?
  end
end
