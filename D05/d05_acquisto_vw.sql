create or replace view d05_acquisto_vw as
select a.id,
       a.fornitore_id,
       f.fornitore,
       a.prodotto_id,
       p.prodotto,
       p.tipo_prodotto_id,
       tp.tipo_prodotto,
       a.data,
       a.quantita,
       p.prezzo_acquisto*a.quantita as importo
  from d05_acquisto a
  join d05_fornitore f      on a.fornitore_id     = f.id
  join d05_prodotto p       on a.prodotto_id      = p.id
  join d05_tipo_prodotto tp on p.tipo_prodotto_id = tp.id;
