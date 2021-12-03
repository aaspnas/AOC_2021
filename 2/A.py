

import sys

file = sys.argv[1]

# print(file)

handle = open(file, 'r')
dept = 0
length = 0
for line in handle:
    # print("Line: {}".format(line.strip()))
    direction, value = line.split(' ')
    print("Direction: %s Value: %d" % (direction, int(value)))
    match direction:
        case 'up': 
            dept -= int(value)
        case 'down':
            dept += int(value)
        case 'forward':
            length += int(value)

print("Depth ", dept, " length: ", length)     
answer = dept * length
print("Answer: ", answer)

