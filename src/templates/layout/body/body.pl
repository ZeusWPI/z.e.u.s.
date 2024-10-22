:- module('body', [body_//1]).

:- use_module(library(http/html_write)).

:- use_module('alert').
:- use_module('footer').
:- use_module('nav/nav').

:- html_meta body_(html,?,?).

body_(Content) -->
    html([
        \nav,
        div([class='columns m-3'], [
            \alert,
            div([class='column is-full p-0'], Content),
            \footer
        ])
    ]).