:- module(file_model, [
    get_file/1,
    get_image/1
]).

:- use_module('../../../config').

get_file(FileName) :-
    directory_files('files', Entries),
    content_type(_, Extension),
    member(FileName, Entries),
    atom_concat(_, Extension, FileName).

get_image(FileName) :-
    directory_files('files', Entries),
    content_type(Type, Extension),
    atom_concat('image', _, Type),
    member(FileName, Entries),
    atom_concat(_, Extension, FileName).