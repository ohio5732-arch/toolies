local RunService = game:GetService("RunService")
local engine = {
  cache = {},
}

function engine.init(self: engine, folder: Folder) 
  for _, module in pairs(folder:GetDescendants()) do 
    if module:IsA("ModuleScript") then
      if require(module).init then 
        require(module):init()
      end

      if require(module).step then 
        self.cache[module.Name] = require(module)
      end
    end
  end
end

function engine.simulate(self: engine)
  RunService:BindToSimulation(function(deltaTime: number)
    for _, module in self.cache do 
      module:step(deltaTime)
    end 
  end)
end

function engine.start(self: engine) 
  self:simulate()
end

type engine = typeof(engine)

return engine
