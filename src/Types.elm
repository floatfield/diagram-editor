module Types exposing (..)


type alias Point =
    { x : Int
    , y : Int
    }


type alias Position a =
    { a | x : Int, y : Int }


type alias Stroke a =
    { a | strokeColor : String, strokeWidth : String, strokeStyle : StrokeStyle }


type alias EllipseProps =
    Position (Stroke { rx : Int, ry : Int, fill : String })


type alias LineProps =
    Stroke { start : Point, end : Point }


type alias SelectedComponent =
    Maybe Int


type StrokeStyle
    = Solid
    | Dotted
    | Dashed


type Component
    = Ellipse EllipseProps
    | Line LineProps
