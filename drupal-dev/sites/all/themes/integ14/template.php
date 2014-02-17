<?php
/**
 * Implements hook_html_head_alter().
 * We are overwriting the default meta character type tag with HTML5 version.
 */
function integ14_html_head_alter(&$head_elements) {
  $head_elements['system_meta_content_type']['#attributes'] = array(
    'charset' => 'utf-8'
  );
}

/**
 * Return a themed breadcrumb trail.
 *
 * @param $breadcrumb
 *   An array containing the breadcrumb links.
 * @return a string containing the breadcrumb output.
 */
function integ14_breadcrumb($variables) {
  $breadcrumb = $variables['breadcrumb'];

  if (!empty($breadcrumb)) {
    // Provide a navigational heading to give context for breadcrumb links to
    // screen-reader users. Make the heading invisible with .element-invisible.
    $heading = '<h2 class="element-invisible">' . t('You are here') . '</h2>';
    // Uncomment to add current page to breadcrumb
	// $breadcrumb[] = drupal_get_title();
    return '<nav class="breadcrumb">' . $heading . implode(' » ', $breadcrumb) . '</nav>';
  }
}

/**
 * Duplicate of theme_menu_local_tasks() but adds clearfix to tabs.
 */
function integ14_menu_local_tasks(&$variables) {
  $output = '';

  if (!empty($variables['primary'])) {
    $variables['primary']['#prefix'] = '<h2 class="element-invisible">' . t('Primary tabs') . '</h2>';
    $variables['primary']['#prefix'] .= '<ul class="tabs primary clearfix">';
    $variables['primary']['#suffix'] = '</ul>';
    $output .= drupal_render($variables['primary']);
  }
  if (!empty($variables['secondary'])) {
    $variables['secondary']['#prefix'] = '<h2 class="element-invisible">' . t('Secondary tabs') . '</h2>';
    $variables['secondary']['#prefix'] .= '<ul class="tabs secondary clearfix">';
    $variables['secondary']['#suffix'] = '</ul>';
    $output .= drupal_render($variables['secondary']);
  }
  return $output;
}

/**
 * Override or insert variables into the page template.
 */
function integ14_preprocess_page(&$vars){
	$sidebars = 0;
	$page = $vars['page'];
	$vars['page']['first_sidebar_class'] = 'col-md-3';
	$vars['page']['main_section_class'] = 'col-md-12';
	$vars['page']['second_sidebar_class'] = 'col-md-3';
	if (!empty($page['sidebar_first'])) {
		++$sidebars;
	}
	if (!empty($page['sidebar_second'])) {
		++$sidebars;
	}
	if($sidebars == 1) {
		$vars['page']['main_section_class'] = 'col-md-9';
	}
	if($sidebars == 2) {
		$vars['page']['first_sidebar_class'] = 'col-sm-6 col-md-4';
		$vars['page']['main_section_class'] = 'col-sm-6 col-md-5';
		$vars['page']['second_sidebar_class'] = 'col-sm-12 col-md-3';
	}
	
	//add some intuitive template suggestions for pages
	if (isset($vars['node'])) {
		$vars['theme_hook_suggestions'][] = 'page__'. $vars['node']->type;
	}
}


/**
 * Override or insert variables into the node template.
 */
function integ14_preprocess_node(&$variables) {
  $variables['submitted'] = t('Published by !username on !datetime', array('!username' => $variables['name'], '!datetime' => $variables['date']));
  if ($variables['view_mode'] == 'full' && node_is_page($variables['node'])) {
    $variables['classes_array'][] = 'node-full';
  }
}

/**
 * Preprocess variables for region.tpl.php
 *
 * @param $variables
 *   An array of variables to pass to the theme template.
 * @param $hook
 *   The name of the template being rendered ("region" in this case.)
 */
function integ14_preprocess_region(&$variables, $hook) {
  // Use a bare template for the content region.
  if ($variables['region'] == 'content') {
    $variables['theme_hook_suggestions'][] = 'region__bare';
  }
}

/**
 * Override or insert variables into the block templates.
 *
 * @param $variables
 *   An array of variables to pass to the theme template.
 * @param $hook
 *   The name of the template being rendered ("block" in this case.)
 */
function integ14_preprocess_block(&$variables, $hook) {
  // Use a bare template for the page's main content.
  if ($variables['block_html_id'] == 'block-system-main') {
    $variables['theme_hook_suggestions'][] = 'block__bare';
  }
  $variables['title_attributes_array']['class'][] = 'block-title';
}

/**
 * Override or insert variables into the block templates.
 *
 * @param $variables
 *   An array of variables to pass to the theme template.
 * @param $hook
 *   The name of the template being rendered ("block" in this case.)
 */
function integ14_process_block(&$variables, $hook) {
  // Drupal 7 should use a $title variable instead of $block->subject.
  $variables['title'] = $variables['block']->subject;
}

/**
 * Changes the search form to use the "search" input element of HTML5.
 */
function integ14_preprocess_search_block_form(&$vars) {
  $vars['search_form'] = str_replace('type="text"', 'type="search"', $vars['search_form']);
}

/**
 * Overwrite theme_button()
 * @file template.php
 * Add a class to buttons so that they look right.
 */
function integ14_button($variables) {
	$element = $variables['element'];
	if(!empty($element['#type']) &&  $element['#type'] == 'submit') {
		$element['#attributes']['class'][] = 'btn btn-primary btn-lg';
	}
	
	$variables['element'] = $element;
	
	return theme_button($variables);
}

/**
 * Overwrite theme_form_alter()
 * @file template.php
 * We are adding a special bootstrap class for all of the form elements
 */
function integ14_form_alter(&$form, &$form_state, $form_id) {
	$accepted_types = array(
		'textfield',
		'submit',
		'select'
	);
	//the array key 'submitted' is used for webforms
	if(!empty($form['submitted'])) {
		$form['submitted'] = add_boostrap_form_class($form['submitted']);
	} else { 
		$form = add_boostrap_form_class($form);
	}
}

function add_boostrap_form_class($form) {
	$accepted_types = array(
		'textfield',
		'select',
		'email',
		'date',
		'webform_email',
		'textarea',
		'password',
	);
	foreach(element_children($form) as $key) {
		if(!empty($form[$key]['#type']) && in_array($form[$key]['#type'], $accepted_types)) {
			$form[$key]['#attributes']['class'][] = 'form-control';
		} elseif (sizeof(element_children($form[$key])) > 0) {
			$form[$key] = add_boostrap_form_class($form[$key]);
		}
	}
	
	return $form;
}

/**
 * Overwrite theme_image()
 * @file template.php
 * We remove the height attribute so images scale well when the responsiveness kicks in
 */
function integ14_image($variables) {
	unset($variables['height'], $variables['attributes']['height']);
	
	return theme_image($variables);
}

/**
 * Custom menu_tree()
 * @file template.php
 * We create a custom menu tree <ul> function to use on sub menus
 */
function integ14_menu_tree__bootstrap_dropdown($variables) {
  return '<ul class="dropdown-menu">'.$variables['tree'].'</ul>';
}

/**
 * Overwrite menu_tree()
 * @file template.php
 * Add bootstrap classes to the menu wrapper <ul>
 */
function integ14_menu_tree__main_menu($variables) {
	return '<ul class="nav navbar-nav navbar-right">'.$variables['tree'].'</ul>';
}

/**
 * Overwrite menu_link()
 * @file template.php
 * Add bootstrap classes to the menu links <li>
 */
function integ14_menu_link__main_menu($variables) {
	$element = $variables['element'];

	if ($element['#below']) {
		$element['#attributes']['class'][] = 'dropdown';
		$element['#localized_options']['attributes']['class'][] = 'dropdown-toggle';
		$element['#localized_options']['attributes']['data-toggle'] = 'dropdown';
		$element['#below']['#theme_wrappers'] = array('menu_tree__bootstrap_dropdown');
	}
	
	$variables['element'] = $element;
	
	return theme_menu_link($variables);
}