:- module(cdn_image_view, [images_view/1, upload_form/0]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../layout/page').

images_view(Images) :-
    http_location_by_id(files, FileLocation),
    page_(
        div([class='grid'], [
            \list_elements(Images, FileLocation)
        ])
    ).

list_elements([], _) --> html('').
list_elements([image(FileName)|Images], FileLocation) --> 
    {
        atom_concat(FileLocation, FileName, Uri) 
    },
    html([
        div([class='cell'], [
            div([class='card'], [
                div([class='card-image'], [
                    figure([class='image is-3by4'], [
                        img([src=Uri, style='object-fit: cover;'], [])
                    ])
                ])
            ]) 
        ]),
        \list_elements(Images, FileLocation)
    ]).

upload_form() :-
    page_(
        form([method='POST', action=location_by_id(upload_image), enctype='multipart/form-data'], [
            div(['uk-form-custom'], [
                input([type=file, name=file]),
                button([class='uk-button uk-button-default'], ['Select'])
            ]),
            input([class='uk-button uk-button-default', type=submit, value='Upload'])
        ])    
    ).

