postgres:
	docker run --name pg -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -p 5431:5432 -d postgres

createdb:
	docker exec -it pg createdb --username=root --owner=root simple_bank
	
dropdb:
	docker exec -it pg dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...

.PHONY: createdb dropdb postgres migrateup migratedown sqlc test