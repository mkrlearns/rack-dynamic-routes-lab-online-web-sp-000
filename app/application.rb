class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = @@items.find { |i| i.name == req.path.split("/items/").last }
      if item; resp.write item.price
      else; resp.status = 400 end
    end

    resp.write "Item not found"; resp.status = 404 if !req.path.match(/items/)
    resp.write "Route not found" if resp.status == 404
    resp.finish
  end
end
