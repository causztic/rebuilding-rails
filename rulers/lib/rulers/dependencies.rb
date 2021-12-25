# Rails version: https://github.com/rails/rails/blob/main/activesupport/lib/active_support/dependencies.rb
class Object
  def self.const_missing(c)
    # class variable to keep a map of constant names: 
    # if value not found, require the respective file and attempt to find a similarly named class/module 

    @looked_for ||= {}
    const_name = c.to_s
    raise "#{const_name} not found." if @looked_for[const_name]
    
    @looked_for[const_name] = 1
    file = Rulers.to_underscore(c.to_s)
    require file

    begin
      Object.const_get(c)
    rescue RuntimeError
      raise "#{const_name} not found in #{file}" 
    end
  end
end