
require 'json'
require 'yaml'

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


  def yaml(*args)
    if args.last.is_a? Hash
      args    = args.dup
      options = args.pop
    else
      options = {}
    end

    retval = YAML.load_file(path(*args))

    sn = options.fetch(:symbolize_names, self.symbolize_names)
    if sn
      recursively_symbolize(retval)
    else
      retval
    end
  end



  def recursively_symbolize(thing)
    if thing.is_a? Hash
      recursively_symbolize_hash(thing)
    elsif thing.is_a? Array
      recursively_symbolize_array(thing)
    else
      thing
    end
  end

  def recursively_symbolize_hash(thing)
    retval = {}
    thing.each do |k, v|
      key       = (k.is_a? String) ? k.to_sym : k
      value     = recursively_symbolize(v)

      retval[key] = value
    end

    retval
  end

  def recursively_symbolize_array(thing)
    thing.map{|e| recursively_symbolize(e) }
  end

end


