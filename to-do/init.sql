BEGIN;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR( 255 )  NOT NULL,
    password VARCHAR( 255 )  NOT NULL
);

CREATE TABLE IF NOT EXISTS todos (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    user_id INTEGER NOT NULL REFERENCES "users"("id") ON DELETE CASCADE
);

INSERT INTO users (username, password) VALUES ('admin', 'admin');

COMMIT;
