var hair = {
    select_area_position:"top",
    toggle:function(cImage,object_id){
        $("#"+object_id).each(function(){
            if($.css(this,"display") == "none") {
                $(this).fadeIn();
                cImage.src="/images/display_.gif";
            } else {
                $(this).fadeOut();
                cImage.src="/images/display.gif";
            }
        });
        $("#"+object_id+"_bt").toggleClass("display_");
    },
    currentPage:function(page){var p_id = "#"+page;$(p_id).toggleClass("c");}
};

$(function(){
    $("input[@type='button'],input[@type='submit']").each(function(){$(this).addClass("button");});
    $("#select_area_bt").click(function(){
        hair.select_area_position="top";
        topCode=code;
        $("#sjdm").empty();$("#djsdm").empty();$("#xjdm").empty();
        $.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code=0",error: function(){},success: function(areas){fillSjdm(areas)}});
    });
    $("#selectarea-btn").click(function(){
        hair.select_area_position="user";
        topCode=$("#user_whereareyou").val();
        $("#sjdm").empty();$("#djsdm").empty();$("#xjdm").empty();
        $.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code=0",error: function(){},success: function(areas){fillSjdm(areas)}});
    });
    $("#salon-selectarea-btn").click(function(){
        hair.select_area_position="salon";
        topCode=$("#salon_city").val();
        $("#sjdm").empty();$("#djsdm").empty();$("#xjdm").empty();
        $.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code=0",error: function(){},success: function(areas){fillSjdm(areas)}});
    });
    $("#info-selectarea-btn").click(function(){
        hair.select_area_position="info";
        topCode=$("#info_city").val();
        $("#sjdm").empty();$("#djsdm").empty();$("#xjdm").empty();
        $.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code=0",error: function(){},success: function(areas){fillSjdm(areas)}});
    });
    $("#search_bt").click(function(){$("#searchform").submit()});
    $("#info_new_bt").click(function(){location.href='/user/infos/new'});
    $("input[@type='text'],input[@type='password'],textarea").each(function(){$(this).addClass("inp");});
    $("input[@type='text'],input[@type='password'],textarea").focus(function(){$(this).addClass("inp_focus");});
    $("input[@type='text'],input[@type='password'],textarea").blur(function(){$(this).removeClass("inp_focus");});
    
    $("#sjdm").change(function(){initDjsdm(this.options[this.selectedIndex].value);});
    $("#djsdm").change(function(){initXjdm(this.options[this.selectedIndex].value);});
    $("#sjdm").dblclick(function(){getNameAndCode("sjdm");});
    $("#djsdm").dblclick(function(){getNameAndCode("djsdm");});
    $("#xjdm").dblclick(function(){getNameAndCode("xjdm");});
    //$.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code=0",error: function(){},success: function(areas){fillSjdm(areas)}});
});

var initDjsdm = function(code){$("#djsdm").empty();$("#xjdm").empty();$.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code="+code,error: function(){},success: function(areas){filldjsdm(areas)}});}
var initXjdm = function(code){$("#xjdm").empty();$.ajax({type:"get",url:"/areas/json",dataType:"json",data:"code="+code,error: function(){},success: function(areas){fillxjdm(areas)}});}
var fillSjdm = function(areas){$("#djsdm").empty();$("#xjdm").empty();$.each(areas,function(){area = this;$("#sjdm").each(function(){var oOption = addOption(this,{"code":area.code,"name":area.name},{"start":0,"length":2});if(topCode.length>=2){if(area.code==topCode.substring(0,2)){oOption.selected = true;initDjsdm(this.options[this.selectedIndex].value);}}});});};
var filldjsdm = function(areas){$("#djsdm").empty();$("#xjdm").empty();$.each(areas,function(){area = this;$("#djsdm").each(function(){var oOption = addOption(this,{"code":area.code,"name":area.name},{"start":2,"length":4});if(topCode.length>=4){if(area.code==topCode.substring(0,4)){oOption.selected = true;initXjdm(this.options[this.selectedIndex].value);}}});});};
var fillxjdm = function(areas){$("#xjdm").empty();$.each(areas,function(){area = this;$("#xjdm").each(function(){var oOption = addOption(this,{"code":area.code,"name":area.name},{"start":4,"length":6});if(topCode.length>=6){if(area.code==topCode.substring(0,6)){oOption.selected = true;}}});});};
var addOption = function(selectObject,area,w){var oOption = document.createElement("OPTION");var code = area.code;var name = area.name;selectObject.options.add(oOption);oOption.text = code.substring(w.start,w.length)+" "+name;oOption.value = code;return oOption;};

var getNameAndCode = function(level){
    var code = "";
    var name = "";
    switch(level){
        case "sjdm":
            $("#sjdm").each(function(){if(this.selectedIndex>=0){code += this.options[this.selectedIndex].text.split(" ")[0];name += this.options[this.selectedIndex].text.split(" ")[1];}});
            break;
        case "djsdm":
            $("#sjdm").each(function(){if(this.selectedIndex>=0){code += this.options[this.selectedIndex].text.split(" ")[0];name += this.options[this.selectedIndex].text.split(" ")[1];}});
            $("#djsdm").each(function(){if(this.selectedIndex>=0){code += this.options[this.selectedIndex].text.split(" ")[0];name += this.options[this.selectedIndex].text.split(" ")[1];}});
            break;
        case "xjdm":
            $("#sjdm").each(function(){if(this.selectedIndex>=0){code += this.options[this.selectedIndex].text.split(" ")[0];name += this.options[this.selectedIndex].text.split(" ")[1];}});
            $("#djsdm").each(function(){if(this.selectedIndex>=0){code += this.options[this.selectedIndex].text.split(" ")[0];name += this.options[this.selectedIndex].text.split(" ")[1];}});
            $("#xjdm").each(function(){if(this.selectedIndex>=0){code += this.options[this.selectedIndex].text.split(" ")[0];name += this.options[this.selectedIndex].text.split(" ")[1];}});
            break;  
    }
    switch(hair.select_area_position){
        case "top":$.ajax({type:"post",url:"/areas/switch",dataType:"json",data:"code="+code+"&select_area_position="+hair.select_area_position,error: function(){},success: function(area){location.reload();}});break;
        case "user":$.ajax({type:"post",url:"/areas/switch",dataType:"json",data:"code="+code,error: function(){},success: function(area){$("#area_name").html(area.name);$("#user_whereareyou").val(area.code);}}); break;
        case "info":$.ajax({type:"post",url:"/areas/switch",dataType:"json",data:"code="+code,error: function(){},success: function(area){$("#area_name").html(area.name);$("#info_city").val(area.code);}}); break;
        case "salon":$.ajax({type:"post",url:"/areas/switch",dataType:"json",data:"code="+code,error: function(){},success: function(area){$("#area_name").html(area.name);$("#salon_city").val(area.code);}}); break;
    }
    tb_remove();
};