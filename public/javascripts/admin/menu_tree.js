Ext.onReady(function(){
    var info = new Ext.Panel({
        title: '&nbsp;',
        collapsible:false,
        renderTo: 'info',
        frame:true,
        contentEl:'info_content'
    });
    
    var menu_1 = new Ext.Panel({
        title: '用户管理',
        collapsible:true,
        frame:true,
        renderTo: 'menu_1',
        contentEl:'menu_1_content'
    });
    
    var menu_2 = new Ext.Panel({
        title: '区域管理',
        collapsible:true,
        frame:true,
        renderTo: 'menu_2',
        contentEl:'menu_2_content'
    });
    
    var menu_3 = new Ext.Panel({
        title: '基本信息管理',
        collapsible:true,
        frame:true,
        renderTo: 'menu_3',
        contentEl:'menu_3_content'
    });
    
});