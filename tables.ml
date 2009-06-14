(** Global list of tables *)

open Printf

type table = RA.table

let all : table list ref = ref []

(** FIXME table names case sensitivity? *)

(** @raise Error when no such table *)
let get_from tables name =
  try
    List.find (fun (n,_) -> n = name) tables
  with Not_found -> failwith (sprintf "no such table %s" name)

let get name = get_from !all name
let get_schema name = snd (get name)
let check name = ignore (get name)

let add v =
  let (name,schema) = v in
  match List.find_all (fun (n,_) -> n = name) !all with
  | [] -> all := v :: !all
  | _ -> failwith (sprintf "table %s already exists" name)

let alter name f =
  let alter_scheme ((n,s) as table) =
    if n = name then
      name, f s
    else
      table
  in
  all := List.map alter_scheme !all

let alter_add name col pos = alter name (fun s -> RA.Scheme.add s col pos)
let alter_drop name col = alter name (fun s -> RA.Scheme.drop s col)

let print () = List.iter RA.print_table !all

let reset () = all := []

