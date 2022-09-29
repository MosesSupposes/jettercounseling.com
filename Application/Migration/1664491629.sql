CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TYPE job_status AS ENUM ('job_status_not_started', 'job_status_running', 'job_status_failed', 'job_status_timed_out', 'job_status_succeeded', 'job_status_retry');
CREATE FUNCTION ihp_user_id() RETURNS UUID AS $$SELECT NULLIF(current_setting('rls.ihp_user_id'), '')::uuid;$$ language SQL;
CREATE TABLE clinicians (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT DEFAULT null,
    phone_number TEXT DEFAULT null,
    profile_portrait TEXT DEFAULT null
);
ALTER TABLE clinicians ADD CONSTRAINT clinicians_email_key UNIQUE(email);
CREATE TABLE specialties (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
ALTER TABLE specialties ADD CONSTRAINT specialties_name_key UNIQUE(name);
