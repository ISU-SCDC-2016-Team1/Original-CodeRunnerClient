class Configurator
  def method_missing m, *args
    self.class.send(:define_method, m) do
      args[0]
    end
  end
end
