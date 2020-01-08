select id,
       subject_id,
       account_type,
       account_no,
       bank_code,
       bank_name,
       bank_address,
       phone_number,
       default_currency,
       state,
       creator,
       create_at,
       update_at,
       accountor,
       iban,
       bank_simple,
       capital_account_type
from tb_base_account
where subject_id = 1
  AND state = ?
ORDER BY id
