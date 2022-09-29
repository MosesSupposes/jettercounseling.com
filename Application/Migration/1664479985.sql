CREATE TABLE clinicians (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT DEFAULT null,
    phone_number TEXT DEFAULT null,
    profile_portrait TEXT DEFAULT null
);
ALTER TABLE clinicians ADD CONSTRAINT clinicians_email_key UNIQUE(email);
ALTER TABLE clinicians ADD CONSTRAINT clinicians_profile_portrait_key UNIQUE(profile_portrait);
