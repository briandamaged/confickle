
require 'json'

class Confickle

  attr_reader :root, :symbolize_names

  def initialize(options)
    if options.is_a? String
      options = {root: options}
    end

    @root            = File.absolute_path(options.fetch(:root))
    @symbolize_names = options.fetch(:symbolize_names, true)
  end


  def path(*args)
    File.join(self.root, *args)
  end

  def content(*args)
    File.read(self.path(*args))
  end
  alias_method :contents, :content

  def json(*args)
    if args.last.is_a? Hash
      args    = args.dup
      options = args.pop
    else
      options = {}
    end

    sn = options.fetch(:symbolize_names, self.symbolize_names)
    JSON.parse(
      self.content(*args),
      symbolize_names: sn
    )
  end


end


