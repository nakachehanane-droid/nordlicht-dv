select {{ hash_key('kunden_nr') }} as hk_kunden,md5(concat_ws('||',
    coalesce(vorname, ''),
    coalesce(nachname, ''),
	coalesce(email,''),
	coalesce(strasse,''),
	coalesce(plz,''),
	coalesce(stadt,''),
	coalesce(cast(registriert_am as varchar),'')
)) as hd_kunden,*
from {{ref('stg_shop__kunden')}}
