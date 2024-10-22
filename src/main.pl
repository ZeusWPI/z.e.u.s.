:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_redis_plugin)).
:- use_module(library(http/http_session)).

:- use_module('handlers').

:- redis_server(devel, localhost:6379, []).
:- redis_server(prod, redis:6379, []).

:- initialization(main).

main :- 
    (current_prolog_flag(argv, [Mode, Port]) ->
        (atom_number(Port, PortNr) ->
            main(Mode, PortNr)
            ;
            usage, halt(1)
        )
        ;
        usage, halt(1)
    ).
main(devel, Port) :-
    write("Mode: Development"), nl,
    write("Port: "), write(Port), nl,
    debug, use_module(library(http/http_error)),
    server(Port, devel, (make, sleep(5))).
main(prod, Port) :-
    write("Mode: Production"), nl,
    write("Port: "), write(Port), nl,
    server(Port, prod, sleep(100)).

server(Port, RedisServer, After) :-
    http_set_session_options([
        timeout( 86400  ),     % Sessions last a day.
        cookie(  session),     % Don't use the default session cookie name.
	      redis_db(RedisServer), % Redis server for sessions.
	      gc(active) 	           % Active gc for sessions.
    ]),
    http_server(http_dispatch, [port(Port)]),
    busy(After).

% Print usage.
usage :- write("Usage: swipl src/main.pl [prod|devel] PORT"), nl.

% Infinitly keep backtracking the After Goal.
busy(After) :-
    repeat,
    call(After),
    fail.
