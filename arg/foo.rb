require 'pry'
class Foo
  FOO__ARG1 = Object.new
  private_constant :FOO__ARG1
  FOO__NAME = Object.new
  private_constant :FOO__NAME


  def foo(_arg1 = FOO__ARG1, name: FOO__NAME)
    unless FOO__ARG1.equal?(_arg1)
      name = _arg1
    end
    if FOO__NAME.equal?(name)
      raise ArgumentError
    end

    puts "name: #{name}"
  end
end

Foo.new.foo(name: 'taro')
Foo.new.foo('hanako')
Foo.new.foo
