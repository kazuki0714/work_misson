class Animal
  def bark
    p '----------1-----------'
    p 'Yeah, it’s barking.'
  end
end

class Dog < Animal
  attr_accessor :name, :age

  def initialize(name, age=1)
    p '----------2-----------'
    @name = name
    @age = age
  end
end

class MechaDog < Dog

  def initialize(name, age=1)
    p '----------3-----------'
    super(name, age=1)
    @data = { 'apache' => 'apache', 'bsd' => 'mit', 'chef' => 'apache' }
    p '----------4-----------'
    # p @data
    #デバッグ用の試しコード。 「p @data」を出力すると 「{"apache"=>"apache", "bsd"=>"mit", "chef"=>"apache"}」 と表示されるので問題なし
  end

  def proc arg
    path = (arg.split[0]).split('/')[1..-1]
    # この変数の内容が「空(nil)」になっているが、「"bsd => mit"」になるべき
    p '----------5-----------'
    # 上の「p '----------5-----------'」が表示されないということは 「path = (arg.split[0]).split('/')[1..-1]」 がエラーの原因か。split[0]の値を変えてチェック
    # path = (arg.split[-1]).split('/')[1..-1] の場合  mdog.proc "GET /bsd HTTP/1.1" の出力は "1.1 => "
    # path = (arg.split[1]).split('/')[1..-1] の場合  mdog.proc "GET /bsd HTTP/1.1" の出力は "bsd => mit"

    if path.nil?
      keys=[]
      @data.each do |key, _value|
        keys << key
      end
      p '----------6-----------'
      p keys
    elsif path.size == 2
      @data[path[0].chomp] = path[1]
      p '----------7-----------'
      p path[1]
    else
      p '----------8-----------'
      p path[0] + " => " + @data[path[0]].to_s
    end
  end
end

mdog = MechaDog.new('tom')
mdog.bark
p mdog.age
p mdog.name
mdog.proc "GET /bsd HTTP/1.1"
