# Takes a path to a scrabble word list file
# Produces an importable list of Words
class ScrabbleParser
  attr_reader :words

  def initialize path
    @path  = path
    @words = []
    parse!
  end

  def import_words!
    words.each { |w| w.save! }
  end

  private

  def parse!
    File.new(@path).each_line do |l|
      l = l.strip
      next if l.length > 10
      next if l.split("").uniq.count < 4
      next if l.include?(" ")
      @words.push Word.new(word: l)
    end
  end
end
