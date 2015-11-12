require 'active_support'
require 'active_support/core_ext/string'

class Module
  def mi_const_set(const_name, values)
    self.const_set( const_name, values.collect do |v|
                    nv = v.to_s.underscore
                    self.const_set(v, nv)
                    nv
                  end )
  end
end