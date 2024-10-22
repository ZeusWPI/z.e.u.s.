:- module('current_app', [current_app/1]).

:- use_module(library(http/http_wrapper)).

current_app(App) :-
    http_current_request(Request),
    member(app(App), Request).