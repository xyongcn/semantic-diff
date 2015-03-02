filename1="hello.c"
filename2="hello2.c"
linearray1 = Array.new(100000) #带行号文件的行号，
linearray2 = Array.new(100000) #带行号文件的行号，


file1 = File.new("#{filename1}.lcfg")

linenum = 1
while line = file1.gets
	#/;; Function/.match(line)

	col = line.index("\[#{filename1} :")
	if col ==nil
	else		
		tnum = /^[0-9]+/.match(line[col+4+filename1.length,line.length-1])		
		linearray1[linenum] = tnum.to_s.to_i
	#	puts linearray1[linenum]
	end
	linenum+=1
end


file2 = File.new("#{filename2}.lcfg")

linenum = 1
while line = file2.gets
	#/;; Function/.match(line)

	col = line.index("\[#{filename2} :")
	if col ==nil
	else		
		tnum = /^[0-9]+/.match(line[col+4+filename2.length,line.length-1])		
		linearray2[linenum] = tnum.to_s.to_i
	#	puts linearray2[linenum]
	end
	linenum+=1
end

file1.close()
file2.close()

difffile = File.new("#{filename1}_#{filename2}.diff")
line = difffile.gets
line = difffile.gets
start=0
flag=0
while line = difffile.gets
	if line[0,4]=="*** " 
		flag=1
		start = /[0-9]+/.match(line[4,5]).to_s.to_i

	elsif line[0,4]=="--- "
		flag=2
		start = /[0-9]+/.match(line[4,5]).to_s.to_i
	else
		if line[0,2]=="- " 
			if linearray1[start] == nil
			else
				puts "-#{linearray1[start]}:"+line[2,line.length]
			end
		elsif line[0,2]=="+ "
			if linearray2[start] == nil
			else
				puts "+#{linearray2[start]}:"+line[2,line.length]
			end
		elsif line[0,2]=="! "
			if flag==1 and !(linearray1[start] == nil)
				puts "-#{linearray1[start]}:"+line[2,line.length]
			elsif flag==2 and !(linearray2[start] == nil)
				puts "+#{linearray2[start]}:"+line[2,line.length]
			end
		end
		
		start+=1
	end
end
difffile.close()


