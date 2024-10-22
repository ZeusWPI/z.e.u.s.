:- module('nav', [nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

:- use_module('../../../../util/current_app').
:- use_module('_album').
:- use_module('_cdn').
:- use_module('_nav_item').

nav --> { current_app(album) }, html([ \album_nav ]).
nav --> { current_app(cdn) }, html([ \cdn_nav ]).

nav -->
    html([
        nav([class=navbar], [
            div([class='navbar-brand'], []),
            div([class='navbar-menu'], [
                div([class='navbar-start'], [
                    \start
                ]),
                div([class='navbar-end'], [
                    \end
                ])
            ])
        ])
    ]).

start -->
    { http_session_data(user(_Id, _Name, _Role)), ! },
    html([
        \nav_item(location_by_id(cdn_images), 'fas fa-file', 'CDN'),
        \nav_item(location_by_id(album_root), 'fas fa-folder', 'Albums')
    ]).
start --> html('').

end --> 
    { http_session_data(user(_Id, _Name, Role)), ! },
    html([
        \end_admin(Role),
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).
end --> nav_item(location_by_id(login), 'fas fa-file', 'Login').

end_admin(admin) --> 
    html([
        \nav_item(location_by_id(users), 'fas fa-users-gear', 'Users')
    ]).
end_admin(_) --> html('').
