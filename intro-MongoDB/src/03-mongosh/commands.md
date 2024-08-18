
# Connect to container
```sh
docker-compose exec mongodb bash
```
# Connect with mongosh
```sh
mongosh "mongodb://root:SetaServerIdentifi3r@localhost:27017/?tls=false"

mongosh "mongodb://alihil:SetaServerIdentifi3r@localhost:27017/?tls=false"
```
```sh
show dbs
show collections
```
```sh
use("platzi_store")
db.products.find()
```
