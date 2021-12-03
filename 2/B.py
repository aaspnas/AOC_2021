

import sys

file = sys.argv[1]

# print(file)

handle = open(file, 'r')
aim = 0
dept = 0
length = 0
for line in handle:
    # print("Line: {}".format(line.strip()))
    direction, value = line.split(' ')

    match direction:
        case 'up': 
            aim -= int(value)
        case 'down':
            aim += int(value)
        case 'forward':
            length += int(value)
            dept += int(value) * aim

    print("Direction: %s Value: %d Aim: %d" % (direction, int(value), aim))

print("Depth ", dept, " length: ", length)     
answer = dept * length
print("Answer: ", answer)