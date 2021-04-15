select
order_id,
{% for payment_method in ["bank_transfer", "credit_card", "gift_card"] %}

sum(case when payment_method = '{{payment_method}}' then amount  else 0 end) as {{payment_method}}_amount
    {%- if not loop.last -%}
        ,
    {% endif %}
{% endfor %}
,
sum(amount) as total_amount
from {{ ref('stg_payments') }}
group by 1