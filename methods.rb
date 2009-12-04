require 'rubygems'
require 'haml'

def get_flash
  flash = request.cookies["flash"]
  response.delete_cookie("flash")
  return flash  
end

def set_flash(message)
  response.set_cookie("flash", :value => message, :path => '/')
end

def partial(template, *args)
  options = args.extract_options!
  options.merge!(:layout => false)
  if collection = options.delete(:collection) then
    collection.inject([]) do |buffer, member|
      buffer << haml(template, options.merge(
                                :layout => false, 
                                :locals => {template.to_sym => member}
                              )
                   )
    end.join("\n")
  else
    haml(template, options)
  end
end
