import pytest

from dash import Dash, Input, Output, State, dcc, html

from dash.exceptions import PreventUpdate
from dash.testing import wait


@pytest.mark.parametrize("responsive", [True, False, None])
@pytest.mark.parametrize("autosize", [True, False, None])
@pytest.mark.parametrize("height", [600, None])
@pytest.mark.parametrize("width", [600, None])
@pytest.mark.parametrize("is_responsive", [True, False, "auto"])
def test_grrs001_graph(dash_dcc, responsive, autosize, height, width, is_responsive):
    app = Dash(__name__, eager_loading=True)

    header_style = dict(padding="10px", backgroundColor="yellow", flex="0 0 100px")

    graph_style = dict(padding="10px", backgroundColor="red", flex="1 0 0")

    card_style = dict(
        display="flex",
        flexFlow="column",
        backgroundColor="green",
        padding="10px",
        height="500px",
        width="1000px",
    )

    header = html.Div(
        id="header",
        style=header_style,
        children=[html.Button(id="resize", children=["Resize"])],
    )

    graph = html.Div(
        style=graph_style,
        children=[
            dcc.Graph(
                id="graph",
                responsive=is_responsive,
                style=dict(height="100%", width="100%"),
                config=dict(responsive=responsive),
                figure=dict(
                    layout=dict(autosize=autosize, height=height, width=width),
                    data=[
                        dict(
                            x=[1, 2, 3, 4],
                            y=[5, 4, 3, 6],
                            line=dict(shape="spline"),
                        )
                    ],
                ),
            )
        ],
    )

    app.layout = html.Div(
        [
            html.Div(
                [
                    "responsive: {}, ".format(responsive),
                    "autosize: {}, ".format(autosize),
                    "height: {}, ".format(height),
                    "width: {}, ".format(width),
                    "is_responsive: {}".format(is_responsive),
                ]
            ),
            html.Div(id="card", style=card_style, children=[header, graph]),
        ]
    )

    @app.callback(
        Output("header", "style"),
        [Input("resize", "n_clicks")],
        [State("header", "style")],
    )
    def resize(n_clicks, style):
        if n_clicks is None:
            raise PreventUpdate

        return dict(style, **dict(flex="0 0 200px"))

    dash_dcc.start_server(app)

    # autosize=true|udefined will make the graph fit its parent on first render, responsive has no impact on that behavior
    #
    # responsive=true will make the graph resize only if autosize=true|undefined, interestingly enough, responsive=undefined
    # behaves the same as responsive=false (https://github.com/plotly/plotly.js/blob/master/src/plot_api/plot_config.js#L122)

    initial_responsive = is_responsive is True or (
        is_responsive == "auto"
        and autosize is not False
        and (height is None or width is None)
    )

    resize_responsive = is_responsive is True or (
        is_responsive == "auto"
        and responsive is True
        and autosize is not False
        and (height is None or width is None)
    )

    initial_height = (
        360
        if (initial_responsive and (height is None or is_responsive is True))
        else 450
        if height is None
        else height
    )

    resize_height = (
        260
        if (resize_responsive and (height is None or is_responsive is True))
        else initial_height
        if height is None
        else height
    )

    # 500px card minus (100px header + 20px padding) minus (20px padding on container) -> 360px left
    wait.until(
        lambda: dash_dcc.wait_for_element("#graph svg.main-svg").size.get("height", -1)
        == initial_height,
        3,
    )

    dash_dcc.wait_for_element("#resize").click()

    # 500px card minus (200px header + 20px padding) minus (20px padding on container) -> 260px left
    wait.until(
        lambda: dash_dcc.wait_for_element("#graph svg.main-svg").size.get("height", -1)
        == resize_height,
        3,
    )

    assert dash_dcc.get_logs() == []
