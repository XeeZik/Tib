-- Classe Instance
Instance = {}
Instances = {}
instances_abertas = true

 function Instance:new(id, cidade, pos)
	
	 return setmetatable({
	 
			id = id, 
			cidade = cidade,
			usando = false,
			posA = pos[1],
			posB = pos[2]
			
	 }, { __index = self }) 
 end
setmetatable(Instances, { __call = function(self, cidade, pos) 
									local id = #Instances+1
									Instances[id] = Instance:new(id, cidade, pos) 
								end })

	

function Instance:getFree(cidade) -- retorna uma instance livre
	if instances_abertas then	
		for k,v in pairs(Instances) do
			if v.cidade == cidade and v.usando == false then	
				return k
			end
		end
	end
	return false
end

function Instance:register()
	self.usando = true
end

function Instance:unregister()
	self.usando = false	
end

function Instance:getMaps()
maps = {}
	for _, v in pairs(Instances) do
		maps[v.cidade] = true
	end
	return maps
end