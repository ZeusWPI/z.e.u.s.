:- module('_cdn_nav', [cdn_nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

:- use_module('_nav_item').

cdn_nav -->
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
    {http_session_data(user(_Id, _Name, _Role))},
    html([
        \nav_item(location_by_id(cdn_images), 'fas fa-file', 'Images'),
        \nav_item(location_by_id(cdn_files), 'fas fa-file', 'Files'),
        \start_admin
    ]).
start --> html('').

start_admin -->
    {http_session_data(user(_Id, _Name, admin)), ! },
    html([
        \nav_item(location_by_id(cdn_upload), 'fas fa-upload', 'Upload')
    ]).
start_admin --> html('').

end --> 
    {http_session_data(user(_Id, _Name, Role)), ! },
    html([
        \nav_item(location_by_id(album_root), 'fas fa-file', 'Goto Albums'),
        \end_admin(Role),
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).
end --> nav_item(location_by_id(login), 'fas fa-file', 'Login').

end_admin(admin) --> 
    html([
        \nav_item(location_by_id(users), 'fas fa-users-gear', 'Users')
    ]).
end_admin(_) --> html('').