module ComponentViews exposing (..)

import Html exposing (..)
import Types exposing (EllipseProps, Point, LineProps, SelectedComponent, Component(..), StrokeStyle(..))
import Msgs exposing (Msg(..))
import Svg exposing (..)
import Svg.Attributes exposing (cx, cy, x1, y1, x2, y2, rx, ry, strokeWidth, stroke, opacity, fill, strokeDasharray)
import Svg.Events exposing (onClick)


componentsView : SelectedComponent -> List Component -> Html Msg
componentsView selectedComponent components =
    List.range 0 (List.length components)
        |> List.map2 (,) components
        |> List.map (componentView selectedComponent)
        |> svg []


componentView : SelectedComponent -> ( Component, Int ) -> Svg Msg
componentView selectedComponent ( component, orderNumber ) =
    let
        selected =
            case selectedComponent of
                Nothing ->
                    False

                Just i ->
                    i == orderNumber

        componentOpacity =
            if selected then
                "0.8"
            else
                "1"

        click =
            if not selected then
                SelectComponent orderNumber
            else
                UnselectComponent
    in
        case component of
            Ellipse el ->
                ellipseView selected componentOpacity click el

            Line l ->
                lineView selected componentOpacity click l


ellipseView : Bool -> String -> Msg -> EllipseProps -> Svg Msg
ellipseView selected componentOpacity click el =
    let
        props =
            { cx = toString el.x
            , cy = toString el.y
            , rx = toString el.rx
            , ry = toString el.ry
            }
    in
        Svg.ellipse
            [ cx props.cx
            , cy props.cy
            , rx props.rx
            , ry props.ry
            , strokeWidth el.strokeWidth
            , stroke el.strokeColor
            , fill el.fill
            , strokeDasharray <| strokeToArray el.strokeStyle
            , opacity componentOpacity
            , onClick click
            ]
            []


lineView : Bool -> String -> Msg -> LineProps -> Svg Msg
lineView selected componentOpacity click l =
    let
        props =
            { x1 = toString l.start.x
            , y1 = toString l.start.y
            , x2 = toString l.end.x
            , y2 = toString l.end.y
            }
    in
        Svg.line
            [ x1 props.x1
            , y1 props.y1
            , x2 props.x2
            , y2 props.y2
            , stroke l.strokeColor
            , strokeWidth l.strokeWidth
            , strokeDasharray <| strokeToArray l.strokeStyle
            , opacity componentOpacity
            , onClick click
            ]
            []


strokeToArray : StrokeStyle -> String
strokeToArray strokeStyle =
    case strokeStyle of
        Solid ->
            "1,0"

        Dashed ->
            "10,5"

        Dotted ->
            "1,5"
