:- module('alert', [alert//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

alerts(Alerts) :- 
    findall(
        Alert, 
        (
            http_session_data(Alert), 
            Alert = alert(_Level, _Message)
        ), 
        Alerts
    ),
    http_session_retractall(alert(_, _)).
    
alert -->
    {alerts(Alerts)},
    html(\alert(Alerts)).

alert([]) --> html('').
alert([alert(Level, Message) | As]) -->
    {atom_concat('column is-full notification is-', Level, Class)},
    html([
        div([class=Class], [
            button([class='delete'], []),
            Message
        ]),
        \alert(As)
    ]).