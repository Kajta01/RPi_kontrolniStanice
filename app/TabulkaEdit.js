$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
    var actions = $("table td:last-child").html();


    // Append table with add row form on add new button click
    $(".add-new").click(function () {
        $(this).attr("disabled", "disabled");

        var index = $("table tbody tr:last-child").index();
        var odlID = Number($("table tbody tr:last-child #ID").html());
        if (isNaN(odlID)) {
            odlID = 0;
        }
        var row = '<tr class="new"> <td id="ID">' + (odlID + 1) + '</td>';
        var i;

        for (i = 1; i < document.getElementById('table').rows[0].cells.length - 1; i++) {
            var id = document.getElementById('table').rows[0].cells[i].id;
            if (id.startsWith("ID_")) {
                var tabulka = id.replace("ID_", "");
                row = row + '<td id="' + id + '" class="value">';

                $.post("TabulkaComboBox.php", { Tabulka: tabulka, ID: id }, function (Jdata) {
                    data = JSON.parse(Jdata);

                    $(".new #" + data["id"]).html(data["message"]);
                    console.log("combo:" + data["sql"]);
                });

                row = row + "</td>";

            }
            else if (id == "Cas") {
                row = row + '<td class="value" id="' + id + '"><input class="itputTime" type="datetime-local"></td>';
            }
            else {
                row = row + '<td class="value" id="' + id + '"><input type="text" class="form-control" id="' + id + '"></td>';
            }
        }
        if (actions != null) {
            row = row + '<td>' + actions + '</td>' + '</tr>';
        }
        else {
            row = row + '<td>'
                + '<a class="add" title="Add" data-toggle="tooltip"><i class="fa fa-plus"></i></a>'
                + '<a class="edit" title="Edit" data-toggle="tooltip"><i class="fa fa-pencil"></i></a>'
                + '<a class="delete" title="Delete" data-toggle="tooltip"><i class="fa fa-trash-o"></i></a>'
                + '</td> </tr>';
        }
        $("table").append(row);
        $("table tbody tr").eq(index + 1).find(".add, .edit").toggle();
        $('[data-toggle="tooltip"]').tooltip();
    });

    // Add row on add button click
    $(document).on("click", ".add", function () {
        var empty = false;
        var input = $(this).parents("tr").find('input[type="text"]');
        input.each(function () {
            if (!$(this).val()) {
                $(this).addClass("error");
                empty = true;
            } else {
                $(this).removeClass("error");
            }
        });


        $(this).parents("tr").find(".error").first().focus();
        if (!empty) {
            var tabulka = document.getElementById('Tabulka').textContent;
            var dict = new Object();
            dict["ID"] = $("table tbody tr:last-child #ID").html();
            var input = $("table tbody tr:last-child .value");
            input.each(function () {

                console.log($(this).children().val());
                if ($(this).children().val() != "NULL") {
                    dict[$(this).attr('id')] = '"' + $(this).children().val() + '"';
                } else {
                    dict[$(this).attr('id')] = $(this).children().val();
                }


            });
            console.log(dict);
            var jsonDict = JSON.stringify(dict);
            $.post("ajaxAdd.php", { Tabulka: tabulka, data: jsonDict }, function (Jdata) {
                data = JSON.parse(Jdata);

                console.log(data['success']);
                if (data['success']) {
                    $("table tbody tr:last-child").addClass('importantGreenBackground');
                }
                else {
                    $("table tbody tr:last-child").addClass('importantRedBackground');
                }
                $("#displaymessage").html(data['general_message']);
                $("#displaymessage").addClass("view");
                setTimeout(function () {
                    $("#displaymessage").html("");
                    $("table tbody tr.importantRedBackground").removeClass("importantRedBackground");
                    $("table tbody tr.importantGreenBackground").removeClass("importantGreenBackground");
                    $("#displaymessage").removeClass("view");

                }, 5000);
                console.log(data['sql']);
            });

            input.each(function () {
                $(this).html($(this).children().val());
                console.log($(this).children().val());

            });
            $(".new").removeClass("new");
            $(this).parents("tr").find(".add, .edit").toggle();
            $(".add-new").removeAttr("disabled");
        }

    });
    // Delete row on delete button click
    $(document).on("click", ".delete", function () {
        $(this).parents("tr").remove();
        $(".add-new").removeAttr("disabled");
        var id = $(this).attr("id");
        var string = id;
        $.post("ajaxDeleteRow.php", { string: string }, function (data) {
            $("#displaymessage").html(data);
        });
    });
    
    // update rec row on edit button click
    $(document).on("click", ".update", function () {
        var tabulka = document.getElementById('Tabulka').textContent;

        var dict = new Object();
        dict["ID"] = $("table tbody tr:last-child #ID").html();
        var input = $(this).parents("tr").children();
        console.log($(this).parents("tr"));
        $(this).parents("tr").addClass("updateRow");
        input.each(function () {

            if ($(this).attr('id') != null) {
                if($(this).attr('id') == "ID"){
                    dict[$(this).attr('id')] = '"' + $(this).html() + '"';
                }
                else if ($(this).children().val() != "") {
                    dict[$(this).attr('id')] = '"' + $(this).children().val() + '"';
                } 
            }
        });
        console.log(dict);
        var jsonDict = JSON.stringify(dict);

        $.post("ajaxUpdate.php", { Tabulka: tabulka, data: jsonDict }, function (Jdata) {
            data = JSON.parse(Jdata);
            lineUpdate = $("table .updateRow");
            timeout=0;

             if (data['success']) {
                lineUpdate.addClass('importantGreenBackground');
                timeout = 3000;
             }
             else {
                lineUpdate.addClass('importantRedBackground');
                timeout = 10000;
             }
             $("#displaymessage").html(data['general_message']);
             $("#displaymessage").addClass("view");
             setTimeout(function () {
                 $("#displaymessage").html("");
                 $("table tbody tr.importantRedBackground").removeClass("importantGreenBackground");
                 $("table tbody tr.importantGreenBackground").removeClass("importantGreenBackground");
                 $("#displaymessage").removeClass("view");
 
             }, timeout);
             console.log(data['sql']);
        });
        $(".add-new").removeAttr("disabled");
        $(".updateRow").find(".update, .edit").toggle();

        

        $(".updateRow").find("td:not(:last-child)").each(function () {
 
            $(this).html($(this).children().val());
        });
        $(".updateRow").removeClass("updateRow");

        

    });
    // Edit row on edit button click
    $(document).on("click", ".edit", function () {
        $(this).parents("tr").find("td:not(:last-child)").each(function (i) {
            var idname = document.getElementById('table').rows[0].cells[i].id;
            if(idname != "ID")
            $(this).html('<input type="text" name="updaterec" id="' + idname + '" class="form-control" value="' + $(this).text() + '">');

        });
        $(this).parents("tr").find(".add, .edit").toggle();
        $(".add-new").attr("disabled", "disabled");
        $(this).parents("tr").find(".add").removeClass("add").addClass("update");
    });
});