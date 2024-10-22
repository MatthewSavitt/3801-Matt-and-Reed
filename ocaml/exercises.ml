exception Negative_Amount

let change amount =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations

(* Write your first then apply function here *)
let rec first_then_apply (lst: 'a list) (predicate: 'a -> bool) (func: 'a -> 'b): 'b option =
  match lst with
  | [] -> None
  | x :: xs -> if predicate x then Some (func x) else first_then_apply xs predicate func

(* Write your powers generator here *)
let rec powers_generator (base: int) : int Seq.t =
  let rec aux (current: int) () = Seq.Cons (current, aux (current * base)) in
  aux 1

(* Write your line count function here *)
let meaningful_line_count (file: string) : int =
  let ic = open_in file in
  Fun.protect
    ~finally:(fun () -> close_in ic)
    (fun () ->
      let rec count acc =
        try
          let line = input_line ic in
          let trimmed = String.trim line in
          if String.length trimmed > 0 && not (String.starts_with trimmed "#") then
            count (acc + 1)
          else
            count acc
        with End_of_file -> acc
      in count 0)

(* Write your shape type and associated functions here *)

(* Write your binary search tree implementation here *)
