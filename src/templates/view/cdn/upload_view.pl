:- module(cdn_upload_view, [upload_form/0]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../layout/page').

upload_form() :-
    page_(
        div([class='grid'], [
            form([method='POST', action=location_by_id(cdn_upload), enctype='multipart/form-data'], [
                div([class='file has-name is-boxed'], [
                    label([class='file-label'],[
                        input([class='file-input', type=file, name=file]),
                        span([class='file-cta'], [
                            span([class='file-icon'], [
                                i([class='fas fa-upload'], [])
                            ]),
                            span([class='file-label'], 'Choose a file...')
                        ]),
                        span([class='file-name'], 'LeName.pdf')
                    ])
                ]),
                input([class='button is-primary', type=submit, value='Upload'])
            ])
        ])  
    ).