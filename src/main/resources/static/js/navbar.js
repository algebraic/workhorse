$(function() {
    // section buttons
    $("a.section").click(function() {
        $("div[data-section]").addClass("hidden");
        var $this = $(this);
        var section = $this.attr("id");
        $('div[data-section="' + section + '"]').removeClass("hidden");
        // set title
        $("#section-title").text($this.text());
        
        // section-specific actions
        if ($this.text() == "KPI Data") {
            $("#kpiSubmit").click();
        }
        // section-specific actions
        if ($this.text() == "User Data") {
            $("#userSubmit").click();
        }
        // section-specific actions
        if ($this.text() == "User Profile") {
            
        }
        if ($this.text() == "Data Entry") {
            var $div = $("#bureau-list").empty();

            $.ajax({
                url: 'kpi/bureaus',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    // admin user, show all bureaus
                    for (var i = 0; i < response.length; i++) {
                        var $element = '<div class="accordion-item" data-bureau="' + response[i] + '"><h2 class="accordion-header">';
                        $element += '<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panel-bureau-' + i + '" aria-expanded="false" aria-controls="panel-bureau-' + i + '">' + response[i] + '</button></h2>';
                        $element += '<div id="panel-bureau-' + i + '" class="accordion-collapse" data-bs-parent="#bureau-list"><div class="accordion-body p-0"></div></div>';
                        $div.append($element);
                    }
                    // hacky junk to open accordion on page load
                    setTimeout(function() {
                        $("button.accordion-button:eq(0)").click();
                    }, 1000);
                    setTimeout(function() {
                        $('.accordion-body button:first').click();
                    }, 1500);
                },
                error: function(error) {
                    console.error('Error fetching record list:', error);
                }
            });
        }

    });
    // zj: auto-click something on page load
    $("a.section").eq(0).click();
});