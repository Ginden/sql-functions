CREATE OR REPLACE FUNCTION f_is_json(tested_string text)
    RETURNS boolean AS
$$
DECLARE
    jsonb_test jsonb;
BEGIN
    BEGIN
        jsonb_test := tested_string::jsonb;
        RETURN TRUE;
    EXCEPTION
        WHEN others THEN
            RETURN FALSE;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE
                    STRICT;

COMMENT ON FUNCTION f_is_json(text) IS 'Check if a string is a valid JSON; This is an expensive operation due to subtransaction involved.';
