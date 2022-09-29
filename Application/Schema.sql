-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE clinicians (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT DEFAULT NULL UNIQUE,
    phone_number TEXT DEFAULT NULL,
    profile_portrait TEXT DEFAULT NULL
);
CREATE TABLE specialties (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE clinicians_specialties (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    specialty_id UUID NOT NULL
);
CREATE INDEX clinicians_specialties_clinician_id_index ON clinicians_specialties (clinician_id);
CREATE INDEX clinicians_specialties_specialty_id_index ON clinicians_specialties (specialty_id);
ALTER TABLE clinicians_specialties ADD CONSTRAINT clinicians_specialties_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_specialties ADD CONSTRAINT clinicians_specialties_ref_specialty_id FOREIGN KEY (specialty_id) REFERENCES specialties (id) ON DELETE NO ACTION;
