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

let rec first_then_apply (lst: 'a list) (predicate: 'a -> bool) (func: 'a -> 'b option): 'b option =
  match lst with
  | [] -> None
  | x :: xs -> 
    if predicate x then (func x)
    else first_then_apply xs predicate func

let rec powers_generator (base: int) : int Seq.t =
  let rec aux (current: int) () = Seq.Cons (current, aux (current * base)) in
  aux 1
  

let meaningful_line_count (file: string) : int =
  let ic = open_in file in
  Fun.protect
    ~finally:(fun () -> close_in ic)
    (fun () ->
      let rec count (acc: int) : int =
        try
          let line = input_line ic in
          let trimmed = String.trim line in
          if String.length trimmed > 0 && not (String.sub trimmed 0 1 = "#") then
            count (acc + 1)
          else
            count acc
        with End_of_file -> acc
      in count 0)


type shape =
  | Sphere of float
  | Box of float * float * float

let volume (s: shape) : float =
  match s with
  | Sphere radius -> (4.0 /. 3.0) *. Float.pi *. radius ** 3.0
  | Box (width, height, depth) -> width *. height *. depth


let surface_area (s: shape) : float =
  match s with
  | Sphere radius -> 4.0 *. Float.pi *. radius ** 2.0
  | Box (width, height, depth) -> 2.0 *. (width *. height +. height *. depth +. depth *. width)


let to_string (s: shape) : string =
  match s with
  | Sphere radius -> Printf.sprintf "Sphere with radius: %.2f" radius
  | Box (width, height, depth) ->
      Printf.sprintf "Box with width: %.2f, height: %.2f, depth: %.2f" width height depth


module BST : sig
  type 'a bst

  val empty : 'a bst
  val insert : 'a -> 'a bst -> 'a bst
  val contains : 'a -> 'a bst -> bool
  val size : 'a bst -> int
  val inorder : 'a bst -> 'a list
end = struct

  type 'a bst = 
    | Empty
    | Node of 'a * 'a bst * 'a bst

  let empty = Empty

  let rec insert (x: 'a) (tree: 'a bst) : 'a bst =
    match tree with
    | Empty -> Node (x, Empty, Empty)
    | Node (v, left, right) ->
      if x < v then Node (v, insert x left, right)
      else if x > v then Node (v, left, insert x right)
      else tree

  let rec contains (x: 'a) (tree: 'a bst) : bool =
    match tree with
    | Empty -> false
    | Node (v, left, right) ->
      if x = v then true
      else if x < v then contains x left
      else contains x right

  let rec size (tree: 'a bst) : int =
    match tree with
    | Empty -> 0
    | Node (_, left, right) -> 1 + size left + size right

  let rec inorder (tree: 'a bst) : 'a list =
    match tree with
    | Empty -> []
    | Node (v, left, right) -> inorder left @ [v] @ inorder right
end

open BST
