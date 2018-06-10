require 'pry'
class Foo
  FOO__ARG1 = Object.new
  private_constant :FOO__ARG1

  def foo(_arg1 = FOO__ARG1, name: _arg1)
    if FOO__ARG1.equal?(name)
      raise ArgumentError
    end

    puts "name: #{name}"
  end
end

Foo.new.foo(name: 'taro')
Foo.new.foo('hanako')
Foo.new.foo
