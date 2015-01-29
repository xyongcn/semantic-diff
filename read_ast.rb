tree = Array.new(10000) 
useful_node = Array.new(200) 
direct_index = Array.new(10000) 


file1 = File.new("1.fun")

tree_count=0

while line = file1.gets

	if line.include?";; Function"#判断是不是;; Funtion fun ，是就，获取函数名，跳过3行 
		line = file1.gets
		line = file1.gets
		next
	end
	num= /^@[0-9]+/.match(line)
	#puts num
	#puts line
	if num == nil   #判断起始字符是不是＠n
		if line.length > 0  #判断是不是节点内容（前面有空格）
			len = tree[tree_count]
			line = line.gsub(/ +/," ")
			len =len + line
			len =len.gsub("\n","")
			tree[tree_count] = len
			#puts tree[tree_count]
		else #空行，就是函数结束
			break
		end
	else
		post = num.post_match.gsub(/ +/," ")
		tree_count = num.to_s.gsub("@","")
		tree_count = tree_count.to_i
		tree[tree_count] = post[1,post.length-2]
		
	end
end
i=1
j=1

while i<= tree_count #获取有用节点信息(待定)
	if tree[i].include?"var_decl"
		useful_node[j] = tree[i]
		j=j+1
	elsif tree[i].include?"_cst"
		useful_node[j] = tree[i]
		j=j+1
	elsif tree[i].include?"parm_decl"
		useful_node[j] = tree[i]
		j=j+1
	elsif tree[i].include?"nop_expr"
		useful_node[j] = tree[i]
		j=j+1
	elsif tree[i].include?"modify_expr"
		useful_node[j] = tree[i]
		j=j+1
	end
	i+=1
end

useful_count= j-1
i=1

while i<= useful_count 
	tline = useful_node[i]
	#puts tline


	while 	1==1       #广度优先遍历有用节点
		pos = tline.index('@')
		if pos == nil
			break
		end
		node_index = /^[0-9]+/.match(tline[pos+1..-1])		
		puts node_index #索引

		node_index = node_index.to_s.to_i
		#深搜寻找叶子节点(找第一个属性，identifier_node,找strg)


		sub_node = tree[node_index]
		tnode_index = node_index
		if direct_index[node_index]==nil#优化	
		else 
			puts "already"
			tline = tline[pos+1..-1]#继续下一个结点
			next
		end
		while 1==1
			if /^identifier_node/.match(sub_node)
				#puts tree[node_index]
				puts /strg: [A-Za-z_]+ lngt: [0-9]/.match(sub_node)
				#建立直接索引
				direct_index[node_index] = tnode_index

				break
			else
				tpos = sub_node.index('@')
				tnode_index = /^[0-9]+/.match(sub_node[tpos+1..-1])
				tnode_index = tnode_index.to_s.to_i
				sub_node = tree[tnode_index]
			end
		end


 
		tline = tline[pos+1..-1]#继续下一个结点
	end
	i+=1
end



















