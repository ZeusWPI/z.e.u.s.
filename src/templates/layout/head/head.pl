:- module('head', [head//0]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

head -->
    html([
        title('ZeusWPI'),
        \uikit,
        meta([name='viewport', content='width=device-width', 'initial-scale'='1.0']),
        link([rel=icon, type='image/x-icon', href='/assets/favicon.ico'])
    ]).

uikit -->
    html([
        link([href='/assets/css/bulma.min.css',rel=stylesheet]),
        link([href='/assets/css/fa-all.min.css', rel=stylesheet]),
        script([src='/assets/js/fa-all.min.js'], [])
    ]).
