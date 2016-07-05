class Example
  @range = 1 .. 100

  def self.range= n
    @range = n
  end
  def self.range
    @range
  end

  def initialize
    @number = rand self.class.range
  end
  def number= n
    @number = n
  end
  def number
    @number
  end
end
