select {{ hash_key('kunden_nr') }} as hk_kunden,*
from {{ref('stg_shop__kunden')}}
