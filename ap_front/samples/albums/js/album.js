var World = {

    init: function initFn() {
        this.createOverlays();
    },

    createOverlays: function createOverlaysFn() {
        // Loading Collection
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/tracker.wtc", {
            onError: World.onError
        });
        this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
            onTargetsLoaded: World.showInfoBar,
            onError: World.onError
        });
        //Initiate widget
        var ratingwidget = new AR.HtmlDrawable({
            uri: "assets/rating.html"
        }, 0.2, {
            viewportWidth: 100,
            viewportHeight: 100,
            backgroundColor: "#00000000",
            translate: {
                x: 0.42,
                y: -0.25
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            clickThroughEnabled: true,
            allowDocumentLocationChanges: false,
            onError: World.onError
        });
        // Create Trackable
        this.albumTracker = new AR.ImageTrackable(this.tracker, "*", {
            drawables: {
                cam: ratingwidget
            },
            onImageRecognized:
                function (target) {
                    AR.platform.sendJSONObject({
                        "albumId": target.name

                    });
                    console.log(target.toString())
                    World.hideInfoBar();
                },

            onError: World.onError
        });
    },

    onError: function onErrorFn(error) {
        alert(error);
    },

    hideInfoBar: function hideInfoBarFn() {
        document.getElementById("infoBox").style.display = "none";
    },

    showInfoBar: function worldLoadedFn() {
        document.getElementById("infoBox").style.display = "table";
        document.getElementById("loadingMessage").style.display = "none";
    }
};

World.init();