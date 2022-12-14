-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE counselors (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT DEFAULT NULL UNIQUE,
    phone_number TEXT DEFAULT NULL,
    profile_pic TEXT DEFAULT NULL,
    gender TEXT DEFAULT NULL,
    bio TEXT DEFAULT NULL,
    race_and_ethnicity TEXT DEFAULT NULL
);
CREATE TABLE specialties (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE counselors_specialties (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    specialty_id UUID NOT NULL
);
CREATE INDEX counselors_specialties_clinician_id_index ON counselors_specialties (clinician_id);
CREATE INDEX counselors_specialties_specialty_id_index ON counselors_specialties (specialty_id);
CREATE TABLE treatment_approaches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE counselors_treatment_approaches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    treatment_approach_id UUID NOT NULL
);
CREATE INDEX counselors_treatment_approaches_clinician_id_index ON counselors_treatment_approaches (clinician_id);
CREATE INDEX counselors_treatment_approaches_treatment_approach_id_index ON counselors_treatment_approaches (treatment_approach_id);
CREATE TABLE qualifications (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    years_in_practice TEXT NOT NULL,
    school TEXT NOT NULL,
    counselor_id UUID NOT NULL UNIQUE
);
CREATE INDEX qualifications_counselor_id_index ON qualifications (counselor_id);
CREATE TABLE licenses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE qualifications_licenses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    qualification_id UUID NOT NULL,
    license_id UUID NOT NULL
);
CREATE INDEX qualifications_licenses_qualification_id_index ON qualifications_licenses (qualification_id);
CREATE INDEX qualifications_licenses_license_id_index ON qualifications_licenses (license_id);
ALTER TABLE counselors_specialties ADD CONSTRAINT counselors_specialties_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES counselors (id) ON DELETE CASCADE;
ALTER TABLE counselors_specialties ADD CONSTRAINT counselors_specialties_ref_specialty_id FOREIGN KEY (specialty_id) REFERENCES specialties (id) ON DELETE CASCADE;
ALTER TABLE counselors_treatment_approaches ADD CONSTRAINT counselors_treatment_approaches_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES counselors (id) ON DELETE CASCADE;
ALTER TABLE counselors_treatment_approaches ADD CONSTRAINT counselors_treatment_approaches_ref_treatment_approach_id FOREIGN KEY (treatment_approach_id) REFERENCES treatment_approaches (id) ON DELETE CASCADE;
ALTER TABLE qualifications_licenses ADD CONSTRAINT qualifications_licenses_ref_license_id FOREIGN KEY (license_id) REFERENCES licenses (id) ON DELETE CASCADE;
ALTER TABLE qualifications_licenses ADD CONSTRAINT qualifications_licenses_ref_qualification_id FOREIGN KEY (qualification_id) REFERENCES qualifications (id) ON DELETE CASCADE;
ALTER TABLE qualifications ADD CONSTRAINT qualifications_ref_counselor_id FOREIGN KEY (counselor_id) REFERENCES counselors (id) ON DELETE CASCADE;
