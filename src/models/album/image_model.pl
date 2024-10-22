:- module(image_model, [
    image_by_id/2,
    new_image/1,
    images_by_album/2,

    image_id/2,
    image_album/2,
    image_original/2,
    image_thumbnail/2
]).

:- use_module(library(record)).

:- use_module('../../../config').
:- use_module('../database').
:- use_module('album_model').

:- use_module('../../util/random_atom').

:- record image(
    id: atom,
    album: atom,
    original: atom,
    thumbnail: atom 
).

image_by_id(Id, image(Id, A, O, T)) :-
    image(Id, A, O, T).

new_image(image(Id, A, O, T)) :-
    album_by_id(A, _),
    random_atom(32, Id),
    \+ image_by_id(Id, _), !,
    assert_image(Id, A, O, T).

images_by_album(AId, Images) :-
    findall(
        image(Id, AId, O, T),
        image(Id, AId, O, T),
        Images
    ).

