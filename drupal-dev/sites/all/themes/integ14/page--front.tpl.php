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
<div id="headerwrap">
        <div class="container">
            <div class="row centered">
                <?php print render($page['highlighted']); ?>
            </div><!-- row -->
        </div><!-- container -->
    </div><!-- headerwrap -->
<!--Highlighted/slider -->
<div class="container w">
        <div class="row centered">
            <br><br>
            <div class="col-lg-4">
                <i class="fa fa-heart"></i>
                <?php print render($page['features_one']); ?>
            </div><!-- col-lg-4 -->

            <div class="col-lg-4">
                <i class="fa fa-laptop"></i>
                <?php print render($page['features_two']); ?>
            </div><!-- col-lg-4 -->

            <div class="col-lg-4">
                <i class="fa fa-trophy"></i>
                <?php print render($page['features_three']); ?>
            </div><!-- col-lg-4 -->
        </div><!-- row -->
        <br>
        <br>
</div><!-- container -->

    <!-- PORTFOLIO SECTION -->
<div id="dg">
    <div class="container">
        <div class="row centered">
            <h4>LATEST BLOG POSTS</h4>
            <br>
            <div class="col-lg-4">
                <div class="tilt">
                <?php
                $viewName = 'recent_blog_posts';
                print views_embed_view($viewName);
                ?>
                </div>
            </div>
        </div><!-- row -->
    </div><!-- container -->
</div><!-- DG -->
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
                        London, UK.<br/>
                        +44 8948-4343<br/>
                        hi@blacktie.co
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

