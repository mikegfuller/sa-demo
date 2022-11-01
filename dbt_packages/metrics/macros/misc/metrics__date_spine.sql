{% macro metric_get_intervals_between(start_date, end_date, datepart) -%}
    {{ return(adapter.dispatch('metric_get_intervals_between', 'metrics')(start_date, end_date, datepart)) }}
{%- endmacro %}

{% macro default__metric_get_intervals_between(start_date, end_date, datepart) -%}
    {%- call statement('metric_get_intervals_between', fetch_result=True) %}

        select {{ datediff(start_date, end_date, datepart) }}

    {%- endcall -%}

    {%- set value_list = load_result('metric_get_intervals_between') -%}

    {%- if value_list and value_list['data'] -%}
        {%- set values = value_list['data'] | map(attribute=0) | list %}
        {{ return(values[0]) }}
    {%- else -%}
        {{ return(1) }}
    {%- endif -%}

{%- endmacro %}


{% macro metric_date_spine(datepart, start_date, end_date) %}
    {{ return(adapter.dispatch('metric_date_spine', 'metrics')(datepart, start_date, end_date)) }}
{%- endmacro %}

{% macro default__metric_date_spine(datepart, start_date, end_date) %}


{# call as follows:

metric_date_spine(
    "day",
    "to_date('01/01/2016', 'mm/dd/yyyy')",
    "dateadd(week, 1, current_date)"
) #}


with rawdata as (

    {{metrics.metric_generate_series(
        metrics.metric_get_intervals_between(start_date, end_date, datepart)
    )}}

),

all_periods as (

    select (
        {{
            dateadd(
                datepart,
                "row_number() over (order by 1) - 1",
                start_date
            )
        }}
    ) as date_{{datepart}}
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_{{datepart}} <= {{ end_date }}

)

select * from filtered

{% endmacro %}


{% macro metric_get_powers_of_two(upper_bound) %}
    {{ return(adapter.dispatch('metric_get_powers_of_two', 'metrics')(upper_bound)) }}
{% endmacro %}

{% macro default__metric_get_powers_of_two(upper_bound) %}

    {% if upper_bound <= 0 %}
    {{ exceptions.raise_compiler_error("upper bound must be positive") }}
    {% endif %}

    {% for _ in range(1, 100) %}
       {% if upper_bound <= 2 ** loop.index %}{{ return(loop.index) }}{% endif %}
    {% endfor %}

{% endmacro %}


{% macro metric_generate_series(upper_bound) %}
    {{ return(adapter.dispatch('metric_generate_series', 'metrics')(upper_bound)) }}
{% endmacro %}

{% macro default__metric_generate_series(upper_bound) %}

    {% set n = metrics.metric_get_powers_of_two(upper_bound) %}

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    {% for i in range(n) %}
    p{{i}}.generated_number * power(2, {{i}})
    {% if not loop.last %} + {% endif %}
    {% endfor %}
    + 1
    as generated_number

    from

    {% for i in range(n) %}
    p as p{{i}}
    {% if not loop.last %} cross join {% endif %}
    {% endfor %}

    )

    select *
    from unioned
    where generated_number <= {{upper_bound}}
    order by generated_number

{% endmacro %}