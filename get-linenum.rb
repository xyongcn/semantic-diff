filename1=ARGV[0]
filename2=ARGV[1]
linearray1 = Array.new(100000) #带行号文件的行号，
linearray2 = Array.new(100000) #带行号文件的行号，

def writefile(count,line) 
	

end


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

difffile = File.new("#{filename1}_#{filename2}.astdiff")

file1 =  File.new("#{filename1}","r")#源文件1
file2 =  File.new("#{filename2}","r")#源文件2
outputfile1 = File.new("#{filename1}.out","w+")
outputfile2 = File.new("#{filename2}.out","w+")


count1=0
count2=0

line = difffile.gets#跳过前两行
line = difffile.gets#跳过前两行
start=0
flag=0#判断文件
tag=0#判断差异行的重复次数
while line = difffile.gets
	if line[0,4]=="*** " 
		flag=1
		start = /[0-9]+/.match(line[4,5]).to_s.to_i

	elsif line[0,4]=="--- "
		flag=2
		start = /[0-9]+/.match(line[4,5]).to_s.to_i
	else
		if line[0,2]=="- " 
			if flag==1 and !(linearray1[start] == nil)
				puts "1-#{linearray1[start]}:"+line[2,line.length]
			
				while count1 < linearray1[start]
                                        if tag==1
                                                outputfile1.print("\n")
                                                tag=0
                                        end
                                        line1 = file1.gets
                                        count1+=1
                                        if count1 < linearray1[start]
                                                outputfile1.puts(line1)
                                        end
                                end
                                if tag==0
                                        outputfile1.print(line1[0,line1.length-1])#去掉源代码的回车
                                        tag=1
                                end
                                outputfile1.print(" "+line[2,line.length-3])#去掉语法差异的回车（合并）

			elsif flag==2 and !(linearray2[start] == nil)
				puts "2-#{linearray2[start]}:"+line[2,line.length]

                                while count2 < linearray2[start]
                                        if tag==1
                                                outputfile2.print("\n")
                                                tag=0
                                        end
                                        line2 = file2.gets
                                        count2+=1
                                        if count2 < linearray2[start]
                                                outputfile2.puts(line2)
                                        end
                                end
                                if tag==0
                                        outputfile2.print(line2[0,line2.length-1])
                                        tag=1
                                end
                                outputfile2.print(" "+line[2,line.length-3])

			end
		elsif line[0,2]=="+ "
			if flag==1 and !(linearray1[start] == nil)
				puts "1+#{linearray1[start]}:"+line[2,line.length]

				while count1 < linearray1[start]
                                        if tag==1
                                                outputfile1.print("\n")
                                                tag=0
                                        end
                                        line1 = file1.gets
                                        count1+=1
                                        if count1 < linearray1[start]
                                                outputfile1.puts(line1)
                                        end
                                end
                                if tag==0
                                        outputfile1.print(line1[0,line1.length-1])
                                        tag=1
                                end
                                outputfile1.print(" "+line[2,line.length-3])

			elsif flag==2 and !(linearray2[start] == nil)
				puts "2+#{linearray2[start]}:"+line[2,line.length]
				
                                while count2 < linearray2[start]
                                        if tag==1
                                                outputfile2.print("\n")
                                                tag=0
                                        end
                                        line2 = file2.gets
                                        count2+=1
                                        if count2 < linearray2[start]
                                                outputfile2.puts(line2)
                                        end
                                end
                                if tag==0
                                        outputfile2.print(line2[0,line2.length-1])
                                        tag=1
                                end
                                outputfile2.print(" "+line[2,line.length-3])

			end
		elsif line[0,2]=="! "
			if flag==1 and !(linearray1[start] == nil)
				puts "1!#{linearray1[start]}:"+line[2,line.length]
			
				while count1 < linearray1[start]
                                        if tag==1
                                                outputfile1.print("\n")
                                        	tag=0
					end
                                        line1 = file1.gets
					count1+=1      
                                        if count1 < linearray1[start]
						outputfile1.puts(line1)
					end     
                                end
                                if tag==0
                                        outputfile1.print(line1[0,line1.length-1])
                                        tag=1
                                end
                                outputfile1.print(" "+line[2,line.length-3])


	
			elsif flag==2 and !(linearray2[start] == nil)
				puts "2!#{linearray2[start]}:"+line[2,line.length]

				while count2 < linearray2[start]
                                        if tag==1
                                                outputfile2.print("\n")
                                                tag=0
                                        end
                                        line2 = file2.gets
                                        count2+=1
                                        if count2 < linearray2[start]
                                                outputfile2.puts(line2)
                                        end
                                end
                                if tag==0
                                        outputfile2.print(line2[0,line2.length-1])
                                        tag=1
                                end
                                outputfile2.print(" "+line[2,line.length-3])

			end
		end
		
		start+=1
	end
end
outputfile1.print("\n")
outputfile2.print("\n")
while line1=file1.gets 
	outputfile1.puts(line1)
end
while line2=file2.gets 
        outputfile2.puts(line2)
end



difffile.close()
file1.close()
file2.close()
outputfile1.close()
outputfile2.close()

