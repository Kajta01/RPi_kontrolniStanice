$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
    var actions = $("table td:last-child").html();


    // Append table with add row form on add new button click
    $(".add-new").click(function () {
        $(this).attr("disabled", "disabled");
        
        var index = $("table tbody tr:last-child").index();
        var odlID = Number($("table tbody tr:last-child #ID").html());
        console.log(odlID);
        if(isNaN(odlID)) {
            odlID = 0;
            console.log("new");
        }
        var row = '<tr> <td id="ID">' + (odlID + 1) + '</td>';
        var i;
        for (i = 1; i < document.getElementById('table').rows[0].cells.length - 1; i++) {
            var id = document.getElementById('table').rows[0].cells[i].id;
            row = row + '<td id="'+id+'"><input type="text" class="form-control" name="'+id+'" id="'+id+'"></td>';
        }
        if(actions != null){
        row = row + '<td>' + actions + '</td>' + '</tr>';
        }
        else {
        row = row + '<td>' 
        +'<a class="add" title="Add" data-toggle="tooltip"><i class="fa fa-plus"></i></a>'
        +'<a class="edit" title="Edit" data-toggle="tooltip"><i class="fa fa-pencil"></i></a>'
        +'<a class="delete" title="Delete" data-toggle="tooltip"><i class="fa fa-trash-o"></i></a>'
        +'</td> </tr>';
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
            console.log(tabulka);
            var dict = new Object();
            dict["ID"]=$("table tbody tr:last-child #ID").html();
            var input = $(this).parents("tr").find('input[type="text"]');
            input.each(function () {
                dict[$(this).attr('id')]='"' + $(this).val() + '"';
            });
            console.log(dict);
            var jsonDict = JSON.stringify(dict);
            $.post("ajaxAdd.php", { Tabulka: tabulka ,data: jsonDict }, function (Jdata) {
                data = JSON.parse(Jdata);

                console.log(data['success']);
                if(data['success']){
                    $("table tbody tr:last-child").addClass('importantGreenBackground');
                }
                else{
                    $("table tbody tr:last-child").addClass('importantRedBackground');
                }
                $("#displaymessage1").html(data['general_message']);
                $("#displaymessage2").html(data['general_message']);
                console.log(data['sql']);
            });


            input.each(function () {
                $(this).parent("td").html($(this).val());
            });
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
        $.post("ajax_delete.php", { string: string }, function (data) {
            $("#displaymessage").html(data);
        });
    });
    // update rec row on edit button click
    $(document).on("click", ".update", function () {
        var id = $(this).attr("id");
        var string = id;
        var txtname = $("#txtname").val();
        var txtdepartment = $("#txtdepartment").val();
        var txtphone = $("#txtphone").val();
        $.post("ajax_update.php", { string: string, txtname: txtname, txtdepartment: txtdepartment, txtphone: txtphone }, function (data) {
            $("#displaymessage").html(data);
        });
    });
    // Edit row on edit button click
    $(document).on("click", ".edit", function () {
        $(this).parents("tr").find("td:not(:last-child)").each(function (i) {
            if (i == '0') {
                var idname = 'txtname';
            } else if (i == '1') {
                var idname = 'txtdepartment';
            } else if (i == '2') {
                var idname = 'txtphone';
            } else { }
            $(this).html('<input type="text" name="updaterec" id="' + idname + '" class="form-control" value="' + $(this).text() + '">');
        });
        $(this).parents("tr").find(".add, .edit").toggle();
        $(".add-new").attr("disabled", "disabled");
        $(this).parents("tr").find(".add").removeClass("add").addClass("update");
    });
});