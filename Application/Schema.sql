-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE clinicians (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT DEFAULT NULL UNIQUE,
    phone_number TEXT DEFAULT NULL,
    profile_portrait TEXT DEFAULT NULL UNIQUE
);
CREATE TABLE specialties (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    name TEXT NOT NULL UNIQUE,
    PRIMARY KEY(id, name)
);
