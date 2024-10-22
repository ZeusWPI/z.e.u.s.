:- module(album_model, [
    album_by_id/2, 
    new_album/1,
    album_storage/2,
    album_children/2,
    
    album_id/2, 
    album_title/2,
    album_description/2,
    album_parent/2
]).

:- use_module(library(record)).

:- use_module('../../../config').
:- use_module('../database').

:- use_module('../../util/random_atom').

:- record album(
    id:atom, 
    title: atom, 
    description: atom, 
    parent: atom
).

album_by_id(Id, album(Id, T, D, P)) :-
    album(Id, T, D, P).

new_album(album(Id, T, D, P)) :-
    (P = none ->
        true
        ;
        album_by_id(P, _)
    ),
    random_atom(32, Id),
    \+ album_by_id(Id, _), !,
    \+ album(_, T, _, P), !,
    assert_album(Id, T, D, P),
    album_storage(Id, Directory),
    make_directory(Directory).

album_storage(none, 'albums/').
album_storage(Id, NPath) :-
    album_by_id(Id, Album),
    album_parent(Album, PId),
    album_storage(PId, Path),
    album_title(Album, Title),
    atom_concat(Path, Title, TP),
    atom_concat(TP, '/', NPath).

album_children(Id, Albums) :-
    findall(
        album(AId, T, D, Id),
        album(AId, T, D, Id),
        Albums
    ).