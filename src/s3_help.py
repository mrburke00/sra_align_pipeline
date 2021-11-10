with open('tmp.txt') as f:
    lines = f.readlines()
sra_dict = {}
for line in lines: 
    line = line.strip()
    line = line.split('/')
    if line[0] not in sra_dict.keys(): # check if sample name already added
        sra_dict[line[0]] = [line[1]]
    elif line[0] in sra_dict.keys(): # if sample name already found then we want to 
        temp = sra_dict[line[0]]     # add another entry 
        temp.append(line[1])
        sra_dict[line[0]] = temp
        
# write parsed sra numbers to text file
with open('out.txt', 'w') as file:
    for key, value in sra_dict.items():
        line = key +' '
        line += ' '.join(value[:])
        file.write(line+'\n')
