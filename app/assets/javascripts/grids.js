// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

    function init() {
        var $container = $(".grid-container")

        if ($container.length === 0) {
            return;
        }

        var grid = createGrid($container);

        fetchData(grid, $container);
    }

    function createGrid($container) {
        var grid = $container.gridster({
            widget_margins: [0, 0],
            widget_base_dimensions: [200, 200],
            widget_selector: "div",
        }).data("gridster");

        return grid;
    }

    function fetchData(grid, $container) {
        $.ajax({
            type: "GET",
            url: "/grids/" + $container.data("gridid") + "/tiles",
            dataType: 'json',
            success: function(data) {
                dataCallback(grid, $container, data)
            }
        });
    }

    function dataCallback(grid, $container, data) {
        console.log(data);

        var ids = [];

        $.each(data, function() {
            ids.push("tile-" + this.id);
        });

        removeTiles($container, ids);

        $.each(data, function() {
            setTile(grid, $container, this);
        });

        setTimeout(function() {
            fetchData(grid, $container);
        }, 10000);
    }

    function removeTiles($container, ids) {
        $.each($container.find(">div"), function() {
            if (ids.indexOf($(this).attr('id')) < 0) {
                $(this).remove();
            }
        });
    }

    function setTile(grid, $container, tile) {
        var $tile = $container.find("#tile-" + tile.id);

        if ($tile.length > 0) {
            setContent($tile, tile);
            $tile.attr("data-sizex", tile.sizex);
            $tile.attr("data-sizey", tile.sizey);
            $tile.attr("data-col", tile.posx);
            $tile.attr("data-row", tile.posy);
        } else {
            grid.add_widget('<div class="' + tile.color + '" id="tile-' + tile.id + '"></div>', tile.sizex, tile.sizey, tile.posx, tile.posy);
            setContent($container.find("#tile-" + tile.id), tile);
        }
    }

    function setContent($tile, tile) {
        var content = $tile.data("content");

        // Content changed
        if (!(content === "" + tile.type + tile.content)) {
            switch(tile.type) {
            case "text":
                setText($tile, tile);
                break;
            case "image":
                setImage($tile, tile);
                break;
            case "youtube":
                setYoutube($tile, tile);
                break;
            default:
                console.log("UNRECOGNIZED TYPE!");
            }

            $tile.data("content", "" + tile.type + tile.content);
        }


    }

    function setText($tile, tile) {
        $tile.html("<span>" + tile.content + "</span>");
    }

    function setImage($tile, tile) {
        $tile.html('<div class="tile-image"></div>');

        var $image = $tile.find(".tile-image");

        $image.css({
            "background-image": 'url("' + tile.content + '")',
            "background-repeat": "no-repeat",
            "background-size": "cover",
            "background-position": "center"
        });
    }

    function setYoutube($tile, tile) {
        $tile.html(
            '<iframe type="text/html" ' +
            'src="http://www.youtube.com/embed/' +
            tile.content +
            '?autoplay=1&loop=1&playlist=' +
            tile.content +
            '&controls=0" ' +
            'frameborder="0" />'
        );
    }

    init();
});
