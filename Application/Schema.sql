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
CREATE TABLE treatment_approaches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE clinicians_treatment_approaches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    treatment_approach_id UUID NOT NULL
);
CREATE INDEX clinicians_treatment_approaches_clinician_id_index ON clinicians_treatment_approaches (clinician_id);
CREATE INDEX clinicians_treatment_approaches_treatment_approach_id_index ON clinicians_treatment_approaches (treatment_approach_id);
CREATE TABLE qualifications (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE clinicians_qualifications (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    qualification_id UUID NOT NULL
);
CREATE INDEX clinicians_qualifications_clinician_id_index ON clinicians_qualifications (clinician_id);
CREATE INDEX clinicians_qualifications_qualification_id_index ON clinicians_qualifications (qualification_id);
ALTER TABLE clinicians_qualifications ADD CONSTRAINT clinicians_qualifications_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_qualifications ADD CONSTRAINT clinicians_qualifications_ref_qualification_id FOREIGN KEY (qualification_id) REFERENCES qualifications (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_specialties ADD CONSTRAINT clinicians_specialties_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_specialties ADD CONSTRAINT clinicians_specialties_ref_specialty_id FOREIGN KEY (specialty_id) REFERENCES specialties (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_treatment_approaches ADD CONSTRAINT clinicians_treatment_approaches_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_treatment_approaches ADD CONSTRAINT clinicians_treatment_approaches_ref_treatment_approach_id FOREIGN KEY (treatment_approach_id) REFERENCES treatment_approaches (id) ON DELETE NO ACTION;
