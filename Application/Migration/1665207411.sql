ALTER TABLE clinicians RENAME COLUMN profile_portrait TO profile_pic;
ALTER TABLE clinicians ADD COLUMN gender TEXT DEFAULT null;
ALTER TABLE clinicians ADD COLUMN bio TEXT DEFAULT null;
ALTER TABLE clinicians ADD COLUMN race_and_ethnicity TEXT DEFAULT null;
