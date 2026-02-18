{{
    config(
        materialized='table',
        post_hook="EXECUTE NOTEBOOK MIKE_FULLER_DEMO.PUBLIC.MIKE_F_TEST()"
    )
}}

select 1 as dummy