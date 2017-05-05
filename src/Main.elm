module Main exposing (..)

import Html exposing (..)
import Types exposing (Point, SelectedComponent, Component(..), StrokeStyle(..))
import Msgs exposing (Msg(SelectComponent, UnselectComponent))
import ComponentViews exposing (componentsView)
import ComponentPropertiesView exposing (componentPropertiesView)


-- MODEL


type alias Diagram =
    { title : String
    , selectedComponent : SelectedComponent
    , components : List Component
    }


init : ( Diagram, Cmd Msg )
init =
    ( { title = "Diagram 1"
      , selectedComponent = Nothing
      , components =
            [ Ellipse
                { x = 50
                , y = 50
                , rx = 30
                , ry = 50
                , fill = "#BDBBB8"
                , strokeColor = "#0000ff"
                , strokeWidth = "2"
                , strokeStyle = Solid
                }
            , Line
                { start =
                    { x = 100
                    , y = 50
                    }
                , end =
                    { x = 200
                    , y = 200
                    }
                , strokeColor = "#000000"
                , strokeWidth = "5"
                , strokeStyle = Dashed
                }
            ]
      }
    , Cmd.none
    )



-- MESSAGES
-- UPDATE


update : Msg -> Diagram -> ( Diagram, Cmd Msg )
update msg diagram =
    case msg of
        SelectComponent componentNumber ->
            ( { diagram | selectedComponent = Just componentNumber }
            , Cmd.none
            )

        UnselectComponent ->
            ( { diagram | selectedComponent = Nothing }
            , Cmd.none
            )



-- VIEW


view : Diagram -> Html Msg
view diagram =
    div []
        [ h2 [] [ Html.text diagram.title ]
        , componentsView diagram.selectedComponent diagram.components
        , componentPropertiesView <| getSelectedComponent diagram
        ]


getSelectedComponent : Diagram -> Maybe Component
getSelectedComponent diagram =
    case diagram.selectedComponent of
        Nothing ->
            Nothing

        Just i ->
            List.drop i diagram.components
                |> List.head



-- SUBSCRIPTION


subscriptions : Diagram -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Diagram Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
