class Array
	def to_graph
		temp=[]
		verticies=self.flatten(1).uniq
		raise "odd verticies" if verticies.size%2==1
		for i in 0...verticies.length
			self.each{|e|
				if e[0]==verticies[i]
					if temp[i]
						temp[i] << verticies.index(e[1])
					else
						temp[i]=[verticies.index(e[1])]
					end
				end
				if e[1]==verticies[i]
					if temp[i]
						temp[i] << verticies.index(e[0])
					else
						temp[i]=[verticies.index(e[0])]
					end
				end
			}
		end
		return Graph.new(temp)
	end
end

class Graph < Array
	def initialize(x=0,*y)
		super(x,*y)
	end

	def cut_off!
		if i=self.index{|e| e and e.length==1}
			j=self[i][0]
			self[j].each{|k|
				if k!=i and self[k].length==1
					return false
				else
					self[k].delete(j)
				end
			}
			self[i]=nil
			self[j]=nil
			unless self.cut_off!
				return false
			end
		end
		return true
	end
end
