DEFINE start = '01.12.-1'
DEFINE end = '20.01.1'
WITH dt (
    dat_num,
    dat_day
) AS (
    SELECT
        TO_DATE('&start','dd.mm.syyyy') dat_num,
        CASE
                WHEN EXTRACT(YEAR FROM TO_DATE('&start','dd.mm.syyyy') ) > 0 THEN TO_CHAR(TO_DATE('&start','dd.mm.syyyy'),'Day')
                ELSE TO_CHAR(TO_DATE('&start','dd.mm.syyyy') + 2,'Day')
            END
        dat_day
    FROM
        dual
    UNION ALL
    SELECT
        dat_num + 1,
        CASE
                WHEN EXTRACT(YEAR FROM dat_num) > 0 THEN TO_CHAR(dat_num + 1,'Day')
                ELSE TO_CHAR(dat_num + 3,'Day')
            END
    FROM
        dt
    WHERE
        dat_num <= TO_DATE('&end','dd.mm.syyyy')
) SELECT
    TO_CHAR(dat_num,'dd.mm.syyyy') "Выходные",
    CASE
            WHEN dat_num = '01.01.0001' THEN 'Суббота'
            ELSE dat_day
        END
    " "
  FROM
    dt
  WHERE
    TRIM(dat_day) IN (
        'Суббота',
        'Воскресенье',
        'Saturday',
        'Sunday'
    )
    AND   EXTRACT(YEAR FROM dat_num) != '00000'
    OR    dat_num = '01.01.0001'
    AND   dat_num <= TO_DATE('&end','dd.mm.syyyy');
