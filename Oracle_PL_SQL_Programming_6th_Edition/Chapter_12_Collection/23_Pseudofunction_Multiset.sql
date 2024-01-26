create table birds
(
gunus varchar2(128),
species varchar2(128),
color color_va_ty,
primary key(gunus, species)
);
/


create table birds_habitats
(
gunus varchar2(128),
species varchar2(128),
country varchar2(30),
foreign key(gunus, species) references birds(gunus, species)
);
/

create or replace type country_n_ty is table of varchar2(30);
/

insert into birds
  (gunus, species, color)
values
  ('bird_1', 'species_1_a', color_va_ty('blue', 'green'));

insert into birds
  (gunus, species, color)
values
  ('bird_1', 'species_1_b', color_va_ty('blue-gray', 'green'));

insert into birds
  (gunus, species, color)
values
  ('bird_2', 'species_2', color_va_ty('gray'));

commit;
/

insert into birds_habitats
  (gunus, species, country)
values
  ('bird_1', 'species_1_a', 'iran');
  
insert into birds_habitats
  (gunus, species, country)
values
  ('bird_1', 'species_1_a', 'norway');
  
insert into birds_habitats
  (gunus, species, country)
values
  ('bird_1', 'species_1_b', 'iran');
  
insert into birds_habitats
  (gunus, species, country)
values
  ('bird_2', 'species_2', 'norway');
commit;
/

select b.gunus,
       b.species,
       b.color,
       cast(multiset (select bh.country
               from birds_habitats bh
              where bh.gunus = b.gunus
                and bh.species = b.species) as country_n_ty) countries
  from birds b
