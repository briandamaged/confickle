
class Confickle

  attr_reader :root, :symbolize_names

  def initialize(options = {})
    if options.is_a? String
      options = {root: options}
    end

    @root            = options.fetch(:root)
    @symbolize_names = options.fetch(:symbolize_names, true)
  end


  def path(*args)
    File.join(self.root, *args)
  end

  def content(*args)
    File.read(self.path(*args))
  end

  def json(*args)
    JSON.parse(self.content(*args), symbolize_names: true)
  end


end


