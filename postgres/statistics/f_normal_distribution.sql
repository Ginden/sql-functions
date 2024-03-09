CREATE OR REPLACE FUNCTION f_normal_distribution(
    u float8,
    v float8
) RETURNS float8 AS
$$
BEGIN
    RETURN SQRT(-2 * LN(u)) * COS(2 * PI() * v);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

COMMENT ON FUNCTION f_normal_distribution(float8, float8) IS 'This functions converts two parameters (0 < x < 1) into a single value between 0 and 1. It is useful for generating random numbers with a normal distribution.';

CREATE OR REPLACE FUNCTION f_normal_distribution(
    u float8,
    v float8,
    mean float8,
    stddev float8
) RETURNS float8 AS
$$
BEGIN
    RETURN mean + stddev * f_normal_distribution(u, v);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION f_random_normal(
    mean float8,
    stddev float8
) RETURNS float8 AS
$$
BEGIN
    RETURN f_normal_distribution(RANDOM(), RANDOM(), mean, stddev);
END;
$$ LANGUAGE plpgsql VOLATILE
                    STRICT;
