:- module('file_controller', []).

:- use_module('../../models/cdn/file_model').
:- use_module('../../templates/view/cdn/file_view').

files(_Request) :-
    findall(
        FileName,
        get_file(FileName),
        Files
    ),
    files_view(Files).