:- module('nav', [nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

nav -->
    html([
        nav([class=navbar], [
            div([class='navbar-brand'], []),
            div([class='navbar-menu'], [
                div([class='navbar-end'], [
                    \user_specific
                ])
            ])
        ])
    ]).

nav_item(Href, Icon, Content) -->
    html([
        div([class='navbar-item'], [
            div([class='buttons'], [
                a([class='button', href=Href], [
                    div([
                        span([class='icon'], [
                            i([class=Icon], [])
                        ]), 
                        span([Content])
                    ])
                ])
            ])
        ])
    ]).

user_specific --> 
    {http_session_data(user(_Id, _Name, Role))},
    html([
        \admin_stuff(Role),
        \nav_item(location_by_id(images), 'fas fa-image', 'Images'),
        \nav_item(location_by_id(documents), 'fas fa-file', 'Files'),
        \nav_item(location_by_id(albums), 'fas fa-file', 'Albums'),
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).
user_specific --> nav_item(location_by_id(login), 'fas fa-file', 'Login').

admin_stuff(admin) --> 
    html([
        \nav_item(location_by_id(users), 'fas fa-users-gear', 'Users'),
        \nav_item(location_by_id(new_upload), 'fas fa-upload', 'Upload')
    ]).
admin_stuff(_) --> html('').
