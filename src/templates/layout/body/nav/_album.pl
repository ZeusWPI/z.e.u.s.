:- module('_album_nav', [album_nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

:- use_module('_nav_item').

album_nav -->
    {http_session_data(user(_Id, _Name, Role))},
    html([
        nav([class=navbar], [
            div([class='navbar-brand'], []),
            div([class='navbar-menu'], [
                div([class='navbar-start'], [
                    \start(Role)
                ]),
                div([class='navbar-end'], [
                    \end(Role)
                ])
            ])
        ])
    ]).

start(_Role) -->
    html([
        \nav_item(location_by_id(album_root), 'fas fa-file', 'Albums')
    ]).

end(Role) --> 
    html([
        \nav_item(location_by_id(cdn_images), 'fas fa-file', 'Goto CDN'),
        \end_admin(Role),
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).

end_admin(admin) --> 
    html([
        \nav_item(location_by_id(users), 'fas fa-users-gear', 'Users')
    ]).
end_admin(_) --> html('').