class Configurator
  def method_missing m, *args
    define_singleton_method m do
      args[0]
    end
  end
end
