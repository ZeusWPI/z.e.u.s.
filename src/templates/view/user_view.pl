:- module(user_view, [users_view/1]).

:- use_module(library(http/html_write)).

:- use_module('../layout/page').

users_view(Users) :-
    page_(
        div([class='grid'], [
            div([class='card'], [
                div([class='card-content'], [
                    table([class='table is-fullwidth'], [
                        thead(
                            tr([
                                th('Id'),
                                th('Name'),
                                th('Role')
                            ])
                        ),
                        tbody([
                            \users_view_(Users)
                        ])
                    ])
                ])
            ])
        ])
    ).

users_view_([]) --> html('').
users_view_([user(Id, Name, Role)|Users]) -->
    html([
        tr([
            td(Id),
            td(Name),
            td(Role)
        ]),
        \users_view_(Users)
    ]).