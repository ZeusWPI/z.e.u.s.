:- module('database', [
    user/3,
    assert_user/3,

    album/4,
    assert_album/4,

    image/4,
    assert_image/4    
]).

:- use_module(library(persistency)).

:- initialization(db_attach('data/database.db', [])).

:- persistent user(
    id: integer,
    name: string,
    role: oneof([user, admin])
).

:- persistent album(
    id: atom, 
    title: atom,
    description: atom, 
    parent: atom
).

:- persistent image(
    id: atom,
    album: atom,
    original: atom,
    thumbnail: atom 
).

:- persistent image_statistics(
    id: atom,
    width: integer,
    height: integer
).