:- module(album_upload_view, [upload_view/0]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../layout/page').

upload_view() :-
    page_([
        div([class='columns is-centered'], [
            div([class='column is-8'], [
                div([class='card'], [
                    div([class='card-content'], [
                        form([id=upload, method='POST', action=location_by_id(album_upload), enctype='multipart/form-data'], [
                            div([class='file is-boxed'], [
                                label([class='file-label', style='width: 100%'],[
                                    input([class='file-input', type=file, name=file, multiple]),
                                    span([class='file-cta'], [
                                        span([class='file-icon'], [
                                            i([class='fas fa-upload'], [])
                                        ]),
                                        span([class='file-label'], 'Choose a file...')
                                    ])
                                ])
                            ]),
                            div([id=selectedFiles, hidden, class='block'], [
                                span([hidden, class='tag is-light is-info is-fullwidth is-medium'], [
                                ])
                            ]),
                            input([class='button is-fullwidth', type=submit, value='Upload'])
                        ])
                    ])
                ]),
                div([class='card'], [
                    div([class='card-content', id=uploadList], [
                        
                    ])
                ])
            ])
        ]),
        script([src='/assets/js/album/upload.js'], [])
    ]).