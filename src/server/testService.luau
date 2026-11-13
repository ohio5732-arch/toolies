local service = {}

function service.init(self: service) 
  print("hi from server")
end

type service = typeof(service)

return service
