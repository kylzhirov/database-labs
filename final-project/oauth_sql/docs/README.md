### OSU API v2 integration

The service fetches a user's recent info in PostgreSQL and provides basic functionality with the given data

#### REST API
- POST `/osu/check`
  - Body examples:
    - `{"command":"o_check beatmaps !user <id>"}` → fetch recent 24h plays (limit 20)
    - `{"command":"o_check best !user <id>"}` → fetch best plays (limit 50)

- GET `/osu/plays/{osuUserId}`
  - Shows up to 100 beatmaps the user has played (last 24h) from local DB `user_plays` table.

- GET `/osu/songs/{osuUserId}?limit=50&offset=0`
  - Shows unique songs for a user using the junction table `user_songs`.

- GET `/osu/songs/compare?u1=<id>&u2=<id>&limit=50&offset=0`
  - Returns counts and the joint song list between two users

#### Command format
- `o_check beatmaps !user <id>`
- `o_check best !user <id>`
#### Configuration
- In `application.properties` set the following variables:
  - `osu.client.id`
  - `osu.client.secret`

#### Backup
- using `pg_dump`:
```
pg_dump -h localhost -U postgres -d auth_db -F c -f backup_$(date +%F).dump
```
- Restore:
```
pg_restore -h localhost -U postgres -d auth_db --clean --if-exists backup_YYYY-MM-DD.dump

