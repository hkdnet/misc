require 'pry'
class Foo
  FOO__ARG1 = Object.new
  private_constant :FOO__ARG1
  FOO__NAME = Object.new
  private_constant :FOO__NAME


  def foo(_arg1 = FOO__ARG1, name: FOO__NAME)
    unless _arg1.equal?(FOO__ARG1)
      name = _arg1
    end
    if name.equal?(FOO__NAME)
      raise ArgumentError
    end

    puts "name: #{name}"
  end
end

Foo.new.foo(name: 'taro')
Foo.new.foo('hanako')
Foo.new.foo
