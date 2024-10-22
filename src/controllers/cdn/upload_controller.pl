:- module('upload_controller', []).

:- use_module(library(http/http_client)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../templates/layout/page').
:- use_module('../../templates/view/cdn/upload_view').
:- use_module('../../util/random_atom').
:- use_module('../../../config').

upload(get, _Request) :-
    upload_form.

upload(post, Request) :-
    http_read_data(Request, Parts, [form_data(mime)]),
	member(mime(Attributes, Data, []), Parts),
	
    memberchk(name(file), Attributes),

    % Filter allowed content type
    member(type(Type), Attributes),
    (content_type(Type, Extension) ->
        generated_file_length(Length),
        random_atom(Length, Atom),
        atom_concat(Atom, Extension, FileName),
        atom_concat('files/', FileName, Path),
    
        open(Path, write, FileStream, [type(binary)]),
        write(FileStream, Data),
        close(FileStream),
        
        atom_concat('/', FileName, Location),
        http_redirect(see_other, Location, Request)
        ;
        atom_concat('The facts dont line out. Check your filetype and try again. Type: ', Type, String3),
        page_(String3)
    ).