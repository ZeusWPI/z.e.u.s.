:- module('_nav_item', [nav_item//3]).

:- use_module(library(http/html_write)).

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