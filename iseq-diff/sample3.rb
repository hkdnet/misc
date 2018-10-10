class Foo
  # todo: nya-n
  def no_body
  end

  def show(_mode)
    if _mode; puts :a else puts 1 || 2; end
    end
end

module Main
end
def Main.exec
  Foo.new.show(false)
end

Main::exec
