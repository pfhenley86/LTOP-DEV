<?php 
$bluewrapText = array('WE CAN DO A LOT OF THINGS','WE WORK HARD TO ACHIEVE EXCELLENCE','LEARN MORE ABOUT US');
?>
<div id="skip-link">
<a href="#main-content" class="element-invisible element-focusable"><?php print t('Skip to main content'); ?></a>
<?php if ($main_menu): ?>
    <a href="#navigation" class="element-invisible element-focusable"><?php print t('Skip to navigation'); ?></a>
<?php endif; ?>
    <!-- begin NavBar -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="login">
            <a href="">Login</a> / <a href="">Logout</a>
        </div>
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <?php if ($logo): ?>
            <a class="navbar-brand" href="/" title="home">
                <img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" />
            </a>
            <?php endif; ?>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="navbar-collapse collapse">
        <?php
            $menu = menu_tree_all_data('main-menu');
            print drupal_render(menu_tree_output($menu)); 
        ?>
        </div><!-- /.navbar-collapse -->
    </div>
    </nav>
    <!-- end NavBar -->
    
    <?php print render($page['header']); ?>  
    <?php if ($breadcrumb): print $breadcrumb; endif;?>
<div id="blue">
        <div class="container">
            <div class="row centered">
                <div class="col-lg-8 col-lg-offset-2">
                <h4><?php print $bluewrapText[array_rand($bluewrapText)];?></h4>
                </div>
            </div><!-- row -->
        </div><!-- container -->
    </div><!--  bluewrap -->
<div id="container" class="container">
	<div class="row">
    
    <section id="main" role="main" class="<?php echo $page['main_section_class']; ?>">
		<?php print $messages; ?>
        <a id="main-content"></a>
        <?php if ($title): ?><h1 class="title" id="page-title"><?php print $title; ?></h1><?php endif; ?>
        <?php print render($title_suffix); ?>
        <?php if (!empty($tabs['#primary'])): ?><div class="tabs-wrapper clearfix"><?php print render($tabs); ?></div><?php endif; ?>
        <?php print render($page['help']); ?>
        <?php if ($action_links): ?><ul class="action-links"><?php print render($action_links); ?></ul><?php endif; ?>
        <?php print render($page['content']); ?>
    </section> <!-- /#main -->
    
    <?php if ($page['sidebar_first']): ?>
    <aside id="sidebar-second" role="complementary" class="sidebar <?php echo $page['second_sidebar_class']; ?>">
    	<?php print render($page['sidebar_second']); ?>
    </aside>  <!-- /#sidebar-second -->
    <?php endif; ?>
    
    </div> <!-- /.row -->
</div> <!-- /#container -->

<footer id="f" role="contentinfo" class="clearfix">
	<?php print render($page['footer']) ?>
    <?php print $feed_icons ?>
</footer> <!-- /#footer -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">contact us</h4>
      </div>
      <div class="modal-body">
            <div class="row centered">
                <p>We are available 24/7, so don't hesitate to contact us.</p>
                <p>
                    Somestreet Ave, 987<br/>
                    Fort Walton Beach, FLs<br/>
                    850-428-1800<br/>
                    bear@integrioussolutions.com
                </p>
                <div id="mapwrap">
    <iframe height="300" width="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.es/maps?t=m&amp;ie=UTF8&amp;ll=52.752693,22.791016&amp;spn=67.34552,156.972656&amp;z=2&amp;output=embed"></iframe>
                </div>  
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Save & Go</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



