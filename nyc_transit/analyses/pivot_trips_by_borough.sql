{% set borough_list = dbt_utils.get_column_values(ref('mart__fact_trips_by_borough'), 'borough') %}

select
    {{ dbt_utils.pivot(
        column='borough',
        values=borough_list,
        agg='sum',
        then_value='number_of_trips'
    ) }}
from {{ ref('mart__fact_trips_by_borough') }}
