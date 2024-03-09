CREATE OR REPLACE FUNCTION f_correlated_random(random1 float8, random2 float8, correlation float8)
    RETURNS float8 AS
$$
BEGIN
    return correlation * random1 + sqrt(1 - correlation * correlation) * random2;
END;
$$ LANGUAGE plpgsql IMMUTABLE
                    STRICT
                    LEAKPROOF
                    COST 5
                    ROWS 1;

COMMENT ON FUNCTION f_correlated_random(float8, float8, float8) IS 'Use Kaiser-Dickman algorithm to generate random number correlated to first argument (uniformly distributed random number 0 < x < 1); Example usage: f_correlated_random(value, random(), 0.5)';

CREATE OR REPLACE FUNCTION f_correlated_random(random1 float8, correlation float8)
    RETURNS float8 AS
$$
BEGIN
    RETURN correlation * random1 + sqrt(1 - correlation * correlation) * random();
END;
$$ language plpgsql VOLATILE
                    STRICT
                    LEAKPROOF
                    COST 5
                    ROWS 1;

COMMENT ON FUNCTION f_correlated_random(float8, float8) IS 'Use Kaiser-Dickman algorithm to generate random number correlated to first argument; Example usage: f_correlated_random(value, 0.5)';
