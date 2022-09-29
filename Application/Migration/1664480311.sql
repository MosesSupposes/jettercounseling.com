CREATE TABLE specialties (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY(id, name)
);
ALTER TABLE specialties ADD CONSTRAINT specialties_name_key UNIQUE(name);
