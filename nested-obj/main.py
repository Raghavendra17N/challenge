obj= {"a":{"b":{"c":"d"}}}
key = input()
fetch_value = key.split("/")
final_value = obj
for k in fetch_value:
    final_value = final_value.get(k)
print(final_value)