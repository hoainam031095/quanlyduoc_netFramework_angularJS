$(function () {
    var current = location.pathname;
    $('.main-sidebar ul.sidebar-menu li a').each(function () {
        var $this = $(this);
        if (current === "") {
        } else {
            //for other url
            if ($this.attr('href')) {
                if ($this.attr('href') === current) {
                    if ($(this).parents('.treeview-menu').length) {
                        $(this).parents('.treeview-menu').parents('li').addClass('active');
                        $(this).parents('.treeview-menu').prev("a").addClass('menu-open');
                        $(this).parents('.treeview-menu').show();
                        $(this).parents('li').addClass('active');
                        $this.addClass('menu-open');
                    }
                    else {
                        $(this).parents('li').addClass('active');
                    }
                }
            }
        }
    })
});