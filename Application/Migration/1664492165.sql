CREATE TABLE treatment_approaches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
ALTER TABLE treatment_approaches ADD CONSTRAINT treatment_approaches_name_key UNIQUE(name);
CREATE TABLE clinicians_treatment_approaches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    clinician_id UUID NOT NULL,
    treatment_approach_id UUID NOT NULL
);
CREATE INDEX clinicians_treatment_approaches_clinician_id_index ON clinicians_treatment_approaches (clinician_id);
CREATE INDEX clinicians_treatment_approaches_treatment_approach_id_index ON clinicians_treatment_approaches (treatment_approach_id);
ALTER TABLE clinicians_treatment_approaches ADD CONSTRAINT clinicians_treatment_approaches_ref_clinician_id FOREIGN KEY (clinician_id) REFERENCES clinicians (id) ON DELETE NO ACTION;
ALTER TABLE clinicians_treatment_approaches ADD CONSTRAINT clinicians_treatment_approaches_ref_treatment_approach_id FOREIGN KEY (treatment_approach_id) REFERENCES treatment_approaches (id) ON DELETE NO ACTION;
