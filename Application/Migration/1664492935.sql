CREATE TABLE qualifications (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
ALTER TABLE qualifications ADD CONSTRAINT qualifications_name_key UNIQUE(name);
CREATE TABLE clinicians_qualifications (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    qualification_id UUID NOT NULL
);
CREATE INDEX clinicians_qualifications_clinician_id_index ON clinicians_qualifications (clinician_id);
CREATE INDEX clinicians_qualifications_qualification_id_index ON clinicians_qualifications (qualification_id);
ALTER TABLE clinicians_qualifications ADD CONSTRAINT clinicians_qualifications_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_qualifications ADD CONSTRAINT clinicians_qualifications_ref_qualification_id FOREIGN KEY (qualification_id) REFERENCES qualifications (id) ON DELETE NO ACTION;
