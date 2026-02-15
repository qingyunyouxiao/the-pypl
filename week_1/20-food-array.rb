food = ['bread','milk','eggs','cheese','fruit','vegetables']
puts food.count('milk') # 1
puts food.count('meat') # 0
puts food.count # 6

food << 'meat'
puts food[7]
food << 'potatoes'
puts food[7] # meat
puts food[8] # potatoes

garlic = 12 + 5
food << garlic
puts food[9] # 17