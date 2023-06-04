import re
import numpy as np

# get file content
f = open('input.txt', 'r')
input = f.read()
# print(input)

# parse with regex
split_input_pattern = re.compile('\n\n')
elve_calories = split_input_pattern.split(input)

calorie_sums = []
split_calories_pattern = re.compile('\n')
for calories in elve_calories:
    result = split_calories_pattern.split(calories)
    calorie_sums += np.sum(list(map(lambda x: int(x or 0), result)))

print(calorie_sums)

