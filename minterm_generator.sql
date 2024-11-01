CREATE OR REPLACE TYPE MintermGenerator AS OBJECT ( 
    predicates SYS.ODCIVARCHAR2LIST, 
    MEMBER FUNCTION generate_minterms RETURN SYS.ODCIVARCHAR2LIST 
);
CREATE OR REPLACE TYPE BODY MintermGenerator AS 
    MEMBER FUNCTION generate_minterms RETURN SYS.ODCIVARCHAR2LIST IS 
        minterms SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST(); 
        num_predicates INTEGER := predicates.COUNT; 
    BEGIN 
        FOR i IN 0 .. POWER(2, num_predicates) - 1 LOOP 
            DECLARE 
                minterm VARCHAR2(4000) := ''; 
            BEGIN 
                FOR j IN 0 .. num_predicates - 1 LOOP 
                    IF BITAND(i, POWER(2, j)) > 0 THEN 
                        minterm := minterm || predicates(j + 1) || ' '; 
                    END IF; 
                END LOOP; 
                IF minterm IS NOT NULL THEN 
                    minterms.EXTEND; 
                    minterms(minterms.COUNT) := TRIM(minterm); 
                END IF; 
            END; 
        END LOOP; 
        RETURN minterms; 
    END; 
END; 
