
$(document).ready(function() {

    window.analysisChanged = function(analysis) {

        var id = "id-" + analysis.id
        var results = analysis.results

        var item = $("#" + id)

        if (item.length == 0) {
            item = $('<div id="' + id + '"></div>')
            $('body').append(item)
        }

        if (analysis.name === "Descriptives") {
        	item.frequencies( results )
        }
        else if (analysis.name === "TTestOneSample") {
            if (_.has(results, "descriptives"))
                item.tables( { tables : [ results.ttest, results.descriptives ] } )
            else
                item.tables( { tables : [ results.ttest ] } )
        }
        else if (analysis.name === "TTestIndependentSamples") {

            var ts = [ results.ttest ]

            if (results.inequalityOfVariances)
                ts.push(results.inequalityOfVariances)
            if (results.descriptives)
                ts.push(results.descriptives)

            item.tables( { tables : ts } )
        }

        $("html, body").animate({ scrollTop: item.offset().top }, { duration: 'slow', easing: 'swing'});
    }

    var display = function(name, results, element) {

        if ( ! _.has(displaydefs, name))
            return

        var displaydef = displaydefs[name]

        var constructor = $(element)[displaydef.ui]
        var options = $.jasp[displaydef.options]
        options = _.extend(options, results)

        element.empty()
        constructor(options)

    }

})
