:- module('image_controller', []).

:- use_module('../../models/cdn/file_model').
:- use_module('../../templates/view/cdn/image_view').

images(_Request) :-
    findall(
        image(FileName),
        get_image(FileName),
        Images
    ),
    images_view(Images).