#!/usr/bin/env bash
set -euo pipefail

# Cau hinh PostgreSQL va Backend
DB_NAME="appdb"
DB_USER="appuser"
DB_PASSWORD="app_pass_123"
BACKEND_IMAGE="hw-backend:v1"

echo "=== 1. Tao Custom Bridge Network ==="
docker network inspect app-net >/dev/null 2>&1 || \
  docker network create --driver bridge app-net

echo "=== 2. Tao Named Volume ==="
docker volume inspect db-data >/dev/null 2>&1 || \
  docker volume create db-data

echo "=== 3. Don container cu neu ton tai ==="
docker rm -f app-container db-server >/dev/null 2>&1 || true

echo "=== 4. Khoi chay PostgreSQL ==="
docker run -d \
  --name db-server \
  --network app-net \
  --restart unless-stopped \
  -e POSTGRES_DB="$DB_NAME" \
  -e POSTGRES_USER="$DB_USER" \
  -e POSTGRES_PASSWORD="$DB_PASSWORD" \
  -v db-data:/var/lib/postgresql/data \
  postgres:15-alpine

echo "=== 5. Cho PostgreSQL san sang ==="
ready=0
for i in $(seq 1 30); do
  if docker exec db-server pg_isready -U "$DB_USER" -d "$DB_NAME" >/dev/null 2>&1; then
    ready=1
    break
  fi
  sleep 2
done

if [ "$ready" -ne 1 ]; then
  echo "PostgreSQL chua san sang. Kiem tra: docker logs db-server"
  exit 1
fi

echo "=== 6. Tao bang va them du lieu thu ==="
docker exec -i db-server \
  psql -v ON_ERROR_STOP=1 -U "$DB_USER" -d "$DB_NAME" <<'SQL'
create table if not exists persistence_test (
    id integer primary key,
    message varchar(200) not null
);

truncate table persistence_test;

insert into persistence_test (id, message)
values (1, 'Data survives container recreation');
SQL

echo "Du lieu truoc khi xoa container:"
docker exec db-server \
  psql -U "$DB_USER" -d "$DB_NAME" \
  -c "select id, message from persistence_test;"

echo "=== 7. Xoa container Database ==="
docker rm -f db-server

echo "=== 8. Tao lai Database voi cung Named Volume ==="
docker run -d \
  --name db-server \
  --network app-net \
  --restart unless-stopped \
  -e POSTGRES_DB="$DB_NAME" \
  -e POSTGRES_USER="$DB_USER" \
  -e POSTGRES_PASSWORD="$DB_PASSWORD" \
  -v db-data:/var/lib/postgresql/data \
  postgres:15-alpine

echo "=== 9. Cho Database moi san sang ==="
ready=0
for i in $(seq 1 30); do
  if docker exec db-server pg_isready -U "$DB_USER" -d "$DB_NAME" >/dev/null 2>&1; then
    ready=1
    break
  fi
  sleep 2
done

if [ "$ready" -ne 1 ]; then
  echo "Database moi chua san sang. Kiem tra: docker logs db-server"
  exit 1
fi

echo "=== 10. Xac minh du lieu sau khi tao lai container ==="
docker exec db-server \
  psql -v ON_ERROR_STOP=1 -U "$DB_USER" -d "$DB_NAME" \
  -c "select id, message from persistence_test;"

count=$(docker exec db-server \
  psql -tA -U "$DB_USER" -d "$DB_NAME" \
  -c "select count(*) from persistence_test;")

if [ "$count" != "1" ]; then
  echo "FAIL: Du lieu khong dung nhu mong doi."
  exit 1
fi

message=$(docker exec db-server \
  psql -tA -U "$DB_USER" -d "$DB_NAME" \
  -c "select message from persistence_test where id = 1;")

if [ "$message" != "Data survives container recreation" ]; then
  echo "FAIL: Noi dung du lieu khong khop."
  exit 1
fi

echo "PASS: Du lieu van ton tai sau khi xoa va tao lai container DB."

echo "=== 11. Khoi chay Backend tren app-net ==="
docker run -d \
  --name app-container \
  --network app-net \
  -e PORT=3000 \
  -e DB_HOST=db-server \
  -e DB_PORT=5432 \
  -e DB_NAME="$DB_NAME" \
  -e DB_USER="$DB_USER" \
  -e DB_PASSWORD="$DB_PASSWORD" \
  "$BACKEND_IMAGE"

echo "=== 12. Kiem tra DNS tu Backend ==="
docker exec app-container ping -c 2 db-server

echo "=== 13. Thong tin Network va Volume ==="
docker network ls
docker volume ls
docker network inspect app-net

echo "=== 14. Trang thai Container ==="
docker ps -a

echo "HOAN TAT: Network, Volume, DNS va Data Persistence da duoc kiem tra."