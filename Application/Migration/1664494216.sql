CREATE TABLE licenses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
ALTER TABLE licenses ADD CONSTRAINT licenses_name_key UNIQUE(name);
CREATE TABLE qualifications_licenses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    qualification_id UUID NOT NULL,
    license_id UUID NOT NULL
);
CREATE INDEX qualifications_licenses_qualification_id_index ON qualifications_licenses (qualification_id);
CREATE INDEX qualifications_licenses_license_id_index ON qualifications_licenses (license_id);
ALTER TABLE qualifications_licenses ADD CONSTRAINT qualifications_licenses_ref_license_id FOREIGN KEY (license_id) REFERENCES licenses (id) ON DELETE NO ACTION;
ALTER TABLE qualifications_licenses ADD CONSTRAINT qualifications_licenses_ref_qualification_id FOREIGN KEY (qualification_id) REFERENCES qualifications (id) ON DELETE NO ACTION;
