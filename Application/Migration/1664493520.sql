DROP TABLE clinicians_qualifications;
ALTER TABLE qualifications RENAME COLUMN name TO years_in_practice;
ALTER TABLE qualifications ADD COLUMN school TEXT NOT NULL;
ALTER TABLE qualifications ADD COLUMN clinician_id UUID NOT NULL;
ALTER TABLE qualifications DROP CONSTRAINT qualifications_name_key;
ALTER TABLE qualifications ADD CONSTRAINT qualifications_clinician_id_key UNIQUE(clinician_id);
CREATE INDEX qualifications_clinician_id_index ON qualifications (clinician_id);
ALTER TABLE qualifications ADD CONSTRAINT qualifications_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
