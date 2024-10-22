:- module(cdn_file_view, [files_view/1]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../layout/page').

files_view(FileNames) :-
    http_location_by_id(files, FileLocation),
    page_(
        div([class='grid'], [
            div([class='card'], [
                div([class='card-content'], [
                    table([class='table is-fullwidth is-centered'], [
                        thead(
                            tr([
                                th('FileName'),
                                th('')
                            ])   
                        ),
                        tb(
                            \list_elements(FileNames, FileLocation)
                        )
                    ])
                ])
            ])
        ])
    ).

list_elements([], _) --> html('').
list_elements([FileName|FileNames], FileLocation) --> 
    {
        atom_concat(FileLocation, FileName, Uri) 
    },
    html([
        tr([
            td(FileName),
            td(a([class='button is-primary', href=Uri], ['Open']))
        ]),
        \list_elements(FileNames, FileLocation)
    ]).