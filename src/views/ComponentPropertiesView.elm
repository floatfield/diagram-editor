module ComponentPropertiesView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (EllipseProps, Point, LineProps, SelectedComponent, Component(..))
import Msgs exposing (Msg(..))


componentPropertiesView : Maybe Component -> Html Msg
componentPropertiesView component =
    case component of
        Nothing ->
            div [] [ text "nothing to watch here!" ]

        Just comp ->
            case comp of
                Line line ->
                    div [] [ text "line gonna be here" ]

                Ellipse ellipse ->
                    div []
                        [ div [] [ text "Properties (ellipse)" ]
                        , label []
                            [ text "Position"
                            , label []
                                [ input [ type_ "text", value <| toString ellipse.x ] []
                                , text "x"
                                ]
                            , label []
                                [ input [ type_ "text", value <| toString ellipse.y ] []
                                , text "y"
                                ]
                            ]
                        , label []
                            [ text "Size"
                            , label []
                                [ input [ type_ "text", value <| toString ellipse.rx ] []
                                , text "rx"
                                ]
                            , label []
                                [ input [ type_ "text", value <| toString ellipse.ry ] []
                                , text "ry"
                                ]
                            ]
                        ]
