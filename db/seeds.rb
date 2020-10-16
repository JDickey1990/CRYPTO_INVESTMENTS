#create 2 users 
jack = User.create(username: "Jack", password: "password")
jill = User.create(username: "Jill", password: "password")

#create some investments


#user AR to pre-associate data
jack.coins.create(name: "Bitcoin ", symbol: "btc", quantity: 24)
jack.coins.create(name: "Ethereum", symbol: "eth", quantity: 100)

jill.coins.create(name: "Decred", symbol: "dcr", quantity: 1000)
jill.coins.create(name: "Expanse", symbol: "exp", quantity: 5000)