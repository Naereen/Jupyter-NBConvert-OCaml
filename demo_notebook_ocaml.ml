(*
This OCaml script was exported from a Jupyter notebook
using an open-source software (under the MIT License) written by @Naereen
from https://github.com/Naereen/Jupyter-Notebook-OCaml
This software is still in development, please notify me of a bug at
https://github.com/Naereen/Jupyter-Notebook-OCaml/issues/new if you find one
*)


(* # Exercice d'algorithmique - Agrégation Option Informatique
## Préparation à l'agrégation - ENS de Rennes, 2016-17
- *Date* : 29 août 2017
- *Auteur* : [Lilian Besson](https://GitHub.com/Naereen/notebooks/) *)

(* ## À propos de ce document
- Ceci est une *proposition* de correction, pour un exercice (simple) d'algorithmique, pour la préparation à l'[agrégation de mathématiques, option informatique](http://Agreg.org/Textes/).
- Ce document est un [notebook Jupyter](https://www.Jupyter.org/), et [est open-source sous Licence MIT sur GitHub](https://github.com/Naereen/notebooks/tree/master/agreg/), comme les autres solutions de textes de modélisation que [j](https://GitHub.com/Naereen)'ai écrite cette année.
- L'implémentation sera faite en OCaml, version 4+ : *)

Sys.command "ocaml -version";;

(* ----

## Le problème : tri à bulles et tri cocktail

On s'intéresse à deux algorithmes de tris.
Pour plus de détails, voir les pages Wikipédia (ou le [Cormen] par exemple) :

- [Tri à bulle](https://fr.wikipedia.org/wiki/Tri_%C3%A0_bulles),
- [Tri cocktail](https://fr.wikipedia.org/wiki/Tri_cocktail).

On veut implémenter les deux et les comparer, sur plein d'entrées. *)

(* ----

## Tri à bulles

Commençons par le plus classique. *)

(** Un échange T[i] <-> T[j]. Utilise une valeur temporaire *)
let swap tab i j =
    let tmp = tab.(i) in
    tab.(i) <- tab.(j);
    tab.(j) <- tmp
;;

(* Le tri à bulle a une complexité en $\mathcal{O}(n^2)$ dans le pire des cas et en moyenne.
Il a l'avantage d'être en place. *)

let tri_bulle cmp tab =
    let n = Array.length tab in
    for i = n - 1 downto 1 do
        for j = 0 to i - 1 do
            if cmp tab.(j + 1) tab.(j) < 0 then
                swap tab (j + 1) j;
        done
    done
;;

(* On utilise une fonction de comparaison générique. La fonction ``compare`` ([``Pervasives.compare``](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html#VALcompare)) fonctionne pour tous les types par défaut. *)

(* Une version plus efficace existe aussi ([voir ces explications](https://fr.wikipedia.org/wiki/Tri_%C3%A0_bulles#Principe_et_pseudo-code)). *)

let tri_bulle_opt cmp tab =
    let n = Array.length tab in
    let i = ref 0 in
    let last_swap = ref (-1) in
    while !i < n - 1 do
        (* séquence d'échanges sur T[i..n]: *)
        last_swap := n - 1;
        for j = n-1 downto !i + 1 do
            if cmp tab.(j) tab.(j-1) < 0 then begin
                swap tab j (j-1);
                last_swap := j - 1
            end;
            (* i avance "plus vite" :*)
            i := !last_swap + 1;
        done
    done
;;

(* ----

## Tests

On fait quelques tests. *)

(* ### Utilitaire pour des tests *)

(** Taille max des éléments dans les tableaux aléatoires *)
let maxint = int_of_float(1e3);;

(** Créer un tableau aléatoire. En O(n). *)
let rand_array length =
    Array.init length (fun _ -> Random.int maxint)
;; 

(** Vérifie que chaque élément du tableau n'y est qu'une seule fois (test l'égalité <> et pas !==).
    Mal codé, en O(n^2). *)
let isInjArray tab =
    try begin
        Array.iteri (fun i x -> 
            (Array.iteri (fun j y -> 
                assert( (x<>y) || (i=j) ) 
            ) tab) 
        ) tab;
        true
        end
    with _ -> false
;;

(** En moyenne, est en O(n^2) si [maxint] est bien plus grand que [n]. *)
let rand_array_inj = function
    | 0 -> [||]
    | length ->
        let tab = ref (rand_array length) in
        while not(isInjArray (!tab)) do
            tab := rand_array length;
        done;
        !tab
;;

(* Cette fonction prend un seul argument, la taille du tableau : *)

rand_array_inj 12;;

rand_array_inj 12;;

rand_array_inj 12;;

(* Fonction de test : *)

let print = Printf.printf;; 

let testtri mysort cmp length nbrun () =
    print "Test d'un tri, %i simulations avec des tableaux de longueur %i.\n " nbrun length;
    for i = 0 to nbrun - 1 do
        let t1 = rand_array length in
        let t2 = Array.copy t1 in
        mysort cmp t1;
        Array.fast_sort cmp t2;
        try assert( t1 = t2 ) with _ -> begin
            print "Avec des tableaux de taille %i, le test numéro %i a échoué." length i;
            Format.printf "@[t1=[|"; Array.iter (fun i -> Format.printf " %i;" i) t1; Format.printf "|]@]@ ";
            Format.printf "@[t2=[|"; Array.iter (fun i -> Format.printf " %i;" i) t2; Format.printf "|]@]@ ";
        end;
    done;
    flush_all ();
;;

(* ### Tests du tri à bulle *)

(* La fonction de tri par défaut marche bien, évidemment. *)

testtri Array.sort compare 10 10 ();;

testtri tri_bulle compare 10 10 ();;

testtri tri_bulle_opt compare 10 10 ();;

(* Ça marche ! *)

testtri tri_bulle compare 100 1000 ();;

(* ----

## Tri cocktail *)

(* Il est très semblable au tri à bulle, sauf que le tableau sera parcouru alternativement dans les eux sens.

Le tri cocktail a une complexité en $\mathcal{O}(n^2)$ dans le pire des cas et en moyenne.
Il a l'avantage d'être en place. *)

let tri_cocktail cmp tab =
    let n = Array.length tab in
    let echange = ref true in
    while !echange do
        echange := false;
        (* Parcours croissant *)
        for j = 0 to n - 2 do
            if cmp tab.(j + 1) tab.(j) < 0 then begin
                swap tab (j + 1) j;
                echange := true
            end;
        done;
        (* Parcours decroissant *)
        for j = n - 2 downto 0 do
            if cmp tab.(j + 1) tab.(j) < 0 then begin
                swap tab (j + 1) j;
                echange := true
            end;
        done;
    done;
;;

(* Il existe aussi une version plus efficace, qui diminue la taille des parcours au fur et à mesure. *)

let tri_cocktail_opt cmp tab =
    let n = Array.length tab in
    let echange = ref true in
    let debut = ref 0 and fin = ref (n - 2) in
    while !echange do
        echange := false;
        (* Parcours croissant *)
        for j = !debut to !fin do
            if cmp tab.(j + 1) tab.(j) < 0 then begin
                swap tab (j + 1) j;
                echange := true
            end;
        done;
        fin := !fin - 1;
        (* Parcours decroissant *)
        for j = !fin downto !debut do
            if cmp tab.(j + 1) tab.(j) < 0 then begin
                swap tab (j + 1) j;
                echange := true
            end;
        done;
        debut := !debut + 1;
    done;
;;

(* ----

## Tests
Et d'autres tests. *)

testtri tri_cocktail compare 10 10 ();;

testtri tri_cocktail_opt compare 10 10 ();;

(* Ça marche ! *)

testtri tri_cocktail compare 100 1000 ();;

(* ----

## Comparaison *)

(* Avec [ce morceau de code](https://stackoverflow.com/a/9061574/) on peut facilement mesurer le temps d'exécution : *)

let time f =
    let t = Sys.time() in
    let res = f () in
    Printf.printf "    Temps en secondes: %fs\n" (Sys.time() -. t);
    flush_all ();
    res
;;

(* ### Première comparaison : $n = 100$ *)

time (testtri Array.sort compare 100 10000);;

time (testtri tri_bulle compare 100 10000);;

time (testtri tri_bulle_opt compare 100 10000);;

time (testtri tri_cocktail compare 100 10000);;

time (testtri tri_cocktail_opt compare 100 10000);;

(* Sur de petits tableaux, les versions "optimisées" ne sont pas plus forcément plus rapides (comme toujours).

On vérifie quand même que sur des tableaux aléatoires, le tri cocktail optimisé semble le plus rapide des quatre implémentations. *)

(* ### Autre comparaison : $n = 1000$

Ca suffit à voir que les quatre algorithmes implémentés ici ne sont pas en temps sous quadratique. *)

time (testtri Array.sort compare 1000 1000);;

time (testtri tri_bulle compare 1000 1000);;

time (testtri tri_bulle_opt compare 1000 1000);;

time (testtri tri_cocktail compare 1000 1000);;

time (testtri tri_cocktail_opt compare 1000 1000);;

(* ----

## Conclusion

Les deux algorithmes ne sont pas trop difficiles à implémenter, et fonctionnent de façon très similaire.

### Question / exercice
- Prouver la correction de chaque algorithme, à l'aide d'invariants bien choisis.
- Prouver la complexité en temps.
- Pourquoi ces noms, à bulle et cocktail ?

### Liens
Allez voir [d'autres notebooks](http://nbviewer.jupyter.org/github/Naereen/notebooks/tree/master/agreg/) ! *)
