
var preview = 
{
	url : null,
	printURL : null, 
	embedURL : null,
	pageTransitioning : false,
	multiOrientations : false,
	projectWH : [320,480],
	delayStart : 1000,
	loaded : false,
	pageScale : 1,
	pageRotation : 0,
	pageTranslation : [0, 0],
	viewportScaled : false,
	parentAccessible : true,
	currentFrameScale : 1,
	navigationStackBack : new Array(),
	navigationStackForward : new Array(),
	navigationQueueNext : new Array(),
	navigationQueueFlow : new Array(),
	navigationCompleted : false,
	navigationEnabled : false,
    navigationDefaultTransition : null,

	initExported : function()
	{
		if ($("#previewPage").size() > 0)
		{
			$(window).on('message', preview._crossDomainCallListener);
		}

		preview._showPreviewPage(false);
	},
	
	scaleFrame : function(externalPreview, resizing)
	{
		resizing = resizing || false;
		externalPreview = externalPreview || false;

		//Avoid scaling when the project is not loaded yet
		//Exception when the windows is being resized since the project was already loaded
		if (!preview.loaded && !resizing && externalPreview)  { return; }

		//DA:26-Mar-2012: When the preview is loaded to print or embedded or export to image, don't scale the project
		if (window.g_print || window.g_embedded || window.g_imgExport == "true") { return; }

		var previewPanel = $("#previewPage");
		var previewWindow = window;

		// contained...
		if (previewPanel.size() == 0)
		{
			if (preview.parentAccessible)
			{
				previewPanel = $("#previewPage", window.parent.document);
				previewWindow = window.parent;
			}
			else if (window.parent !== window)
			{
				preview._crossDomainCall(window.parent, 'scaleFrame', arguments);
				return;
			}
		}

		if(!externalPreview && previewPanel.size() != 1)  // we are previewing outside the iframe or not previewing
		{
			if (previewPanel.size() == 0 && utils.isMobileDevice() && !externalPreview)
			{
				preview.scaleViewport();
			}
			return;
		}

		//DA:12-Mar-2012: Take the orientation of the current page
		var screenWH = window.g_embedded ? [window.innerWidth, window.innerHeight] : [previewPanel.width(), previewPanel.height()];
		var sharePanel = previewPanel.siblings("#previewShare");

		//DA:11-Mar-2012: Adjust margins according to the new styles
		//Added taking care of the Horizontal scaling
		var minimumMargin = 310;
		if (sharePanel.size() > 0)          //When the Preview Share is present account for its presence or the signup panel
		{
			minimumMargin = 0;              //By default no margin when the Share Panel is present
			if(sharePanel.is(":visible"))   //When the Preview Share is Visible set the margins according to its size
			{
				var left = isNaN(parseFloat(sharePanel.css("left"))) ? 0 : parseFloat(sharePanel.css("left"));
				minimumMargin = left + parseFloat(sharePanel.width()) + parseFloat(sharePanel.css('border-right-width')) + 20;
			}
			else
			{
				var signUpPanel = $("#previewSignup:visible", window.parent.document);
				if (signUpPanel.size() > 0) //When the signup panel is visible set the margins according to its size
				{
					var left = isNaN(parseFloat(signUpPanel.css("left"))) ? 0 : parseFloat(signUpPanel.css("left"));
					minimumMargin = left + parseFloat(signUpPanel.width()) + parseFloat(signUpPanel.css('border-right-width')) + 20;
				}
			}
		}

		var availableX = Math.max($(previewWindow).width() - minimumMargin, minimumMargin);
		var availableY = $(previewWindow).height() - 120;           //80 is for the top space
		var diffY = screenWH[1] - availableY;
		var diffX = screenWH[0] - availableX;
		var scaleToApplyX = 1;
		var scaleToApplyY = 1;

		//Calculates possible scales
		if(diffY > 0) // preview not big enough, needs to scale down vertically.
		{
			scaleToApplyY = (availableY / (availableY + diffY));
		}
		if(diffX > 0) // preview not big enough, needs to scale down horizontally.
		{
			scaleToApplyX = (availableX / (availableX + diffX));
		}

		var scale = Math.min(scaleToApplyX, scaleToApplyY);

		//DA:13-Mar-2012: When multiple orientations are present show always the same dimensions
		if (preview.multiOrientations)
		{
			var screenInverseWH = [screenWH[1], screenWH[0]];
			diffY = screenInverseWH[1] - availableY;
			diffX = screenInverseWH[0] - availableX;
			if(diffY > 0) // preview not big enough, needs to scale down vertically.
			{
				scaleToApplyY = (availableY / (availableY + diffY));
			}
			if(diffX > 0) // preview not big enough, needs to scale down horizontally.
			{
				scaleToApplyX = (availableX / (availableX + diffX));
			}
			var scaleInverse = Math.min(scaleToApplyX, scaleToApplyY);
			scale = Math.min(scale, scaleInverse);
		}
		//scale = Math.max(scale, 0.25);
		
		var newMargin = minimumMargin + (availableX - screenWH[0]) / 2;
		if (newMargin < minimumMargin)
		{
			scale = scale - 0.02;
			newMargin = minimumMargin + (availableX - screenWH[0]) / 2;
		}

		var newMarginTop = ($(previewWindow).height() - previewPanel.height()) / 2;
		previewPanel.css({
			"-webkit-transform" : "scale(" + scale + ")",
			"-moz-transform" : "scale(" + scale + ")",
			"left" : newMargin + "px",
			"top": newMarginTop + "px"
		});


		preview.currentFrameScale = scale;

		preview._showPreviewPage(true);
	},

	scaleViewport : function(activePage)
	{
		// TODO: scaling by viewport meta tag should actually be here
		if (!preview.viewportScaled)
		{
			activePage = activePage || $(".ui-page-active");
			if (activePage.attr("id") != "home")
			{
				var content = $(".ui-content", activePage);
				var windowWidth = window.innerWidth;// $(document.body).width();
				var windowHeight = preview.getTrueHeight();
				var windowWH = windowWidth > windowHeight ? [windowHeight, windowWidth] : [windowWidth, windowHeight];

				var pageWidth = preview.projectWH[0];
				var pageHeight = preview.projectWH[1]
				var pageWH = pageWidth > pageHeight ?  [pageHeight, pageWidth] : [pageWidth, pageHeight];

				preview.pageScale = Math.min(windowWH[0] / pageWH[0], windowWH[1] / pageWH[1]);
				preview.applyPageTransforms(activePage);

				//var newHeight = (pageWH[windowWidth > windowHeight ? 0 : 1] * preview.pageScale) + 2;
				//content.parent().css('height', newHeight + 'px');
			}
			if (utils.hideBrowserBar())
			{
				window.scrollTo(0, 1);
			}
		}
	},

	applyPageTransforms : function(page)
	{
		var scale = preview.pageScale != 1 ? 'scale(' + preview.pageScale + ') ' : '';
		var rotate = preview.pageRotation != 0 ? 'rotate(' + preview.pageRotation + 'deg)' : '';
		var translate = (preview.pageTranslation[0] || preview.pageTranslation[1]) ? ' translate(' + preview.pageTranslation[0] + 'px,' + preview.pageTranslation[1] + 'px)' : '';

		var transform = scale + rotate + translate;

		$('.widgetHolder', page).css({
			'-webkit-transform' : transform,
			'-moz-transform' : transform,
			'transform' : transform
		});
	},

	_showPreviewPage : function(show)
	{
		if (typeof show == 'undefined')
		{
			show = true;
		}
		
		var previewPage = $('#previewPage');
		if (previewPage.size() == 0)
		{
			if (preview.parentAccessible)
			{
				previewPage = $('#previewPage', window.parent.document);
			}
			else if (window.parent !== window)
			{
				preview._crossDomainCall(window.parent, '_showPreviewPage', [show]);
			}
		}

		previewPage.css({visibility: show ? 'visible' : 'hidden'});
	},

	updateExportUi: function(result) {
		//console.log('results: ', result);
		var links = {
			Pages: $('#previewShareContainer .shareLinkExportImg'),
			Project: $('#previewShareContainer .shareLinkExportImgFull')
		};
		var $msgBox;
		var types = ['Pages', 'Project'];
		var resultData;
		var downloadLink;

		for(var i=0, len=types.length; i<len; i++) {
			resultData = result['export'+types[i]];
			$msgBox = links[types[i]].next('.msg');

			if(resultData && resultData.snapshotId) {
				//console.log('msg: ', $msgBox, resultData.status);
				if(resultData.status === 'FINISHED') {
					$msgBox.html('<a class="export-link" rel="'+resultData.snapshotId+'">Download ('+resultData.processDate+')</a>');
					downloadLink = $msgBox.find('.export-link');
					downloadLink.click(function(snapshotId) {
						window.open(document.location.origin + document.location.pathname + 'snapshot/'+snapshotId , "_snapshot");
					}.bind(downloadLink, resultData.snapshotId));
					$msgBox.removeClass('pulsing');
				} else if(resultData.status === 'STARTED' || (resultData.status === 'NEW' && resultData.queue === 0 )) {
					$msgBox.html('exporting...');
					$msgBox.addClass('pulsing');
					share.startExportPolling(resultData.snapshotId);
				} else if(resultData.status === 'NEW') {resultData
					$msgBox.html('queued ('+resultData.queue+')...');
					$msgBox.addClass('pulsing');
					share.startExportPolling(resultData.snapshotId);
				} else if(resultData.status === 'FAILED') {
					$msgBox.html('export failed...');
					$msgBox.removeClass('pulsing');
				}
			} else {
				$msgBox.html('');
				$msgBox.removeClass('pulsing');
			}
		}


	},

	getLastExports: function() {
		var projectId = project.get('id');

		$.ajax({
			url: "./index.php",
			type: "POST",
			data: {
				t: 'getLastExport',
				objectId: projectId
			},
			success: function(result, textStatus, jqXHR) {
				var resultData = JSON.parse(result);
				preview.updateExportUi(resultData);
			}//,
//			error: function(jqXHR, textStatus, errorThrown) {
//				console.log('error fetching exports');
//			}
		});
	},

	// Toggle for the preview screen
	// move to hud and makethis preview only?
	open: function (e, p) // p = page object = optional.
	{
		//console.log('preview.open: ');
		preview.getLastExports();
		canvas2.setEditorVisibility(false);
		$('#previewPage').contents().find('body').remove();
		$("#hud .hud-buttons .hud-secondary").hide();
		fluid.command.create('hideButton').dispatchTo('fluid.controllers.timeline');
		hint.show("startedPreview");
		preview.hideMenu();
		fluid.controllers.bin.hide();

		//DA: 22-Mar-2012: Hide iFrame before it's properly positioned and centered
		preview._showPreviewPage(false);

		var projectId = account.get("lastOpenProject");
		project.checkIntegrity(projectId);

		var pageWH = project.get("pageWH");
		var multiOrient = project.isMultiOrientation();

		// Preview in account. TODO: only if they are logged in.
		if(e && (e.currentTarget.id == 'preview' || e.currentTarget.id === 'pagePreview')) // TODO: HACK: when they click preview button, sync and generate qr code
		{
			project.save();
			project.sync(); // TODO: Only if its changed - already handles not logged in case!!
			
			var splitted = (document.location.href).split("?");
			var projectRef = projectId + "." + project.get("updated");

			/*
			preview.url = splitted[0] + "project/" + projectRef;
			preview.url2 = splitted[0] + "preview/" + projectRef;
			preview.download = splitted[0] + "export/" + projectRef;
			preview.printURL = splitted[0] + "?p=" + projectId + "&print=y&print_inter=y";
			
			//TODO: move this to a template. 
			var twitterMessage = 'Mobile mockup created with FluidUI.com from @FluidUI_Team ' + preview.url2;
			$('#previewFacebook').
				data('projectId', projectId).
				attr('href', 'http://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(preview.url2));
			$('#previewTwitter').
				data('projectId', projectId).
				attr('href', 'http://twitter.com/home?status=' + encodeURIComponent(twitterMessage));

			qrCode.setURL(preview.url, 200);
			$("#previewLink2").html(preview.url2); //.attr("href", preview.url2);
			 */
			share.init(projectId);

			preview.embedURL = splitted[0] + "embed/" + projectRef;

			var embedCode = $("#tmplEmbedCode").tmpl({
				url: preview.embedURL,
				width: multiOrient ? Math.max(pageWH[0], pageWH[1]) : pageWH[0] + 64, // TODO: a horrible way of allowing space for Fluid icon
				height: multiOrient ? Math.max(pageWH[0], pageWH[1]) : pageWH[1],
				multiorient: multiOrient
			}).html();
			$("#embedCode").html(embedCode);
		}
		
		// the iframe
		if(account.get("loggedIn") != "yes")
		{
			$("#previewSignup").show();
		}

		//$("#previewPage").css({width: pageWH[0], height:pageWH[1]}).attr('src', (document.location.href.indexOf('?') == -1 ? '?' : '&') + "p=" + projectId + "&preview=y");
		$("#previewPage").css({width: pageWH[0], height:pageWH[1]}).attr('src', 'project/' + projectId );
		$("#previewHolder").fadeIn(200).addClass("open");

		preview.displaySharePanel();

	},
	
	// move to hud and makethis preview only?
	close : function ()
	{
		canvas2.setEditorVisibility(true);
		hint.restart();
		$("#hud .hud-buttons .hud-secondary").fadeIn(300);
		fluid.command.create('showButton').dispatchTo('fluid.controllers.timeline');
		$("#previewPage").find(".widgetHolder").empty();
		$("#previewSignup").hide();
		$("#previewHolder").removeClass("open").fadeOut(200);
		$(".messageError").hide();
		signup.toggleTabMessage();

		preview.startPage = null;
		fluid.controllers.bin.show();
	},

	displaySharePanel : function(display)
	{
		var show = display == undefined ? true : false;
		if (project.readOnly())
		{
			show = false;
		}

		if (show)
		{
			if(account.get("loggedIn") == "yes")
			{
				$("#previewShare").show();
				preview.updateScrollbar();
			}
		}
		else
		{
			$("#previewShare").hide();
		}
	},
	
	// Callback after remotely viewed project download. Con
	parseDownload : function(respData, textStatus, jqXHR) // ajax response.
	{
		var projUnavailMsg = "Couldn't download correctly (has it been deleted/made inactive?)";

		try
		{
			var proj = JSON.parse(jqXHR.responseText); // jqXHR.response does not work on iOS mobile.
		}
		catch(e)
		{
			$("body").html("Unable to parse download - unknown error (1)");
			throw ("Error Downloading " + item + "Caller:" + arguments.callee.caller + " Second level:" + arguments.callee.caller.caller + "loadSate" + loading_Stage_Check ); // gracefully handle - seems to happen in preview.
		}
		
		if (proj.r != 's')
		{
			preview.displayErrorMessageOnLoad(projUnavailMsg);
			//console.log("Project download fail:", proj);
			return false;
		}
		
		try // this can fail if the project is too big. 
		{
			var data = JSON.parse(proj.t.toString()); // TODO: simplify this so it doesnt need a double parse.
		}
		catch(e)
		{
			preview.displayErrorMessageOnLoad("Unable to download the mockup - download was interrupted.");
			//console.log("Error", proj, e);
		}

		var proj = data[g_preview];
		if (proj && proj.active === false)
		{
			preview.displayErrorMessageOnLoad(projUnavailMsg);
			return false;
		}

		if(preview.exported) {
			preview.afterPreviewLoad(data);
		} else {
			return data;
		}

		// draw is the callback.
		//console.log("Its a parseDownloadedData ", respData);		
	},

	displayErrorMessageOnLoad : function(msg)
	{
		$("body").html(msg);
		preview.scaleFrame(true, true);
	},

	afterPreviewLoad: function(projectData) {
		// set branding
		var deviceScreen = branding.deviceScreen(),
			device = deviceScreen.device,
			screenProps = deviceScreen.screen,
			proj = projectData[window.g_preview] || projectData,
			deviceModel = proj.deviceModel,
			splashP,
			splashL,
			landscape = window.innerWidth > window.innerHeight,
			homePageStyle = document.getElementById('homePageStyle'),
			linkTag =
				'<link id="appIcon" rel="apple-touch-icon" href="'
					+ (branding.getUrl('icon', null, proj) || 'img/apple-touch-icon-144.png')
					+ '" />';

		if (/iPhone/.test(deviceModel)) {
			splashP = (
				branding.getUrl('splash' + deviceModel, screenProps.splash, proj)
				|| 'img/fluidLoading' + branding.screens[deviceModel].splash + '.png');

			linkTag +=
				'<link id="splashP" rel="apple-touch-startup-image" href="'
					+ splashP
					+ '" />';
		}
		else {
			splashP = branding.getUrl('splashP' + deviceModel, screenProps.splashP, proj)
				|| (screenProps.splashP? 'img/fluidLoading' + screenProps.splashP + '.png': '');

			splashL = branding.getUrl('splashL' + deviceModel, screenProps.splashL, proj)
				|| (screenProps.splashL? 'img/fluidLoading' + screenProps.splashL + '.png': '');

			linkTag +=
				'<link id="splashP" rel="apple-touch-startup-image" sizes="' + screenProps.splashP + '" media="(orientation: portrait)" href="'
					+ splashP
					+ '" />'

					+ '<link id="splashL" rel="apple-touch-startup-image" sizes="' + screenProps.splashL + '" media="(orientation: landscape)" href="'
					+ splashL
					+ '" />';
		}

		homePageStyle.innerHTML = 
			'#homePage { background: url('
			+ (landscape && splashL? splashL: splashP)
			+ ') no-repeat bottom; '

			+ 'background-size: '
			+ (/iPad/.test(deviceModel)? (landscape
					? '1024px 748px;'
					: '764px 1004px;')
				: deviceModel === 'iPhone5'? '320px 568px;'
					: deviceModel === 'iPhone'? '320px 460px;'
						: (landscape
							? proj.pageWH[0] + 'px ' + proj.pageWH[1] + 'px;'
							: proj.pageWH[0] + 'px ' + proj.pageWH[1] + 'px;'))
			+'}';

		// console.log(linkTag);
		// console.log([device, screen.width, 'x', screen.height, screenProps.splashP, screenProps.splashL].join(' '));

		if (!device) {
			// console.log('Screen not matched | ' + ['pixelRatio: ', window.devicePixelRatio, ' | ', screen.width, 'x', screen.height].join(' '));

			if (!splashP && !splashL) {
				document.head.removeChild(homePageStyle);
				$('#default-branding-links').tmpl().appendTo('head');
			}
		}

		$('head').append(linkTag);
		// end set branding

		$(document).ready(function loadingPreviewMode(e)
		{
			if (utils.isMobileDevice()) {
				$('body').addClass('mobile');
			}

			//widget.useCanvas = ((browserDetect.browser == 'Safari')  || (navigator.userAgent.match(/Android/i) == "Android")) ?  true : false;
			widget.useCanvas = true; // always needed here - issues on device.


			if(browserDetect.OS == 'iOS' && !window.navigator.standalone) {
				if(window.location.href.indexOf('skipInstructions=true') !== -1 ) {
					preview.runDraw(projectData);
					$('#install').hide();
				} else {
					$("#tmplInstall").
						tmpl({
							safari: window.navigator.userAgent.indexOf('Safari') > 0,
							ipad: navigator.platform === 'iPad'
						}).
						appendTo("body"). // iOS install prompt
						find('#forceDevicePreview').
						click(function() {
							preview.runDraw(projectData);
							$('#install').hide();
							return false;
						});
				}

				var d = new Date();
				var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
				var min = d.getMinutes();
				document.title = d.getDate() + " " + months[d.getMonth()] + " " + d.getHours() + ":" + (min < 10 ? "0" : "") + min;
			} else { // check for android / on device.
				//console.log('preview.load: ', g_preview);
				//widget.useCanvas = ((browserDetect.browser == 'Safari')  || (navigator.userAgent.match(/Android/i) == "Android"));
				preview.runDraw(projectData);
			}

			$(window).bind('orientationchange', function() {
				$('body').scrollTop(0).scrollLeft(0);
				loading_Stage_Check = "preview Loaded";
			});
		});

	},
	
	// TODO: When local, use cache, its faster/cheaper - but watch android as it has issues. Talk to dave.
	load : function(previewId, callback)
	{
		// parent may be inaccessible due to cross-domain issues when viewing exported mockup
		try
		{
			// Firefox will throw an exception, while WebKit will show console message and continue
			preview.parentAccessible = typeof window.parent.document != 'undefined';
		}
		catch (e)
		{
			preview.parentAccessible = false;
		}

		var fromStorage = storage.get(previewId);

		//DA: 09-Mar-2012: Use storage when available otherwise sync
		if(fromStorage && fromStorage.unloaded !== true) {
			if (typeof callback === 'function') {
				callback(fromStorage);
			}

			if(window.g_print) {
				preview.runDraw(previewId);
			}
		}
		else {
			ajax.syncDown(previewId, function (response) {
				var data = preview.parseDownload.apply(this, arguments);

				if (typeof callback === 'function') {
					callback(data);
				}

				response = JSON.parse(response);
				var projData = JSON.parse(response.t);
				if(window.g_print) {
					preview.runDraw(projData);
				}
			});
		}
	},
	
	// g_preview is always sent here. This draws the Pages, links and widgets in preview or print mode (css differences for print mode)
	// also, export mode. 
	draw : function(data)
	{
		//console.log("Drawing a preview", data);
		if(!data) { return false;}

		if ($.mobile)
		{
			$.mobile.defaultHomeScroll = 0;
		}
	
		for(var key in data)
		{
			storage.setTempItem(key, data[key]);
		}

		var proj = data[g_preview] || data;

		// TODO: scaling should be better done in scaleViewport, which should be called only once at draw time 
		//       or when scale changes due to orientation change or going full-screen

		preview.viewportScaled = window.navigator.hasOwnProperty('standalone') && window.navigator.standalone;
		preview.projectWH = [proj.pageWH[0], proj.pageWH[1]];

		var viewportWidth = preview.viewportScaled ? preview.projectWH[0] : $(window).width();
		var viewportHeight = preview.viewportScaled ? preview.projectWH[1] : preview.getTrueHeight();

		if (utils.isMobileDevice() && viewportWidth > viewportHeight && window.screen.width < window.screen.height)
		{
			var tmp = viewportWidth;
			viewportWidth = viewportHeight;
			viewportHeight = tmp;
		}

		var scale = preview.viewportScaled ? Math.min(window.screen.width / viewportWidth, window.screen.height / viewportHeight) : 1;
		$("#metaViewport").attr("content", "width=" + viewportWidth + ",height=" + viewportHeight +
			",minimum-scale=" + scale + ",maximum-scale=" + scale + ",initial-scale=" + scale + ",user-scalable=0");

		if (preview.parentAccessible)
		{
			if (!window.g_embedded)
			{
				try
				{
					var parent = $('#previewPage', window.parent.document); // the iframe
					if (parent.size() > 0)
					{
						parent.css({width: proj.pageWH[0], height: proj.pageWH[1], "min-width": proj.pageWH[0], "min-height": proj.pageWH[1]});  //
						$(".ui-mobile-viewport").css("overflow", "hidden");
					}
				}
				catch(e)
				{
					//console.log("Cross domain check fail - in exported preview mode.");
				}
			}

			preview.scaleFrame();
		}
		else if (window.parent !== window)
		{
			preview._crossDomainCall(window.parent, 'scaleFrame');
		}

		$(".pageList").css("height", preview.getTrueHeight() + "px");

		document.title = proj.name;

		//this flag informs phantomJS that the page and project was loaded properly - see genMocupScreens.js for details
		document.projectLoaded = true;

        //quick solution to the missing pages
        //get rid of it as soon as universal checkIntegrity is ready
        for(var i=0; i<proj.pages.length; i++) {
            if(!storage.get(proj.pages[i])) {
                proj.pages.splice(i,1);
                i--;
            }
        }
        if(!storage.get(proj.homepage)) {
            proj.homepage = proj.pages[0];
        }
        //end of fix

		// TODO: this is remarkably inefficient. 
		var projOrient = proj.orientation;
		preview.multiOrientations = false;
		for(var i = 0, len = proj.pages.length; i < len; i++)
		{
			if (storage.get(proj.pages[i]).orientation != projOrient)
			{
				preview.multiOrientations = true;
				break;
			}
		}

		if (browserDetect.OS == 'Android' && preview.multiOrientations)
		{
			var windowWidth = $(window).width();
			var windowHeight = window.outerHeight || getTrueHeight();
			$('.ui-mobile-viewport').css({'min-height': Math.max(windowWidth, windowHeight) + 'px'});
		}

		if (window.g_embedded && (preview.projectWH[0] > preview.projectWH[1] || preview.multiOrientations))
		{
			//$('#home').css({'padding-left': Math.abs(preview.projectWH[0] - preview.projectWH[1]) >> 1})
		}

		if (window.g_print || window.g_imgExport)
		{
			for(var i = 0, len = proj.pages.length; i < len; i++)
			{
				preview.drawPage(proj.pages[i], proj);
			}

            $('#font-preloader').remove();
            if( window.g_imgExport ) {
                var pagesArr = [];
                var pageObj = {};
                for(var i=0; i<proj.pages.length; i++) {
                    pageObj = $.extend({}, storage.get(proj.pages[i]));
                    pageObj.id = proj.pages[i];
                    pagesArr.push(pageObj);
                    //console.log('page: ', i, storage.get(proj.pages[i]) );
                }

				preview.pagesArr = pagesArr;

                //console.log('pages : ', pagesArr);

				preview.pagesArr = pagesArr;

                setTimeout(function() {
                    $('#home').hide();
                    if (typeof window.callPhantom === 'function') {
                        window.callPhantom({ event: 'finishedrendering', pages: pagesArr });
                    }
                }, 3000);
            }

		}
		else
		{
			var frameStartPage = null,
				home;

				try {
					// if the preview is in an iFrame, check for specified start page from parent window
					var frameWindow = window.frameElement && window.frameElement.ownerDocument.defaultView;

					frameStartPage = frameWindow && frameWindow.preview && frameWindow.preview.startPage;
				}
				catch (error) {
					frameStartPage = null;
				}

				home = frameStartPage ||
					(proj.homepage ? proj.homepage : proj.pages[0]); // the project's homepage

			preview.drawPage(home, proj);

			if(typeof g_previewMode != 'undefined' && g_previewMode == true) // preview, not print stuff
			{

				preview.bindMobileEvents(proj.links);
				g_homepage = home; // todo: just set the homepage to this?

				//DA: 16-Mar-2012: Add a delay to display the first page, so all elements in the page are displayed properly
				setTimeout(function()
				{
					preview.changePage("#" + home, null, false, true);
				}, preview.delayStart);
			}
		}
		//localStorage.setItem("lastUpdated", data[g_preview].updated); // needed for iphone app updates.
	},

    showPage: function(id) {
        //console.log('showing page: ', id);
        $('.previewPage').hide();
        $('#'+id).show();

        if (typeof window.callPhantom === 'function') {
            window.callPhantom({ event: 'shownPage', id: id});
        }
    },

	drawPage : function(pageId, proj)
	{
		//console.log("Drawing page: ", pageId);
		if (!proj)
		{
			proj = storage.get(g_preview);
		}

		var bgColor = window.g_imgExport == "true" ? "white" : "transparent";
		var p = storage.get(pageId);
        //remove following line when checkIntergirty is universal
        if(!p) return;
		var wh = [p.width, p.height];
		var tmplVars = {
			pageId: pageId,
			width: wh[0],
			height: wh[1],
			widthScreen: $(window).width(),
			heightScreen: preview.getTrueHeight(),
			bgColor: bgColor
		};

		if (window.g_embedded)
		{
			if (preview.multiOrientations)
			{
				if (wh[0] > wh[1])
				{
					tmplVars.top = (wh[0] - wh[1]) >> 1; // integer devision by 2
				}
				else
				{
					tmplVars.left = (wh[1] - wh[0]) >> 1;
				}
			}
			else
			{
				tmplVars.left = $('.previewLogoHolder').outerWidth();
			}
		}

		if ((window.g_print) && (p.notes != undefined))
		{
			tmplVars.notes = p.notes[3];
			tmplVars.title = p.name == undefined ? "" : p.name;
		}


		var pageElem = $("#tmplPreviewPage").tmpl(tmplVars).appendTo("body");
		preview.drawWidgets(g_preview, pageId, proj.links);
		preview.showLinks(proj.links, pageId);
		$("#" + pageId).bind('pageshow', preview.navigateInit);
	},

	//better fix needed - for samsung/veissman build.
	changePage : function(page, args, navigateBack, forceNoTransition)
	{
		var pageId = page.substr(1);

		if ($(page).size() == 0)
		{
			preview.drawPage(pageId);
			$(page).trigger('pageinit');
		}

		$(page).addClass("visited");
        var argsToSend = args;
        var fixTransition = forceNoTransition == "undefined" ? true : !forceNoTransition;
        if ((!argsToSend) && (fixTransition))
        {
            var transition = preview.navigationDefaultTransition.split(':');
            var reverse = (transition.length > 1) ? true : false;
            argsToSend = { transition: transition[0], reverse : reverse};
        }
        //console.log("Changing Page", page, args, argsToSend);
		$.mobile.changePage(page, argsToSend);

		window.setTimeout(function() {
			preview.preloadLinkedPages(pageId);
			preview._fixNavigationStatus(pageId, args, navigateBack);
		}, 100);
	},

	_fixNavigationStatus : function(pageId, args, navigateBack)
	{
		//Add to Back Stack to allow BACK navigation (ONLY When not navigating Back)
		if ((preview.navigationStackBack.length > 0) && (navigateBack != 2))
		{
            var argsToBack = args;
            if (preview.navigationQueueNext.length > 0)
            {
                if (preview.navigationQueueNext[0].args)
                {
                    argsToBack = preview.navigationQueueNext[0].args;
                    argsToBack.reverse = !argsToBack.reverse;
                }
            }
			preview.navigationStackBack.push({ pageId: pageId, args: argsToBack });
		}

		//Add to Flow navigation, in order to allow FORWARD navigation after whole flow has been completed
		//Remove the page from the current flow and add it again to place in the right navigation order
		preview.navigationQueueFlow = $.grep(preview.navigationQueueFlow, function(n, i){
			return n.pageId != pageId;
		});
		var isBlank = $("#" + pageId).hasClass("blank");
		if (!isBlank)
		{
            preview.navigationQueueFlow.push({ pageId: pageId, args: args });
		}

		//Remove the page from all possible Queues/Stack where the navigation could go FWD
		preview.navigationQueueNext = $.grep(preview.navigationQueueNext, function(n, i){
			return n.pageId != pageId;
		});
	},

	_isPageVisited : function(pageId)
	{
		var page = $("#" + pageId);
		if ((page.size() > 0) && (page.hasClass("visited")))
		{
			return true;
		}
		return false;
	},

	preloadLinkedPages : function(pageId)
	{
		if ((preview.navigationCompleted) && (preview.navigationQueueFlow.length > 1))
		{
			var copyQueue = preview.navigationQueueFlow.slice(0);
			var inQueue = copyQueue.pop();
			preview.navigationStackBack.push(inQueue);
			return;
		}

		var proj = storage.get(g_preview);
		var page = storage.get(pageId);

		var links = proj.links;

		var count = 0;
		var countBack = 0;
		$.each(links.linkOrigin, function(i, v)
		{
			if (links.linkType[i] == "ahref" && $('#' + v).closest('.page').attr('id') == pageId)
			{
				var destPageId = links.linkDest[i];
				var p = storage.get(destPageId);
                //remove following line when checkIntergirty is universal
                if(!p) return;
                var pageEl = $('#' + destPageId);
				if ((pageEl.size() == 0) && (p.widgets.length > 0))
				{
					//Add to the Queue of pages to be displayed
					var transition = links.transType[i].split(':');
					var reverse = (transition.length > 1) ? true : false;
					var args = { transition: transition[0], reverse : reverse};
					preview.navigationQueueNext.push({ pageId: destPageId, args: args });
					preview.drawPage(destPageId, proj);
					count++;
				}
                else if (pageEl.size() > 0)
                {
                    //Fix arguments for starting page
                    if ((preview.navigationQueueFlow.length > 0) &&
                        (destPageId == preview.navigationQueueFlow[0].pageId) && (!preview.navigationQueueFlow[0].args))
                    {
                        var transition = links.transType[i].split(':');
                        var reverse = (transition.length > 1) ? true : false;
                        preview.navigationQueueFlow[0].args = { transition: transition[0], reverse : reverse};
                    }
                }
			}

			//Save ONE link back ONLY when no Back navigation has been entered
			if ((preview.navigationStackBack.length == 0) && (countBack < 1))
			{
				if ((links.linkType[i] == "ahref") && (links.linkDest[i] == pageId))
				{
					//Find the page and verify if the page has already been visited
					var destPageId = preview.getPageIdForWidget(v);
					var p = storage.get(destPageId);
                    //remove following line when checkIntergirty is universal
                    if(!p) return;
					//If the page has not been visited, add it to the BACK navigation
					if ((!preview._isPageVisited(destPageId)) && (p.widgets.length > 0))
					{
						//Add to the Queue of pages to be displayed when navigating BACK
                        var transition = links.transType[i].split(':');
                        var reverse = (transition.length > 1) || transition[0] == "none" ? false : true;
                        var args = { transition: transition[0], reverse : reverse};
						preview.navigationStackBack.push({ pageId: destPageId, args: args });
						countBack++;
					}
				}
			}
		});

		//Search for non displayed pages in both navigation directions
		preview.preloadNextUndisplayedPage(proj);
		preview.preloadPreviousUndisplayedPage(proj);
	},

	preloadNextUndisplayedPage : function(proj)
	{
		return preview.findUnlinkedPage(proj, proj.pages, preview.navigationQueueNext, true);
	},

	preloadPreviousUndisplayedPage : function(proj)
	{
		var copy = proj.pages.slice(0);
		preview.findUnlinkedPage(proj, copy.reverse(), preview.navigationStackBack, false);
		if ((preview.navigationCompleted) && (preview.navigationQueueFlow.length > 1))
		{
			var copyQueue = preview.navigationQueueFlow.slice(0);
			var inQueue = copyQueue.pop();
			//console.log("Pushed to Back Preloading",  preview.navigationStackBack.length, inQueue.pageId);
			preview.navigationStackBack.push(inQueue);

		}
	},

	findUnlinkedPage : function(proj, pages, addToArray, drawPage)
	{
		if ((preview.navigationCompleted) || (addToArray.length > 0)) { return false; }

		var found = false;
		$.each(pages, function(i, pageId)
		{
			if (!preview._isPageVisited(pageId))
			{
				var p = storage.get(pageId);
				if (p.widgets.length > 0)
				{
					addToArray.push({ pageId: pageId, args: null });
					if (drawPage)
					{
						preview.drawPage(pageId, proj);
					}
					found = true;
					return false;
				}
			}
		});

		if (!found)
		{
			preview.navigateSetCompleted();
		}
        return found;
	},
	
	// upgrade links in preview mode with widgetLink class.
	showLinks : function(links, pageId)
	{
		$.each(links.linkOrigin, function(i, v)
		{
			if (links.linkType[i] == "ahref" && (!pageId || $('#' + v).closest('.page').attr('id') == pageId))
			{
				$("[id=" + v + "]").addClass("widgetLink");
				var id = $("[id=" + v + "]").attr("data-lockto");
				var ids = $('[data-lockto="' + id + '"]').each(function()
				{
					var subid = $(this).attr("id");
					if(preview.linkShowRipple(subid,v))
					{
						$("#" + subid).addClass("widgetLink");
					}
				});
				
				//console.log($("#" + v), "#" + v);
			}
		});
	},
	
	// list of all widgets.
	// TODO: or... go through each widget once, and draw it to the right place?
	// TODO: this does way too many DOM updates.
	drawWidgets : function(projectId, pageId, links)
	{
		var pageContent = $("#" + pageId).find("[data-role=content]");
		//console.log("pageContent", pageContent);
		
		var widg = [];
		for(var i in links.linkDest) // get the list of widgets for the page
		{
			if(links.linkType[i] == "template" && links.linkDest[i] == pageId)
			{
				var tmp = page.get(links.linkOrigin[i], "widgets");
				widg = widg.concat(tmp);
			}
		}
		
		// TODO: add them to the dom all at once. 	
		var tmp = page.get(pageId, "widgets"); // get all the widgets on the page.
		widgetList = widg.concat(tmp); // add them to any template widgets.

		for(var i = 0; i < widgetList.length; i++)
		{
			widget.checkIntegrity(widgetList[i]);
		}

		if (widgetList.length > 0)
		{
			var loadPreview = true;
			widget.load(pageId, widgetList, loadPreview);// Add widgets to page
		}
		else
		{
			preview.showBlankPage(pageId, links);
		}
	},

	showBlankPage : function(pageId, links)
	{
		var content = $("#blankPage").find(".pageList").html();
		var page = $("#" + pageId).find(".widgetHolder");
		page.html(content);
		page.parent().addClass("blank");
		$(".blankPageBackButton", page).bind("click", preview.navigateBack);
	},

	/*
	findLastSource : function(pageId, links)
	{
		var pos = -1;
		//Find link that directed the user to the blank page
		for(var i = 0; i < links.linkDest.length; i++)
		{
			if (links.linkDest[i] == pageId)
			{
				pos = i;
				break;
			}
		}

		//Find page that contains the original widget
		if (pos >= 0)
		{
			var widgetId = links.linkOrigin[pos];
			var proj = storage.get(g_preview);
			var pages = proj.pages;
			var lastPageId = '';
			$.each(pages, function(index, pId){
				var widgets = storage.get(pId).widgets;
				$.each(widgets, function(windex, wid){
					if (wid == widgetId)
					{
						lastPageId = pId;
						return false;
					}
				});
				if (lastPageId != '')
				{
					return false;
				}
			});
		}

		//If the page was found go back and hide the blank page screen
		if (lastPageId != "")
		{
			var transition = links.transType[pos].split(':');
			var reverse = (transition.length > 1) ? true : false;
			return { pageId: lastPageId, transition: transition[0], reverse : reverse };
		}

		return;
	},*/

	getPageIdForWidget : function(widgetId)
	{
		var proj = storage.get(g_preview);
		var pages = proj.pages;
		var pageId = '';
		$.each(pages, function(index, pId){
			var widgets = storage.get(pId).widgets;
			$.each(widgets, function(windex, wid){
				if (wid == widgetId)
				{
					pageId = pId;
					return false;
				}
			});
			if (pageId != '')
			{
				return false;
			}
		});

		return pageId;
	},
	
	orient : function(e, pageElem, prevPageElem)
	{
		if (!window.g_embedded)
		{
			try
			{
				if (utils.isMobileDevice())
				{
					preview._orientMobile(pageElem, prevPageElem);
				}
				else
				{
					preview._orientParent(pageElem, prevPageElem);
				}

				preview.scaleViewport(pageElem);
			}
			catch(e)
			{
				// in exported mode, will fail.
				// TODO: VK: is this still neccessary?
			}
		}
	},

	_orientationData : function(pageElem)
	{
		var proj = storage.get(g_preview);
		var page = storage.get(pageElem.attr('id'));
		var projWH = proj.pageWH || [320,480];

		var isPortraitPage = page.orientation ? (page.orientation != 'Landscape') : (page.width <= page.height);
		var isPageMisoriented = isPortraitPage ? page.width > page.height : page.width <= page.height; // in case a user entered width/height manually

		var orientationchangeEvent = $.event.special.orientationchange;
		var isPortraitWindow = (orientationchangeEvent && $.isFunction(orientationchangeEvent.orientation)) ?
			orientationchangeEvent.orientation() == 'portrait' :
			window.screen.width < window.screen.height;

		var isPortraitProject = projWH[1] >= projWH[0];
		var isInProjectOrientation = isPortraitPage && isPortraitProject || !isPortraitPage && !isPortraitProject;

		return {
			portrait: isPortraitPage,
			crossOriented: isPortraitWindow != isPortraitPage,
			multiOriented: preview.multiOrientations,
			projectOriented: isInProjectOrientation,
			width: projWH[0],
			height: projWH[1],
		};
	},

	_orientMobile : function(pageElem, prevPageElem, pageData)
	{
		pageData = pageData || preview._orientationData(pageElem);

		// the original idea was to calculate center of rotation, but this leads to some unneccessary complexities
		// when the page is also scaled down when it doesn't fit the mobile browser window; so now rotating around 
		// top-left and translating instead

		preview.pageRotation = pageData.crossOriented ? (pageData.portrait ? -90 : 90) : 0;
		preview.pageTranslation = preview.pageRotation ? (preview.pageRotation > 0 ? [0, -pageData.width] : [-pageData.width, 0]) : [0, 0];

		preview.applyPageTransforms(pageElem);

		// some horrible mishmash with reported window size is happening in iOS after orientation change;
		// window width is reported incorrectly by jQM so we'll have to set body width manually
		// Update: this also happens on Android tablets (not sure about phones)
		// TODO: the whole thing need to be rethought
		if (browserDetect.OS == 'iOS')
		{
			var screenWidth = window.screen.width * (preview.viewportScaled ? window.devicePixelRatio : 1);
			var screenHeight = window.screen.height * (preview.viewportScaled ? window.devicePixelRatio : 1);
			var isPortraitWindow = pageData.portrait != pageData.crossOriented;
			$(document.body).css({
				width: (isPortraitWindow ? Math.min(screenWidth, screenHeight) : Math.max(screenWidth, screenHeight)) + 'px'
			});
		}
		else if (utils.hideBrowserBar())
		{
			window.scrollTo(0, 1);
		}
	},

	_orientParent : function(pageElem, prevPageElem, pageData)
	{
		function orientPrevPage()
		{
			if (prevPageElem)
			{
				var center = Math.min(pageData.width, pageData.height) >> 1;
				var translate = '';
				
				if (pageData.portrait != pageData.projectOriented) // project is landscape
				{
					translate = ' translate(0,-' + center + 'px)';
				}

				$('.widgetHolder', prevPageElem).css({
					'-webkit-transform-origin': center + 'px ' + center + 'px',
					'-moz-transform-origin': center + 'px ' + center + 'px',
					'transform-origin': center + 'px ' + center + 'px',
					'-webkit-transform': 'rotate(90deg)' + translate,
					'-moz-transform': 'rotate(90deg)' + translate,
					'transform': 'rotate(90deg)' + translate
				});
			}
		}

		function orientPage()
		{
			preview.pageRotation = 90;
			preview.pageTranslation = [0, -pageData.width];
		}

		var parent = preview.parentAccessible && window.parent && $('#previewPage', window.parent.document); // the iframe
		if (!preview.parentAccessible || (parent && parent.size() > 0))
		{
			pageData = pageData || preview._orientationData(pageElem);
			if (pageData.crossOriented) { // if page orientation is different from the current frame orientation
				if (preview.parentAccessible) {
					var currTransform = parent.css('-webkit-transform') || parent.css('-moz-transform') || parent.css('transform') || '';
					if (currTransform == 'none')
					{
						currTransform = '';
					}

					// set up frame position and dimensions for new page; rotate the frame and the page so that 
					// the current page looks as it has been prior to the pos/size change; run the frame rotation
					// transition at the same time running the page change transition; clear the transformations 
					// in the end (in finishOrient())

					// Note: assinging css class to iframe doesn't work in webkit

					if (pageData.projectOriented) {
						// offset for the new frame position after rotation
						var offset = (pageData.height - pageData.width) >> 1;
						var parentTop = parseInt(parent.css('top'));   // parent.offset() seems to be affected by scale
						var parentLeft = parseInt(parent.css('left'));

						var transform = 'rotate(-90deg) ' + currTransform;
						parent.css({
							top: (parentTop - offset) + 'px',
							left: (parentLeft + offset) + 'px',
							width: pageData.width + 'px',
							height: pageData.height + 'px',
							'min-width': pageData.width + 'px',
							'min-height': pageData.height + 'px',
							'-webkit-transform': transform,
							'-moz-transform': transform,
							'transform': transform
						}).hide().show(); // hide and show ensure transform is applied at this point

						orientPrevPage();
					} else {
						orientPage();
					}

					var transform = 'rotate(' + (pageData.projectOriented ? 0 : -90) + 'deg) ' + currTransform;
					parent.
						css({
							'-webkit-transition': '-webkit-transform 0.3s ease-in-out',
							'-moz-transition': '-moz-transform 0.3s ease-in-out',
							'transition': 'transform 0.3s ease-in-out',
							'-webkit-transform': transform,
							'-moz-transform': transform,
							'transform': transform
						})
				}
				else if (window.parent !== window)
				{
					if (pageData.portrait)
					{
						orientPrevPage();
					}
					else
					{
						orientPage();
					}
					preview._crossDomainCall(window.parent, '_orientParent', [null, null, pageData]);
				}
			}
			fluidEvent.triggerPreview("changeOrientation", { }, true);
		}
	},

	finishOrient : function(e, pageElem, prevPageElem)
	{
		if (!window.g_embedded)
		{
			try
			{
				if (!utils.isMobileDevice())
				{
					preview._finishOrient(pageElem, prevPageElem);
				}
			}
			catch(e)
			{
				// in exported mode, will fail.
				// TODO: VK: is this still neccessary?
			}
		}
	},

	_finishOrient : function(pageElem, prevPageElem, pageData)
	{
		function clearPageOrientation()
		{
			if (pageElem || prevPageElem)
			{
				$('.widgetHolder', pageElem).add($('.widgetHolder', prevPageElem)).css({
					'-webkit-transform-origin': '',
					'-moz-transform-origin': '',
					'transform-origin': '',
					'-webkit-transform': '',
					'-moz-transform': '',
					'transform': '',
                    'width' : pageData.projectOriented ? pageData.width : pageData.height,
                    'height' : pageData.projectOriented ? pageData.height : pageData.width

				});
			}

			preview.pageRotation = 0;
			preview.pageTranslation = [0, 0];
		}

		var parent = preview.parentAccessible && window.parent && $('#previewPage', window.parent.document); // the iframe
		if (!preview.parentAccessible || (parent && parent.size() > 0))
		{
			pageData = pageData || preview._orientationData(pageElem);

			if (preview.parentAccessible)
			{
				preview.multiOrientations = pageData.multiOriented;
				
				var pageWH = pageData.projectOriented ?
					[pageData.width, pageData.height] :
					[pageData.height, pageData.width];

				// Note: assinging css class to iframe doesn't work in webkit
				parent
					.css({
						width: pageWH[0],
						height: pageWH[1],
						'min-width': pageWH[0],
						'min-height': pageWH[1],
						'-webkit-transition': '',
						'-moz-transition': '',
						'transition': '',
						'-webkit-transform': '',
						'-moz-transform': '',
						'transform': ''
					});

				clearPageOrientation();

				preview.scaleFrame();
			}
			else if (window.parent !== window)
			{
				clearPageOrientation();
				preview._crossDomainCall(window.parent, '_finishOrient', [null, null, pageData]);
			}
		}
	},
	
	bindMobileEvents : function(links)
	{
		scrollview.setup(links);

		function beforePageShow(e, data)
		{
			preview.pageTransitioning=true;
			preview.orient(e, $(e.target), data.prevPage);
			scrollview.showPage.call(e.target, e);
		}
		
		function afterPageShow(e, data)
		{
			scrollview.isScrolling = false;
			scrollview.isDoubleTapping = false;
			scrollview.isSwiping = false; 
			preview.pageTransitioning=false;

			preview.finishOrient(e, $(e.target), data.prevPage);

			$('.ui-scrollview-clip', e.target).scrollview('option', 'rotate', preview.pageRotation);

			if (window.g_imgExport == "true")
			{
				e.stopImmediatePropagation();
			}

			//window.scrollTo(0, 20); // do anything?
			setTimeout(function(){
				scrollview.isTapHolding = false;

				if (utils.hideBrowserBar())
				{
					window.scrollTo(0, 1);
				}
			}, 350);
		}

		function orientationChanged(e)
		{
			preview.orient(e, $.mobile.activePage);
			$('.ui-scrollview-clip', $.mobile.activePage).scrollview('option', 'rotate', preview.pageRotation);
		}
			
		function swipeAction(e)
		{
			scrollview.isScrolling = false;
			scrollview.isDoubleTapping = false;
			scrollview.isTapHolding = false;
			
			scrollview.isSwiping = true; // prevent the click after

			// correct swipe direction taking current rotation into account

			var swipeDegreeByDir = {'up': 0, 'right': 90, 'down': 180, 'left': 270};
			var swipeDirByDegree = {0: 'up', 90: 'right', 180: 'down', 270: 'left'};

			var swipeDir = e.type.substr(5); // 'swipe'.length() == 5
			var swipeDirRotated = swipeDirByDegree[(360 + (swipeDegreeByDir[swipeDir] - preview.pageRotation)) % 360];

			preview.handleUserInput('swipe' + swipeDirRotated, $(e.currentTarget).attr("id"), links);

			return false;
		}
		
		function tapAction(e)
		{
			e.stopImmediatePropagation(); // cancel a click if there is a tap too.

			if(scrollview.isSwiping) // cancel if its a drag up/down on a sized page.
			{
				scrollview.isSwiping = false;
			}
			else if(scrollview.isScrolling)
			{
				scrollview.isScrolling = false;
			}
			else if(scrollview.isDoubleTapping)
			{
				scrollview.isDoubleTapping = false;
			}
			else if(scrollview.isTapHolding)
			{
				scrollview.isTapHolding = false;
			}	
			else
			{
				preview.handleUserInput(e.type, $(e.currentTarget).attr("id"), links);
			}		
		}
		
		function tapHoldAction(e) // todo: prevent tap after taphold.
		{
			scrollview.isTapHolding = true;
			var wid = $(e.currentTarget).attr("id");
			preview.handleUserInput(e.type, wid, links);
		}
		
		function doubleTapAction(e)
		{
			//console.log("Double Tapping");
			scrollview.isDoubleTapping = true;
			var wid = $(e.target).parents(".pageWidget").attr("id");
			preview.handleUserInput("doubletap", wid, links);
		}
		
		function mouseFrameOut(event)
		{
			$(document).trigger("mouseup");
		}

		if (utils.isMobileDevice())
		{
			if ($.support.orientation)
			{
				$(window).bind("orientationchange", orientationChanged);
			}
			$(window).resize(function() { 
				window.setTimeout(function() { preview.scaleViewport($.mobile.activePage); }, 100);
			});
		}

		$("body")
			.bind("pageinit", function(event) { $(".pageWidget", event.target).doubletap(doubleTapAction); })
			.bind("pagebeforeshow", beforePageShow)
			.bind("pageshow", afterPageShow)
			.mouseleave(mouseFrameOut);
			
		$(document).bind("touchmove", false); // prevent browser scrolling
	
		$(".pageWidget")
			.live("swipeleft swiperight swipeup swipedown", swipeAction)
			.live("vclick", function(event) { event.preventDefault(); tapAction(event); }) // tap
			.live("taphold", tapHoldAction);
	},

	// type of event, target widget of the event (jquery object), links object 
	handleUserInput : function(type, wid, links)	
	{
		if(scrollview.isScrolling) // cancel if its a drag up/down on a sized page.
		{
			return false;
		}
		
		//console.log("handleUserInput", type, wid, links);

		type = (type == "vclick" || type == "click") ? "tap" : type; // if its click, change it to tap.
		 // if thereis a corresponding link.
		//console.log("Links:", wid, links.linkOrigin, i , links.triggerType[i], type);
		var linkArrayPosition = preview.linkCheck(wid, links);

		if(linkArrayPosition > -1 && links.triggerType[linkArrayPosition] == type)
		{
			preview.navigateSetIncompleted();
			var transition = links.transType[linkArrayPosition].split(':');
			var reverse = (transition.length > 1) ? true : false; 
			preview.changePage("#" + links.linkDest[linkArrayPosition], { transition: transition[0], reverse : reverse });
			//2013-05-14 BD: displayMenu was doing nothing - removed
			//preview.displayMenu(1000);
		}
		else
		{
			//console.log("  No action");
		}
	},
			
	signupComplete : function()
	{
		project.sync(); // TODO: Only if its changed!!
	},

	alertCopyEmbedCode : function(e)
	{
		notification.add("alert", "Embed Code Copied");
		tracker.record("copiedEmbedCode", 5, "", e);
	},

	showDebugInfo : function(msg)
	{
		var pre = $("#divDebugInfo").html();
		if (pre)
		{
			msg = pre + msg;
		}
		$("#divDebugInfo").remove();
		$("body").append("<div id='divDebugInfo'>" + msg + "<br/></div>");
	},

	getTrueHeight : function()
	{
		return (window.hasOwnProperty('innerHeight') ? window.innerHeight : $(window).height()) || 480;
	},

	toggle : function() // open/close
	{
		var libEl = $("#previewShare");
		var cad = $("#previewPage");
		
		var displayscreen = window.innerWidth;
		var currentWidth = libEl.outerWidth();
		//var prepage_width = $("#previewPage").outerWidth();
		var prepage_width = cad.outerWidth();
		
		var animateTo;
		var animateTo = (libEl.find('#tabPreview').hasClass("open")) ? -currentWidth : 0;
		var left =  cad.css("left")
		
		if(left.indexOf("%") != -1)
		{
			left = parseFloat(left)/100;
			cad.css("left",left*displayscreen);
		}
		if(animateTo ==0)
				displayscreen = displayscreen + currentWidth;
		function center()
		{
			libEl.find("#tabPreview").toggleClass("closed open");
			
			var prePage = $("#previewPage");
			var pagewith = prePage.width();
			//prePage.animate({left:((displayscreen)/2) - prepage_width/2 }, currentWidth/3);
			var lt = 0
			if(animateTo != 0 )
			{
				lt = parseFloat(left) - (currentWidth/2)
			}
			else if(animateTo == 0 )
			{
				lt = parseFloat(left) + (currentWidth/2)
			}
			prePage.animate({left:lt }, currentWidth/2);
		}	
		libEl.animate({left: animateTo} , currentWidth/2, center);
	},
	
	updateScrollbar: function()
	{
		$('#Preveiw').tinyscrollbar();
	},

	linkCheck : function(id,links)
	{
		do
		{
			var inLinkArray = $.inArray(id, links.linkOrigin);
			if(inLinkArray > -1) // have found a link for this.
			{
				return inLinkArray;
			}
			id = storage.get(id)
			if(id == null)
			{
					return -1;
			}
			id = id.of;
		}
		while(id);
	
		return -1;
	
		/*
		var i = $.inArray(id, links.linkOrigin);
		var object =  "";
		while(i == -1 )
		{	
			object = storage.get(id);
			id = object.of;
			if(id == null)
			{
				return;
			}
			i = $.inArray(id, links.linkOrigin);
		}
		return i;
		*/
	},
	
	linkShowRipple : function(id,target)
	{
		var object = storage.get(id);
		
		if(object && object.segments == null)
		{
			if(object.of == null)
			{
				return;
			}
			
			if(target != object.of)
			{
				if(preview.linkShowRipple(object.of,target))
				{
					$("#" + id).addClass("widgetLink");
				}
			}
			if(target == object.of)
			{
				return true
			}	
		}
	},

	runDraw : function(dat)
	{
		var id = dat;
        var prjObj;
		if(typeof(dat)=='string') //check if id instead of data
		{
			dat = project.bundle(dat);

            prjObj = dat[g_preview];
			//var p = storage.get(prjObj.pages[0]);//check for pages in storage
			if(!prjObj || !prjObj.pages)
			{
				ajax.syncDown(id, preview.parseDownload);
                return;
			}
		}
		preview.loaded = true;
		preview.navigationStackBack = new Array();
		preview.navigationStackForward = new Array();
		preview.navigationQueueNext = new Array();
		preview.navigationQueueFlow = new Array();
		preview.navigationCompleted = false;
        preview.navigationDefaultTransition = prjObj ? prjObj.defaultTransition : "none";
		preview.draw(dat);
	},

	restart : function()
	{
		var previewPanel = document.getElementById('previewPage').contentWindow;
		if (previewPanel.g_preview)
		{
			preview.hideMenu();
			previewPanel.preview.load(previewPanel.g_preview);
		}
		else
		{
			preview.open();
		}
	},
/*    2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
	//Locate the preview options on the left top corner of the iFrame
	locateMenu : function(e, data)
	{*/
		/*
		if (window.g_print || window.g_embedded || window.g_imgExport == "true") { return; }

		var menu = preview._selectMenu();
		if (menu.size() == 0)
		{
			return;
		}

		var area = menu.parent().find("#previewPage");
		if (area.size() > 0)
		{
			function relocateMenu()
			{
				var newLeft = parseInt(area.css("left"));
				var newTop = parseInt(area.css("top")) - 40;
				menu.animate({
					"left" : newLeft + "px",
					"top": newTop + "px"
				}, 400, 'swing');
			}

			setTimeout(relocateMenu, 600);
		}*/
/*	},*/

	hideMenu : function()
	{
		/*
		var menu = preview._selectMenu();
		if (menu.size() == 0)
		{
			return;
		}

		menu.hide();
		*/
	},
    /*  2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
	displayMenu : function(delay)
	{*/
		/*
		var menu = preview._selectMenu();
		if (menu.size() == 0)
		{
			return;
		}

		if (!menu.is(":visible"))
		{
			if (delay != undefined)
			{
				setTimeout(function(){ menu.fadeIn(300); }, delay);
			}
			else
			{
				menu.fadeIn(300);
			}
		}*/
/*	},*/

	//Initializes navigation
	navigateInit : function(e, ui)
	{
		preview.navigationEnabled = true;
	},

	navigateSetCompleted : function()
	{
		preview.navigationQueueNext = new Array();
		preview.navigationStackForward = new Array();
		preview.navigationCompleted = true;
	},

	navigateSetIncompleted : function()
	{
		preview.navigationCompleted = false;
	},

	navigateWithKeys : function(e)
	{
		//Manage ESC for the Iframe when required
		if ((e.keyCode == 27) && (self != top) && (window.parent.lib != undefined))
		{
			window.parent.lib.esc();
		}

		var direction = utils.getNavigationKeyDirection(e.keyCode);

		if (direction == "") { return; }
		var context = top == self ? document.getElementById('previewPage').contentWindow.preview : window.preview;

		if ((!context) || (!context.navigationEnabled)) { return; }

		if ((direction == "top") || (direction == "right"))
		{
			context.navigateNext();
			return;
		}

		context.navigateBack();
	},

	navigateNext : function()
	{
		//If the user navigated back, use that page to move forward
		if (preview.navigationStackForward.length > 0) {
			var next = preview.navigationStackForward.pop();
            //console.log("Next from FWD: ", next);
			preview.changePage("#" + next.pageId, next.args);
			return;
		}

		//Follow one of the links from the page or an unlinked page
		if (preview.navigationQueueNext.length > 0) {
			var next = preview.navigationQueueNext.shift();
            //console.log("Next from NEXT: ", next);
			preview.changePage("#" + next.pageId, next.args);
			return;
		}

		//When all pages have been visited, restart the flow
		if (preview.navigationQueueFlow.length > 0) {
			var next = preview.navigationQueueFlow.shift();
            //console.log("Next from Looop: ", next);
			preview.changePage("#" + next.pageId, next.args);
			return;
		}
	},

	//Navigates to the last visited page
	navigateBack : function()
	{
		if (preview.navigationStackBack.length > 1) {
			//Add current page to the navigate forward Stack
			var current = preview.navigationStackBack.pop();

			var previous = preview.navigationStackBack.pop();

			var isBlankPrevious = $("#" + previous.pageId).hasClass("blank");
			if (isBlankPrevious)
			{
				if (preview.navigationStackBack.length > 0)
				{
					previous = preview.navigationStackBack.pop();
				}
				else
				{
					return;
				}
			}

			if (preview.navigationCompleted) {
				var prev = preview.navigationQueueFlow.pop();
				preview.navigationQueueFlow.splice(0, 0, prev);
				var back = preview.navigationQueueFlow.pop();
				if (back.pageId != previous.pageId)
				{
					preview.navigationQueueFlow.push(back);
				}
			}
			else
			{
				preview.navigationStackForward = $.grep(preview.navigationStackForward, function(n, i){
					return n.pageId != current.pageId;
				});
				var isBlankCurrent = $("#" + current.pageId).hasClass("blank");
				if (!isBlankCurrent)
				{
                    var fwd = { pageId: current.pageId, args: previous.args };
					preview.navigationStackForward.push(fwd);
				}
			}

			//Navigate to previous page
			preview.changePage("#" + previous.pageId, previous.args, 1);
			return;
		}

		//This only happens when the project contains one page with widgets
		//And the user navigated to a blank page following a link
		if ((preview.navigationCompleted) && (preview.navigationQueueFlow.length > 0))
		{
			var prev = preview.navigationQueueFlow.pop();
			preview.changePage("#" + prev.pageId, prev.args, 1);
		}
	},
/*  2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
	_selectMenu : function()
	{
		var previewMenu = $("#previewMenu");
		if (previewMenu.size() == 0)
		{
			previewMenu = $("#previewMenu", window.parent.document);
		}
		return previewMenu;
	},*/

	_crossDomainCall : function(target, funcName, args)
	{
		target.postMessage(JSON.stringify({funcName: funcName, args: args}), '*');
	},

	_crossDomainCallListener : function(event)
	{
		// TODO: do we need to check event.originalEvent.origin here for security?

		var data = JSON.parse(event.originalEvent.data);
		if ($.isFunction(preview[data.funcName]))
		{
			preview[data.funcName].apply(preview, data.args);
		}
	}
};

	


var page = 
{
	frame : null,   // the #pageFrame element
	frameVisible : false,
	menu : null,    // the #pageMenus element
    displayingMenu : false,

	// moves a page zindex above all others.
    //BD this was replaced with css solution. See .screen.active and .screen.dragging-wdg-from styles
	/*moveToFront : function(pageId)
	{
		$(".screen").css("z-index", 1);
		$("#" + pageId).css("z-index", 2);   // make sure this page is on top for between pages.
	},*/

	// swaps the screen w/h for a page.
	orient : function()
	{
		var pageObj = $(".screen.active"); // the screen.
		var pageId = pageObj.attr("id");
		var orientation = $(this).val();

		page.update({orientation: orientation}, pageId); //done in page.resizeAfterOrient

		pageObj.each(page.resizeAfterOrient);
		page.updateOptionsMenu();
		hint.show("library");
		grid.showGrid();
	},

	// resizes a page based on an orient event.
	// if the page is landscape, we need to alternate the w/h for calculation
	resizeAfterOrient : function() // $(this) is page jqObject 
	{
		var $this = $(this);
		var pid = $this.attr("id");

		//DA:01-Mar-2012: Calculate new dimensions based on the current and the minimum dimensions (project and widgets)
		var toApplyWH = [ page.get(pid, "height"), page.get(pid, "width") ];

		$this.css({"width": toApplyWH[0], "height": toApplyWH[1]}); // screenWH is already updated.
		$this.find(".page").css({"width": toApplyWH[0], "height": toApplyWH[1]}); // screenWH is already updated.
		$this.find(".page").children(".widgetHolder").css({"width": toApplyWH[0], "height": toApplyWH[1]}); 
		page.update({width: toApplyWH[0], height: toApplyWH[1]}, pid);

		//Replaced aitoWidth with drawDetails due to the previewPage rendering
		//page.autoWidth($this);
		if( project.get('currentZoom') === 1 && $this.hasClass('active') ) {
		    if($('#'+pid).hasClass('active')) {
			page.drawDetailed(pid, "init");
		    }
		} else {
		    page.draw(pid, "init");
		}
		link.update($this);

	},

	updateOptionsMenu : function()
	{
		var activePage = $(".active").attr("id");
		if(typeof activePage === "undefined"){ return; }

		var pageWH = project.get("pageWH");
		var homepage = project.get("homepage");
		var orientation = page.get(activePage, "orientation");
		var orientation2 = project.get("orientation");
		var $pageMenu = $("#pageMenu");
		var textHome = homepage == activePage ? "This is the start page" : "Make this the start page";
		var titleHome = homepage == activePage ? "Start page - Home" : "";
		var status = homepage == activePage ? "homePageOn" : "homePageOff";
		var title = page.get(activePage, "name");
		title = title == undefined ? "" : title;

		$(".homePageStatusText").text(textHome);
		$(".iconPageSettingsIndicator").not(".gridOff, .gridOn, .snapToWidgetsOff, .snapToWidgetsOn").removeClass("homePageOn homePageOff").
		    addClass(status).attr("alt", titleHome).attr("title", titleHome);
		//$pageMenu.find(".makeHomepage td").children().hide();
		$pageMenu.find(".pageSize.rangeWidget.width>input").val(page.get(activePage, "width"));
		$pageMenu.find(".pageSize.rangeWidget.height>input").val(page.get(activePage, "height"));
		$pageMenu.find(".orientationSelector2").find("[value='" + orientation2 + "']").attr("selected", "selected");	
		//$pageMenu.find(".orientationSelector").find("[value='" + orientation + "']").attr("selected", "selected");
		var switchContainer = $pageMenu.find(".buttonSwitchContainer");
		switchContainer.children().removeClass("activeOption");
		switchContainer.find("[data-for='" + orientation + "']").addClass("activeOption");
		$(".inputPageTitle").val(title);

		//DA: 13-Mar-2012: Get right device size
		var device = project.get("deviceModel");
		var listDevices = $('#DeviceSizeTmpl');
		if (device) {
			$("option[data-type='" + device + "']", listDevices).attr("selected", "selected");
		} else {
			//When the project doesn't contain the device selection, get the closest from the list
			var projectWH = project.get("pageWH");
			var foundDevice = false;
			$.each(listDevices.children(), function(index, item) {
				if ($(item).val() != "Custom") {
					var size = $(item).val().split(',');
					if (((projectWH[0] == size[0]) && (projectWH[1] == size[1])) ||
						((projectWH[0] == size[1]) && (projectWH[1] == size[0]))) {
						$(item).attr("selected", "selected");
						foundDevice = true;
						return false;
					}
				}
			});
			if (!foundDevice) {
				$("option[data-type='Custom']", listDevices).attr("selected", "selected");
			}
		}
		//Show/Hide the Screen Size input elements
		if ($("option:selected", listDevices).val() == "Custom") {
		    $(".screenSize").parents("tr").children().show();
		} else {
		    $(".screenSize").parents("tr").children().hide();
		}
		updateTLWH();

        var title = page.get(activePage, "name");
        //page.displayPageTitle(title == undefined ? "" : title);

		grid.selectBackground();
	},

	addViaLinkDrop : function (offset, height, e, ui)
	{
		var id = page.add(e);
		if(!id) return;

		var zoom = project.get("currentZoom");
		var rand = Math.floor(Math.random()*1000);
		var dX = Math.floor(parseInt($("#" + id).css("left")) - 400 - (rand*3)); // / 0.25;
		var dY = (parseInt($("#" + id).css("top")))-500+rand;
		var animTime = 100 + rand/3;

		$("#" + id).hide().fadeIn(animTime).css({left:dX, top:dY});

		var type = "ahref";
		//var orig = $(".ui-selected").attr("id"); // TODO: only handles 1, can be restructured quick with an else!!!
		var orig = $(".zoomedOutSelected").attr("id"); // TODO: only handles 1, can be restructured quick with an else!!!
		/*if($(ui.draggable).hasClass("templateLink"))
		{
			type = "template";
			orig = $(ui.draggable).parents(".page").attr("id");
		}*/

		var canvas = link.add(orig, id, type);

		pagesCache[id].box[0] = dX;
		pagesCache[id].box[1] = dY;

		link.draw(canvas, orig, id, type);
		//link.draw(canvas, "#" + orig, "#" + id, type);
		page.update({x : dX, y: dY}, id);

		$(canvas).fadeIn(600); //.delay(1800).fadeOut(400); //.delay(2600).fadeOut(300);

		tracker.record("addPage", 1, id, e);
		tracker.record("addLink", 1, "", e);
		return id;
	},

	//screen click - also .triggered() from mouse wheel scroll - test this too. 
	click : function(e)
	{
		group.deselect();

		if (!$('#canvas').data('zooming'))
		{
			if ($(e.target).closest(".screen").attr("id") == $(".active").closest(".screen").attr("id")) return; // ignore the current page.
			//prevent centering the page when user clicked the page scrollbar
			var origClickTarget = e.originalEvent && $(e.originalEvent.target);
			if (origClickTarget && (origClickTarget.hasClass('track') || origClickTarget.hasClass('thumb'))) return; // canvas click dragging

            var screen = $(this).closest(".screen");
            var pid = screen.attr("id");

            //page.drawDetailed(pid, 'init');

			page.activate(this);

			var zoom = project.get("currentZoom");

			if (zoom == 1)
			{
				zoomInAndCenterOnPage(screen, 1, 1, 400);
			}
			else
			{
				canvas2.zoom({newZoom:1, page: screen});
			}

            //Hide the trash when the page zoomed in has no widgets
            /* VK 2013-02-18: do not hide to be able to remove uploads
            var pid = screen.attr("id");
            var widgets = page.get(pid, "widgets");
            if (widgets.length > 0)
            {
                $("#trash").fadeIn(300);
            }
            else
            {
                $("#trash").fadeOut(300);
            }
            */

            $("#trash").fadeIn(300);
		}
	},

	makeHome : function(e, pageObj) // takes an event or a page object and makes it the home.
	{
		if(typeof pageObj === 'undefined')
		{
			pageObj = $(this).closest(".screen"); // called from user update action.
		}

		if($(pageObj).hasClass("template")) // Can't make a template the homepage
		{
			return;
		}		

		var homeId = $(pageObj).attr("id");
		project.set({homepage : homeId});
		page.updateOptionsMenu();
        $(".screen").removeClass("homePage");
        $(pageObj).addClass("homePage");
	},

    removeHome : function(newHome)
    {
        project.set({homepage : newHome || null});
		if(newHome) {
			$('#'+newHome+'.screen').addClass('homePage');
		}
        page.updateOptionsMenu();
    },

	add : function(e)
	{
		if (project.readOnly())
		{
			notification.add("alert", "Switch to an active project before adding pages.");
			e.preventDefault();
			e.stopImmediatePropagation();
			return false;
		}

		if(	!/canvas|hint|viewport/.test($(e.target).attr("id")) )		// its bubbled from somewhere else. 
			return;

		if(project.get("currentZoom") == 1) return; 					// only create pages when zoomed out.

		var lastClick = $("#cmLink").data("lastClicked") || 0;			// this might be superceded by the above.
		if( (new Date()).getTime() < lastClick + 600 ) return; 			// ignore double clicks on context menu.

		if (!e.offsetX) // FF
		{
			var elOfs = $('#canvas').offset();
			e.offsetX = e.pageX - elOfs.left;
			e.offsetY = e.pageY - elOfs.top;
		}

		// Create a page.
		var offset = {top: e.offsetY, left: e.offsetX};
		if(e.target.id !== "canvas")
		{
            offset.left = e.originalEvent.pageX + $("#viewport").get(0).scrollLeft; // + e.originalEvent.layerX;
            offset.top = e.originalEvent.pageY + $("#viewport").get(0).scrollTop; // + e.originalEvent.layerY;
		}

        //fallback position of the page (middle of the screen) in case something went wrong
        if(!(offset.top >=0 && offset.left >= 0) ) {
            var $canvas = $('#canvas');
            var $viewPort = $('#viewport');

            var offset = {
                top: (Math.abs(parseInt($canvas.css('top'), 10)) + Math.round($viewPort.height()/2)),
                left: (Math.abs(parseInt($canvas.css('left'), 10)) + Math.round($viewPort.width()/2))
            };
        }

		//make sure the page is not created outside the canvas
		//var coords = page.correctPageCoords(offset.left, offset.top);

        var newPageId = page.create(offset.top, offset.left);

		if( project.get('pages').length === 1 ) {
			fluidMenu.setCanvasFirstPage();
		}

        tracker.record("addPage", 1, newPageId, e);

        return newPageId;
	},

	correctPageCoords: function(left, top) {
		var currZoom = project.get('currentZoom');
		var canvWidth = project.get('canvasWidth') * currZoom;
		var canvHeight = project.get('canvasHeight') * currZoom;
		var pageWH = project.get('pageWH');

		if(top + pageWH[1] * currZoom > canvHeight) {
			top = canvHeight - pageWH[1] * currZoom;
		}

		if(left + pageWH[0] * currZoom > canvWidth) {
			left = canvWidth - pageWH[0] * currZoom;
		}

		return {
			left: ~~left/currZoom,
			top: ~~top/currZoom
		};
	},

	// new page variable. 
	create : function(pageY, pageX, mode)
	{
		//make sure the page is not created outside the canvas
		var coords = page.correctPageCoords(pageX, pageY);

		if(!fluid.main.fire('page.beforeAdd')) return;

		var pageWH = project.get("pageWH");
		var orientation = project.get("orientation");

		var dataObj = { //name: pageName,
					   x: coords.left,
					   y: coords.top,
					   width: pageWH[0],
					   height: pageWH[1],
					   orientation: orientation, 
					   widgets: []}; //, top: pageY, left: pageX, widgets is an ID/object pair.

        var id = utils.guid("x"); // get a random id
        project.addPage(id); // add the page to the project list.

        if(!pagesCache[id]) pagesCache[id] = {};
        pagesCache[id].box = [dataObj.x, dataObj.y, dataObj.width, dataObj.height];

		storage.set(id, dataObj);
		page.template(dataObj, id, mode); // create the page.

		// After its created, if there is only one page, make it the homepage.
		/*var homepage = project.get("homepage");
		if( $("#" + homepage).length == 0) // || $(".screen").not(".template").length == 1
		{
			page.makeHome(null, $("#" + id)); 
		}	*/

        //BD not needed since all pages have equal z-index and new page is placed as a last element in container
		//page.moveToFront(id);
		return id;
	},

	hideOptionsMenu : function(e)
	{
		page.hideNotes();
        page.pageMenuClick();
		$("#pageMenus").children().addClass('hide');
	},

	toggleOptionsMenu : function(e)
	{
		var pageMenu = document.getElementById('pageMenu'),
			visible = !pageMenu.classList.contains('hide');

        page.pageMenuClick();
		page.updateOptionsMenu(); // set all the correct values for the selected page.
		page.toggleMenus();

		if (!visible)
		{
            pageMenu.classList.remove('hide');
		}
	},	

	/*manualResize : function(e)
	{
		var active = $(".active").attr("id");	
		var wh = [parseInt($(".pageSize").filter(".width").val()), parseInt($(".pageSize").filter(".height").val())];
		var screenWH = project.get("pageWH");

//		var orientation = page.get(active, "orientation");
//		var projectOrientation = project.get("orientation");
//		if(orientation != projectOrientation) // orientation is the *new* orientation - we want to change if its from the old!
//		{
//			//console.log("Changed orientation!");
//			wh = [wh[1], wh[0]]; //swap them for this screen size - project stores landscape only.
//		}

		//console.log("Manual Resizing:", active, wh[0], wh[1] + "", e);

		if (screenWH[0] != wh[0] || screenWH[1] != wh[1])
		{
			page.resize(active, wh[0], wh[1]);
		}
	/* YURI 
	//console.log("Manual Resizing:", active, wh[0], wh[1]); //change the grid size
		var pageWh = wh;
		grid.changePageDimsManually(false,pageWh);
	*/

	toggleSnapSettings : function () {
		var snapMenu = document.getElementById('snapSettingsPanel');
			visible = !snapMenu.classList.contains('hide');

		if (visible) {
			page.hideOptionsMenu();
			return;
		}
		page.showDefaultSnapOptions();
	},

	showDefaultSnapOptions : function()
	{
		page.toggleMenus();

		document.getElementById('snapSettingsPanel').classList.remove('hide');

		var grid = account.get("gridStatus");
		var snapWidgets = account.get("snapToWidget");
		(grid == 'on') ? $("#gridSwitchOn").show() : $("#gridSwitchOff").show();
		(snapWidgets == 'on') ? $("#snapSwitchOn").show() : $("#snapSwitchOff").show();
	},	//todo: handle orientation
	resize : function(active, width, height)
	{

		var screenWH = project.get("pageWH");

		var projectOrientation = project.get("orientation");	
		var pageOrientation = page.get(active, "orientation");
		if(pageOrientation != projectOrientation) { // orientation is the *new* orientation - we want to change if its from the old!
			screenWH = [screenWH[1], screenWH[0]]; //swap them for this screen size - project stores landscape only.
		}

		if ((width < screenWH[0]) || (isNaN(width))) {

			width = screenWH[0];
			 //.css({outline : "2px solid red"});
		} else if(width > screenWH[0]) {
			$(".pageSize").filter(".width").val(width);
		}

		if ((height < screenWH[1])  || (isNaN(height))) {

			height = screenWH[1];
		//	$(".pageSize").filter(".height").val(screenWH[1]); //.css({outline : "2px solid red"});
		} else if(height < screenWH[1]) {
			$(".pageSize").filter(".height").val(height); //.css({outline : "2px solid red"});
		}

		var activePage = $("#" + active + " .page");
		// var orientation = height >= width ? "Portrait" : "Landscape";
		page.update({width: width, height: height/*, orientation: orientation*/}, active);
		hint.show("library");

		activePage.parent(".screen").css({width: width, height: height});
		activePage.css({width: width, height: height}); //  + " ul"	
		activePage.children(".widgetHolder").css({width: width, height: height});
		// resize the background widget if any.
		var background = $("#" + active + " .backgroundWidget");	 //  ul 
		var tlwh = {top:0, left:0, width:width, height:height};

		/*var pageWidget =  activePage.children(".widgetHolder").children(".pageWidget");
		var pageData = {wh:[width,height],length:1};
		var pageid = activePage.attr("id");
		$(pageWidget).each(function()
		{
			var obj = $(this);
			var id = $(obj).attr("id");
			var wh = obj.wh;

			var seg = storage.get(id);
			if(seg.id == seg.id)
			{

			}
			if(typeof(seg.tlwh[2]) =='string' || typeof(seg.tlwh[3]) =='string')
			{
				widget._resize( obj,active);
			}
			if (wh && seg)
			{
				widget.subWidgetUpdate(seg,[wh.width,wh.height]);
			}

		});
		*/
		page.autoWidth(activePage.parent(".screen"));
        grid.showGrid();

		//link.update($("#" + active));
		return false;
	},

	get : function (pid, data)
	{
		if(typeof pid != "string" )
			return "";

		var j = storage.get(pid);

		if(typeof j === "undefined" || !j)
		{

			return ""; 
		}
		return j[data];
	},

	// the page is moving, update any links into/out of it.
	updateDragPos : function(pageObj)
	{
		var $this = $(pageObj);
		var zoom = project.get("currentZoom");
		var pos = $this.position();

        if (!$this.data().draggable)
        {
            return;
        }

		var top = Math.round($this.data().draggable.position.top / zoom);
		var left = Math.round($this.data().draggable.position.left / zoom);

		$this.css({
			top : top + 'px',
			left : left + 'px'
		});

		$this.data().draggable.position.top = top;
		$this.data().draggable.position.left = left;

        pagesCache[$(pageObj).attr('id')].box[0] = left;
        pagesCache[$(pageObj).attr('id')].box[1] = top;

		//options._updateLinks($this);
		link.update($this);

		if(intersectTrash($this) == true)
		{
			$('#trash').addClass('droppableStyle');
		}
		else
		{
			$('#trash').removeClass('droppableStyle');  
		}	
	},

	// Todo: a better way is to split the link.update into get and action functions and call the start one separately...less draw! 
	dragStart : function(e)
	{
        //If the project is read only or trying to drag the page while zooming in, abort
		if ((project.readOnly()) || ( $("#canvas").data('zooming')))
		{
			return false;
		}

		var zoom = project.get("currentZoom");
		if(zoom == 1)
		{
			$("#canvasLinks").hide(); // functionise - happens in canvas drag too.
		}
	},

	drag : function()
	{
		page.updateDragPos(this);
	},

    dragStop : function(e)
    {
        var pos = $(this).position();
        var pageObj = storage.get($(this).attr('id'));
        var projectObj = storage.get(project.get('id'));
        var maxX = projectObj.canvasWidth - pageObj.width;
        var maxY = projectObj.canvasHeight - pageObj.height;
        var zoom = project.get("currentZoom");
        var newX = Math.min( Math.max( Math.round(pos.left / zoom), 0 ), maxX);
        var newY = Math.min( Math.max( Math.round(pos.top / zoom), 0 ), maxY);
        var $page = $(this);

        fluid.command.create('move', { id: $(this).attr('id'), x: newX, y: newY }).dispatchTo('fluid.controllers.page');

        $page.appendTo($page.parent('#canvasPages'));
        link.showahrefs(); // hide any template links that showed during the drag.
        $("#canvasLinks").fadeIn(200);
    },

	selectStart : function(e)
	{
		if (project.readOnly())
		{
			e.preventDefault();
			e.stopPropagation();
			return false;
		}
	},

	selectStop : function(e)
	{

		var selected = widget.getRoots("#canvasPages .ui-selected");
		widget.resetSelection();
		widget.selectMulti = true;
		selected.each(function()
		{
			var id = $(this).attr("data-lockto");
			widget.select("pass", $("#"+id));	
		});
		widget.selectMulti = false;
		contextMenu.place();
	},

	updatePageName : function()
	{
		var name = $(this).val();
		var id = $(this).parents(".screen").attr("id");
		page.update({ name : name }, id);
	},

	template : function(dataObj, id, mode)	
	{	
		var obj = $.extend(true, {}, dataObj);
		obj.id = id;
        var width = page.get(id, "width");
        var height = page.get(id, "height");
        obj.screenWH = [ width, height ];

        var template = $("#tmplPage").tmpl(obj).appendTo("#canvasPages");
		if( obj.id === project.get('homepage') ) {
			template.addClass('homePage');
		}
		//page.makeResizable(template);

		if (mode != "init" && mode != "actionHistory" && mode != 'useCache')
		{
			template.bounce();
		}	
	},

	updatePagePreviewButton : function () {
		var $button = $('#pagePreview'),
			pageId = $('.canvasObject.active').attr('id');

		if (pageId && storage.get(pageId).widgets.length) {
			$button.animate({
				opacity: 1
			}, 300);

			$button.css('pointer-events', '');
		}
		else {
			$button.animate({
				opacity: 0
			}, 300);

			$button.css('pointer-events', 'none');
		}
	},

	updateNotesIcon : function () {
		var pageElement = document.querySelector('.canvasObject.active'),
			noteElement = document.getElementById('pageAddNote');

		if (!pageElement || !noteElement) { return; }

		var notes = storage.get(pageElement.id).notes;

        if (notes && notes[3]) {
        	noteElement.classList.add('written');
        }
        else {
        	noteElement.classList.remove('written');
        }
	},

	hideNotes : function () {
		var pageNote = document.getElementById('pageNote');

		if (!pageNote) { return; }

		// dont write if its not open
		if(!pageNote.classList.contains('hide')) {
			page.saveNotesInput();
		}

		pageNote.classList.add('hide');
	},

	showNotes : function () {
		// Hide all menu items including this one
		page.hideOptionsMenu();

		var pageNote = document.getElementById('pageNote');

		if (!pageNote) { return; }

		page.setNotesTextboxValue();

		pageNote.classList.remove('hide');
	},

	saveNotesInput : function () {
		var active = $(".canvasObject.active").attr("id"),
			textarea = $("#pageNote textarea");

		page.update({
			notes: [
				textarea.width(),
				textarea.height(),
				'',
				textarea.val()
			]
		}, active);

		page.updateNotesIcon();
	},

	setNotesTextboxValue : function () {
		var pageNote = document.getElementById('pageNote'),
			pageId = document.querySelector('.canvasObject.active').id,
			notes = page.get(pageId, "notes") || [200, 120, "", ""];

		$('textarea', pageNote)
			.css({
				width: notes[0],
				height: notes[1]
			})
			.val(notes[3]);
	},

	toggleNotes : function() {
		var pageNote = document.getElementById('pageNote');

		if(pageNote.classList.contains('hide')) {
			page.showNotes();
		}
		else {
			page.hideNotes();
		}

	},

	toggleMenus : function () {
		page.hideOptionsMenu();	
		$("#pageMenus").show();
	},

	activate : function(pageElem, showMenu, mode) // page - zoom in and select this.
	{
		if (typeof(pageElem) === 'string') {
			pageElem = $("#"+pageElem)[0];
		}
	    function callback () {
			//if(project.get("currentZoom") != 1)
			if(canvas2.isZoomedOut())
			{
				return;
			}

			$("#canvasPages .screen").removeClass("active").filter($(pageElem)).addClass("active");
			var newActivePage = document.querySelector('#canvasPages .active');

			$(".screen").selectable("destroy").removeData("initSelectable");
			$(".screen").draggable("destroy").removeData("initDraggable");

			if(!project.readOnly() && newActivePage) {
				page.attachFrameTo(newActivePage);
			}

			grid.zoomIn();
			page.updateOptionsMenu();
			staticWidgets.zoomInBoundary();

			var menu = showMenu == undefined ? true : showMenu;
			page.displayMenu(menu);

			//if not drawn in detail, draw
			if($(pageElem).find('.page-preview').length) page.drawDetailed($(pageElem).attr('id'), 'init');

			//if the page was activated by widget drag from other page
			//selection needs to be restored since the page was just redrawn
			if(mode === 'wdgDrag') {
				var $sel = $([]);
				for( var i=0; i<widget._dragStartSelection.length; i++) {
					$sel = $sel.add( '#'+widget._dragStartSelection[i] );
				}
				widget.select(null, $sel);
			}

			group.drawExisting();
		//set grid option
	    }

	    //hint.hide();
	    page.detachFrame();
	    if (mode != 'actionHistory') {
			setTimeout(callback, 410);
	    } else {
			callback();
	    }
	},

	detachFrame: function()
	{
		if(page.frameVisible) // a page is already active.
		{
			page.frame.parentNode.removeChild(page.frame);
			page.menu.parentNode.removeChild(page.menu);

			page.frameVisible = page.displayingMenu = false;
			page.frame.style.display = 'none';
		}
	},

	attachFrameTo : function (pageElement) {
		page.frame = page.frame || document.getElementById('pageFrame');
		page.menu = page.menu || document.getElementById('pageMenus');

		pageElement.appendChild(page.menu);

		pageElement.querySelector('.page').appendChild(page.frame);

		page.frame.style.display = 'block';
		page.frameVisible = page.displayingMenu = true;

		page.setNotesTextboxValue();

		page.updatePagePreviewButton();
	},

    //Display Page Settings menu
    displayMenu : function (show) {
        var display = show == undefined ? true : show;
        var shouldDisplay = true;

        if ((project.readOnly() || (canvas2.isZoomedOut()))) {
            shouldDisplay = false;
        }

        if (shouldDisplay) {
            page.updateNotesIcon();
            page.updatePagePreviewButton();
        }

        if (display && shouldDisplay) {
            //When displaying Menu, check the queue of hiding/show requests
            function displayMethod() {
                //The .is(":visible") doesn't work on this element
                if ((page.displayingMenu) && ($("#pageSettingsMenuContainer").css("display") == "none")) {
                    $("#pageSettingsMenuContainer").fadeIn(300);
                }
                page.displayingMenu = false;
            }
            page.displayingMenu = true;
            page.displayMenuTimer = setTimeout(displayMethod, 200);

        } else {

            if (shouldDisplay) {
                //IF only one widget selected and it's a background, then don't hide menu
                var selectedWidgets = widget.getRoots(".ui-selected");
                if ((selectedWidgets.length == 1) && ($(".ui-selected").hasClass("backgroundWidget"))) {
                    page.displayMenu();
                    return;
                }
            }

            page.displayingMenu = false;
            $("#pageSettingsMenuContainer").stop(true, true).hide();
        }
    },

	// obj is a selector of pages.
	del : function(sel)
	{
		function pageDeleteCallback(p)
		{

			$(p).remove();

            //Set hud buttons status
            var pages = project.get("pages");
            //var home = $(".pageHome");
            //var homepage = $(home).parents(".page");

            if(pages.length == 0)
            {
                fluidMenu.setCanvasNoPages(true);
                return;
            }
            //If the deleted page deletes the last widgets in the project, hide the Preview button
            if (!project.hasWidgets())
            {
                //$("#previewView, #preview").fadeOut(300);
                $("#previewView, #preview, #pagePreview").animate({
					opacity: 0
				},300);

				$("#preview, #pagePreview").css("pointer-events",'none');
            }

            if (canvas2.isZoomedOut())
            {
                hint.restart();
            }
            /*else if(homepage.length == 0)
            {
                //var realPage = $(".screen").not(".template");
                //page.makeHome(null, realPage); //what if the second page is not a template page?
                if(project.get("currentZoom") != 1) //hack - make sure pagehome doesnt stay showing after delete
                {
                    $(".pageHome").hide();
                }
            }
            */

            //If the deleted page deletes the last widgets in the project, hide the Preview button
            /*
            if (!project.hasWidgets())
            {
                $("#previewView").fadeOut(300);
                hint.show("editPage");
                return;
            }

            //If there"s only one page in the project, display hint to add page
            if ((pages.length == 1) && (canvas2.isZoomedOut()))
            {
                hint.show("createAnotherPage");
            }
            */
		}

		sel.each(function() // each page.
		{
			var pageObj = $(this);
			var pid = pageObj.attr("id");

			// get each widget on this page - use the list in the DOM or create a function for it?
			var widgets = pageObj.find("#canvasPages .widgetHolder > .pageWidget");
			widgets.each(function()
			{
				var widg = $(this);
				widget.del(widg); // this deletes all the relevant links itself and removes it from the page object.
			});

			link.remove(pageObj);
			project.deletePage(pid);
			storage.remove(pid);

            if(pid == project.get("homepage"))
            {
				var projPages = project.get('pages');
				var newHomePage = projPages && projPages.length ? projPages[0] : null;
                page.removeHome(newHomePage);
            }

			pageObj.fadeOut(450, pageDeleteCallback(pageObj));
		});		
	},

    deleteManual : function(e)
    {
        hint.hide();
        var selected = $(".screen.active");
        var pages = project.get("pages");

        if (pages.length > 1)
        {
            page.navigateWithKeys();
        }
        else
        {
            canvas2.zoomOut(e);
        }
        setTimeout(function(){ page.del(selected);}, 300);
    },

	drawRasterised: function(id, callback) {

		page.checkIntegrity(id);
		var pageObj = page.calculateWdgPositions(id);
		this.renderer.afterPageRendered = callback;
		if(!pageObj || pageObj.widgets === 0) {

			return;
		}
		this.renderer.renderPage(pageObj);

	},

	// called from project to load a given page on project load.
    draw : function(id, mode)
    {
        page.checkIntegrity(id);

        var pageObj = page.calculateWdgPositions(id);

		this.renderer.afterPageRendered = null;
		var $page = $('#'+id);
        if($page.length === 0) {
            page.template(pageObj, id, mode);
            $page = $('#'+id);

        } else {
            var toRemove = $page.find('.pageWidget');
            setTimeout(function() {
                toRemove.remove();
            }, 500);
        }

		var $wdgHolder = $page.find(".widgetHolder");

		if(mode === 'useCache' && pagesCache[id]['img']) {

			$page.find('.page-preview, .pageWidget').remove();
			var img = new Image();
			img.src = pagesCache[id]['img'];
			$wdgHolder.append(img);
			$wdgHolder.find('img').addClass('page-preview');
			return;
		}

        if(!pageObj || pageObj.widgets === 0) {
            return;
        }

		var rendition = this.renderer.renderPage(pageObj);
		group.erase(); //erase groups on zoomOUT

        $page.find('.page-preview').remove();

        //single canvas rendition
        if(rendition.length) {
            var $toAppend;
            if(rendition[0].$shapeRendition) $toAppend = rendition[0].$shapeRendition;
            else if(rendition[0].$textRendition) $toAppend = rendition[0].$textRendition;
            else if(rendition.length && rendition[0].segments) {
                $toAppend = rendition[0].segments[0].$shapeRendition;
            }

            if($toAppend){
                $toAppend.addClass('page-preview');
                $wdgHolder.append($toAppend);
            }
        }
    },

    calculateWdgPositions: function(id) {
        if(!this.renderer) {
            this.renderer = new fluid.wdgRenderer();
        }
        if( project.useLocalDb ) {
            this
        };

        var pageObj = $.extend({},storage.get(id));

        if(pageObj.widgets && pageObj.widgets.length > 0)
        {
            var pageWidgets = {};
            for(var i=0; i< pageObj.widgets.length; i++) {
                pageWidgets[pageObj.widgets[i]] = $.extend({},widget.get(pageObj.widgets[i]));
            }
        }
        //else return pageObj;

        pageObj.widgets = pageWidgets || [];
        pageObj.id = id;

        this.renderer.canvasSize = [pageObj.width, pageObj.height];
        var pageCopy = $.extend({},pageObj);
        //var rendition = this.renderer.renderPage(pageCopy);

        for(var prop in pageCopy.widgets) {
            if(pageCopy.widgets.hasOwnProperty(prop)) {
                //pageObj.widgets[prop].id = prop;
                pageCopy.widgets[prop].box = this.renderer.calculatePageBox(pageCopy, prop);

                if(!window.widgetsCache) window.widgetsCache = {};
                widgetsCache[prop] = {};
                widgetsCache[prop].box = pageCopy.widgets[prop].box;
                widgetsCache[prop].pageBox = [pageCopy.x, pageCopy.y, pageCopy.width, pageCopy.height];
                widgetsCache[prop].pageId = id;
            }
        }

        if(!window.pagesCache) window.pagesCache = {};
        if(!pagesCache[id]) pagesCache[id] = {};
        pagesCache[id].box = [pageCopy.x, pageCopy.y, pageCopy.width, pageCopy.height];

        return pageCopy;
    },

    drawDetailed: function(id, mode) {

		//console.trace();
		//console.log('drawDetailed...', id);
		//console.trace();
        /*if(!this.renderer) {
            this.renderer = new fluid.wdgRenderer();
        }
        this.renderer.useOneCanvas = false;
        this.renderer.renderingMode = 'singlepage';

        var pageObj = $.extend({},storage.get(id));
        if(!pageObj) return false;

        var $page = $('#'+id);
        if($page.length === 0) {
            page.template(pageObj, id, mode);
            page.checkIntegrity(id);
            $page = $('#'+id);
        }

        var $existing = $page.find('.pageWidget');

        if(pageObj.widgets.length > 0)
        {
            var pageWidgets = {};
            for(var i=0; i< pageObj.widgets.length; i++) {
                pageWidgets[pageObj.widgets[i]] = widget.get(pageObj.widgets[i]);
            }
        }

        pageObj.widgets = pageWidgets || [];
        pageObj.id = id;

        this.renderer.canvasSize = [pageObj.width, pageObj.height];
        var pageCopy = $.extend({},pageObj);
        var rendition = this.renderer.renderPage(pageCopy);
        //console.log('pageCopy: ', pageCopy);

        if(!window.widgetsCache) window.widgetsCache = {};
        for(var prop in pageCopy.widgets) {
            widgetsCache[prop] = {};
            widgetsCache[prop].box = pageCopy.widgets[prop].box;
            widgetsCache[prop].pageBox = [pageCopy.x, pageCopy.y, pageCopy.width, pageCopy.height];
            widgetsCache[prop].pageId = id;
        }
        if(!window.pagesCache) window.pagesCache = {};
        pagesCache[id] = {
            box: [pageCopy.x, pageCopy.y, pageCopy.width, pageCopy.height]
        };

        var $wdgHolder = $page.find(".widgetHolder");

        //console.log('RENDITION:  ', rendition);

        //one canvas per shape
        var $wrap;
        console.log('rendition: ', rendition);
        for(var i=0; i<rendition.length; i++) {
            $wrap = $('<div id="'+rendition[i].id+'" class="pageWidget ui-selectee ui-draggable" style="left: '+rendition[i].box[0]+'px; top: '+rendition[i].box[1]+'px; width: '+rendition[i].box[2]+'px; height: '+rendition[i].box[3]+'px;" data-lockto="'+rendition[i].lockTo+'"/>');
            if( rendition[i].id === rendition[i].lockTo ) $wrap.addClass('rootWidget');
            if(rendition[i].$shapeRendition) $wrap.append(rendition[i].$shapeRendition);
            if(rendition[i].$textRendition) $wrap.append(rendition[i].$textRendition);
            $wdgHolder.append($wrap);
        }

        $page.find('.page-preview').remove();
        $existing.remove();

        return true;*/

        page.calculateWdgPositions(id);

        //var j = storage.get(id);
        var j = $.extend({},storage.get(id));
        if(!j) return false;
        var $existing = $();
        var $page = $('#'+id);
        if($page.length === 0) {
            page.template(j, id, mode);
        } else {
            $existing = $page.find('.pageWidget');
        }

        //console.log('page.draw j:', j, id);
        //page.template(j, id, mode);
        //page.checkIntegrity(id); // checks each widget on page.

        // draw the widgets on the page (if the page has widgets)
        if(j.widgets.length > 0)
        {
            widget.load(id, j.widgets); // , "init"
            //console.log('detailed rendition:  ', id, j.widgets);
            updateTLWH();
        }

        //litte timeout to prevent flashing between separate contents
        var toRemove = $('#'+id).find('.page-preview');
		//console.log('toRemove: ', toRemove, toRemove.length);
        setTimeout( function() {
            toRemove.remove();
        }, 200);
		$existing.remove();
    },

	updateView: function(pageId, options) {
		var allowZoomedInUpdate = true;
		if(options && options.zoomedOutOnly) {
			allowZoomedInUpdate = false;
		}

		if( !allowZoomedInUpdate && project.get('currentZoom') === 1 && $('#'+pageId).hasClass('active') ) {
			page.drawDetailed(pageId, 'init');
		} else if(project.get('currentZoom') !== 1) {
			page.draw(pageId, 'init');
		}
	},

	// takes a page and stored the move.
	move : function (id, x, y)
	{
		page.update({x: x, y: y}, id);

        pagesCache[id].box[0] = x;
        pagesCache[id].box[1] = y;

		var $page = $('#' + id);
		var pos = $page.position();
		if (pos.left != x || pos.top != y)
		{
			$page.css({left: x + 'px', top: y + 'px'});
			link.update($page);
		}
	},

	//set :
	update : function (obj, id) //field, setting object, id of page.
	{
		//console.log("Updating", id, obj); console.trace();
		var j = storage.get(id);
		if(!j)
		{
			//console.log("Page has been deleted...");
			return;
		}

		for (var o in obj)
		{
			j[o] = obj[o];
		}

		storage.set(id, j);		
	},

	//saves the z order of the widgets for a page based on their current order in the DOM in the page.
	orderWidgets : function (obj) // TODO: this takes a .widgetholder - could be improved to save a trawl?
	{
		var pageId = $(obj).parents("li.canvasObject").attr("id");
		var widgets = $(obj).find(".pageWidget");

		var order = [];
		widgets.each(function(){
			order.push($(this).attr("id"));
		});
		//console.log("reordering", order, pageId);
		page.update({widgets: order}, pageId);
	}, 

	addWidget : function(pid, wid, wdgObj) // make this generic?
	{
		//console.log("addwidget:", wid, pid);
		var j = storage.get(pid);

		if( wdgObj && wdgObj.st && wdgObj.st === 'b' ) {
			j.widgets.unshift(wid);
		} else {
			j.widgets.push(wid);
		}
		storage.set(pid, j);	
	},

	removeWidget : function(pid, wid)
	{
		var j = storage.get(pid);
		if(!j) return; // A subwidget where the parent has already gotten it - todo: handle better, eliminate case. 
		var index = $.inArray(wid,j.widgets);
		j.widgets.splice(index,1);
		storage.set(pid, j);
	},

	// handles only one 
	//called from widget.
	/*
	deleteWidget : function(id, pid) // removes a widget from the page variable. 
	{
		if(!pid) // if the page id isnt passed, get it from the html.
		{
			pid = $("#" + id).parents(".screen").attr("id"); // TODO: handle a not for the templated possibilities?
		}

		var j = storage.get(pid);
		if(!j) return; // must be a subwidget, in which case the parent will get it.

		var p = null;
		for(var i=0; i<j.widgets.length; i++)
		{
			if(j.widgets[i] == id)
			{
				p = i;
				break;
			}
		}
		j.widgets.splice(p, 1);		
		storage.set(pid, j);
	},
	*/

	enableSelectableWidgetHolder : function(enable)
	{
		if ($(".selectArea").data('selectable'))
		{
			var cancel = $(".selectArea").selectable('option', 'cancel').split(/\s*,\s*/);
			var widgetHolderPos = cancel.indexOf('.widgetHolder');

			if (enable || enable === undefined)
			{
				if (widgetHolderPos > -1)
				{
					cancel.splice(widgetHolderPos, 1);
					$(".selectArea").selectable('option', 'cancel', cancel.join(','));
				}
			}
			else
			{
				if (widgetHolderPos == -1)
				{
					cancel.push('.widgetHolder');
					$(".selectArea").selectable('option', 'cancel', cancel.join(','));
				}
			}
		}
	},

	//helper function checking if there is a link between two pages, Returns first link id or false
	isLinked: function(originPage, destPage)
	{
		var objLinks = project.get("links");
		var arrPages = project.get("pages");
		var arrWidgetsFromOrigin = page.get(originPage, 'widgets');
		var linkIdx;

		for(var i=0; i<arrWidgetsFromOrigin.length; i++){
			linkIdx = objLinks.linkOrigin.indexOf( arrWidgetsFromOrigin[i] );

			if( linkIdx != -1 ){
				if( objLinks.linkDest[linkIdx] == destPage) return objLinks.linkCanvId[linkIdx];
			}
		}

		return false;
	},

	//DA: 08-Mar-2012: Check integrity for all widgets in the page
	checkIntegrity: function(pid)
	{
		if (pid)
		{
			var widgets = page.get(pid, "widgets");
			if (widgets)
			{
				var objData = storage.get(pid);
				$.each(widgets, function(index, item)
				{
					if(!widget.checkIntegrity(item, objData)) return false; // widget integrity fail.
				});
			}
		}
	},

	autoWidth : function(page)//apply auto width to widgets on page
	{
		var onpage = $(page).children(".page");
		var pageId = $(page).attr("id");
		var holder = onpage.children(".widgetHolder");
		var children =  holder.children(".rootWidget");
		for(var j =0;j < children.length;j++)
		{
			var ele = $(children[j]);
			var id = ele.attr("id");
			var objData = storage.get(id);

		   // var save = [objData.wh[0],objData.wh[1]];

			if((typeof(objData.tlwh[0])  === "string") || (typeof(objData.tlwh[1])  === "string") ||
				(typeof(objData.tlwh[2])  === "string") || (typeof(objData.tlwh[3])  === "string"))
			{
				var objVars = widget._setTMPLVars(id, objData, [0, 0, onpage.width(), onpage.height()]);
				ele.css({ top: objVars.absTLWH[0], left: objVars.absTLWH[1], width: objVars.absTLWH[2], height: objVars.absTLWH[3] });
				widget._resize(ele, pageId, objVars.tlwh);
			}

			//var id = $(children[j]).attr("id");
			/*
			var wid = $("#" + id);
			wid.css({width:wh[0],height:wh[1]});
			wid.children("img").css({width:wh[0],height:wh[1]});
			wid.children(".widgetText").css({width:wh[0],height:wh[1]});
			widget.subWidgetUpdate(objData,wh);
			widget.set(save,id);
			*?
			/*var id = $(children[j]).attr("id");
			var widData = storage.get(id);
			widget.subWidgetUpdate(widData,[cssObj.width,cssObj.height]);*/
		}
		link.update($(page));
	},
/*  2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
	autoWidthWidgets:function()
	{
		// return true;
	   // var pages = $("#canvasPages").children();
		// var pages = $(".screen");
		// for(i =0;i < pages.length;i++)
		// {
			// page.autoWidth(pages[i]);
		// }
	},*/

	//DA: 02-Apr-2012: Duplicates the currently selected or specified page
	duplicate : function(e)
	{
		//Calculate new position and dimensions
		var $pageObj = $(".screen.active");
		var $page = $(".page", $pageObj);
		var pageID = $pageObj.attr("id");
		var pageOrientation = page.get(pageID, "orientation");
		var newPositionTL = { top : parseFloat($pageObj.css("top")), left: parseFloat($pageObj.css("left")) + parseFloat($page.css("width")) + 100};       //New page position
		var newDimensions = { width: parseFloat($page.css("width")), height : parseFloat($page.css("height"))};         //New page dimensions
		var title = page.get(pageID, "name");
		var titleNew = title == undefined || title == "" ? "" : title + " - Copy";

		//Create new Page and fix details
		var newPageID = page.create(newPositionTL.top, newPositionTL.left, "init");
		if (newPageID)
		{
			var $newPage = $("#" + newPageID);
			page.update({orientation : pageOrientation }, newPageID);
			page.update({name : titleNew }, newPageID);
			page.resize(newPageID, newDimensions.width, newDimensions.height);

			//Copy all the widgets in the page
			var tempCopies = $.extend(true, {}, widget._copies);

			widget.resetSelection();
			var widgets = $('#canvasPages .active .pageWidget'); //all widgets on page.
			widget._copy(e, widgets);

			//$pageObj.selectable("destroy").removeData("initSelectable");
			$(".screen").removeClass("active").filter($newPage).addClass("active"); // activate does this on a timeout!
			zoomInAndCenterOnPage($newPage, 1, 1, 200);
			page.activate($newPage);

			if (widget._copies["oldId"].length > 0)
			{
				widget._paste(e);
			}

			widget._copies = $.extend(true, [], tempCopies);
			tempCopies = null;
			widget.resetSelection();
			setZoomedInActions();
			//hint.show("library");
		}
		tracker.record("addPageClone", 2, newPageID, e);
		return newPageID;
	},

	//Creates a new page
	createNew : function(e, mode)
	{

	    var $canvas = $('#canvas');
	    var zoom = project.get("currentZoom");

	    if(!zoom) {
		zoom = $canvas.hasClass('canvas100') ? 1 : 0.25;
	    }

	    var projPages = project.get('pages');
	    var isZoomedIn = (zoom === 1);
	    var newPosTL;
	    mode = mode || "init";
	    //Calculate New Position
	    if (isZoomedIn)
	    {
		var pageId = $(".screen.active").attr('id');
		//if there is no active page in the dom, the last page in the project will be used
		if(!pageId) {
		    if( projPages.length ) {
			pageId = projPages[projPages.length-1];
		    }
		}

		if(pageId) {
		    var pageObj = storage.get(pageId);
		    newPosTL = {
			top: pageObj.y,
			left: pageObj.x + pageObj.width + 100
		    };

		    //fallback position for new page in case active pageId could not be obtained
		    //middle of the screen
		} else {
		    var $viewPort = $('#viewport');

		    newPosTL = {
			top: Math.abs(parseInt($canvas.css('top'), 10)) + Math.round($viewPort.height()/2),
			left: Math.abs(parseInt($canvas.css('left'), 10)) + Math.round($viewPort.width()/2)+450
		    };
		}

	    } else {

		var $viewPort = $('#viewport');

		newPosTL = {
		    top: ($viewPort.get(0).scrollTop + Math.round($viewPort.height()/2))/zoom,
		    left: ($viewPort.get(0).scrollLeft + Math.round($viewPort.width()/2))/zoom
		};

		mode = "";

	    }

	    //Create Page
	    newPosTL = { top : newPosTL.top * zoom, left: newPosTL.left * zoom };
	    var newPageId = page.create(newPosTL.top, newPosTL.left, mode);

	    //Additional actions after page creation
	    if (newPageId)
	    {
		page.postCreate(newPageId);
	    }

	    tracker.record("addPage", 1, newPageId, e);
	    return newPageId;
	},

	postCreate : function(id, mode)
	{
		if (!canvas2.isZoomedOut())
		{
			var newPageEl = $("#" + id);
            page.activate(newPageEl, undefined, mode);
			zoomInAndCenterOnPage(newPageEl, 1, 1, 200);
			widget.resetSelection();
			setZoomedInActions();
		}
		else
		{
			if (project.get("pages").length == 1)
			{
                //$("#previewView, #trash").fadeIn(300);
                fluidMenu.setCanvasFirstPage();
			}
		}
	},

	serialize : function(id)
	{
		var pageObj = storage.get(id);
		if (!pageObj)
			return;

		var bundle = {id: id};
		bundle[id] = pageObj;

		var widgets = pageObj.widgets;
		for (var idx = 0, len = widgets.length; idx < len; idx++)
		{
			var widgetObj = storage.get(widgets[idx]);
			if (!widgetObj)
				continue;

			bundle[widgets[idx]] = widgetObj;
		}

		return JSON.stringify(bundle);
	},

	deserialize : function(jsonString, mode)
	{
		var bundle = JSON.parse(jsonString);
		if (bundle)
		{
			var pageId = bundle.id;
			var pageObj = bundle[pageId];

			if (!pageObj)
				return;

			storage.set(pageId, pageObj);
			project.addPage(pageId);

			var widgets = pageObj.widgets;
			for (var idx = 0, len = widgets.length; idx < len; idx++)
			{
				var widgetId = widgets[idx];
				var widgetObj = bundle[widgetId];
				if (widgetObj)
					storage.set(widgetId, widgetObj);
			}

			if (canvas2.isZoomedOut()) {
				page.draw(pageId, mode);
			} else {
				page.drawDetailed(pageId, mode);
			}
			page.postCreate(pageId, mode);
		}
	},

    //Allows moving to another page by using the arrow keys when zoomed in
    navigateWithKeys : function(e)
    {
        if (canvas2.isZoomedOut() || !canvas2.isEditorVisible()) { return true; }

        var direction = e != undefined ? utils.getNavigationKeyDirection(e.keyCode) : "right";
        if (direction == "") { return true; }

        var sel = $(".ui-selected").not(".backgroundWidget");
        if (sel.size() > 0) { return; }

        var pages = project.get("pages");
        if (pages < 2) { return; }

        //Initialize and calculate all required info
        var limit = { distance: Number.MAX_VALUE, id: "" };
        var limitDown = { distance: 0, id: "" };
        var currentPageId = $(".screen.active").attr("id");
        var currentXY = { x: page.get(currentPageId, "x"), y: page.get(currentPageId, "y")  };

        $.each(pages, function(i, pageId)
        {
            if (currentPageId != pageId)
            {
                //Calculate distance between pages
                var pageXY = { x: page.get(pageId, "x"), y: page.get(pageId, "y")  };
                var diff = page._getNavigationDistanceFrom(currentXY, pageXY, direction);

                //If the distance is positive, the page is in the right sense
                if ((diff >= 0) && (diff < limit.distance))
                {
                    limit = { distance: diff, id: pageId };
                }
                //If the distance is negative the page is in the opposite side of the selected page in the sense of
                //the navigation key and could be the limit in case no pages are available in the right sense
                else if ((diff < 0)  && (diff < limitDown.distance))
                {
                    limitDown = { distance: diff, id: pageId };
                }
            }
        });

        //Navigate to page
        var pageToGo = limit.id != "" ? limit.id : limitDown.id;
        if (pageToGo != "")
        {
            hint.hide();
            var $newPage = $("#" + pageToGo);
            $(".screen").removeClass("active").filter($newPage).addClass("active"); // activate does this on a timeout!
            zoomInAndCenterOnPage($newPage, 1, 1, 200);
            page.activate($newPage);
            widget.resetSelection();
            setZoomedInActions();
        }
    },

    //Get distance between 2 coordinates in one direction, if the 2nd coordinate is in the opposite direction the result is -1
    _getNavigationDistanceFrom : function(fromXY, toXY, direction)
    {
        if (fromXY == toXY) { return -1; }

        var diff = 0;
        if ((direction == "left") || (direction == "right"))
        {
            diff = toXY.x - fromXY.x;
        }
        else
        {
            diff = toXY.y - fromXY.y;
        }

        if (((direction == "left") || (direction == "top")) && (diff < 0))
        {
            return Math.abs(diff);
        }
        else if (((direction == "right") || (direction == "bottom")) && (diff > 0))
        {
            return diff;
        }
        return Math.abs(diff) * -1;
    },

    pageMenuClick : function()
    {
        $("input", "#pageMenus").blur();
        return false;
    },

	renderBlurs : function (pageId) {
		// if no pageID is given, get the active page's id
		pageId = pageId || ((pageId = document.querySelector('.canvasObject.active')) && pageId.id);
		page.calculateWdgPositions(pageId);

		storage.get(pageId)
			.widgets.forEach(function (w) {
				var widgetElement = document.getElementById(w);

				if(!widgetElement) return;

				if (storage.get(w).blur) {
					widget.blurLayers[w] = widget.renderBlurLayer(w, pageId);
					widget.setBlurBG(widgetElement);
				}
			});
	}
};

var grid = 
{
	toggle : function()
	{
		var gridStatus = account.get("gridStatus");
		(gridStatus == 'on') ? grid.hideGridSettingsMenu() : grid.showGridSettingsMenu();
		return false;
	},

	hideGridSettingsMenu : function()
	{
		$("#gridSwitchOn, #gridControls, #gridControlHeading, #gridSliderArea, #gridSpaceSlider, #gridSpacingInput").hide();		$("#gridSwitchOff").show();
		grid.hideGrid();
		snap.disableGridSnap();	 	
		account.set({gridStatus : 'off'}); 
	},

	gridSliderText : false,
	gridSliderLimit : false,
	showGridSettingsMenu : function()
	{
		 $("#gridSwitchOff, #gridControls").hide();
		$("#gridSwitchOn").show();
		$("#gridControls, #gridControlHeading, #gridSliderArea, #gridSpaceSlider, #gridSpacingInput").show();		account.set({gridStatus : 'on'});
		var gridSlider = $("#gridSpaceSlider");
		grid.gridSliderText = $("#gridSpacingInput");
		var gridSliderWidth = parseInt(gridSlider.css("width"));
		var gridSliderParentWidth = parseInt($("#gridSliderArea").css("width"));
		grid.gridSliderLimit = gridSliderParentWidth - gridSliderWidth;

        grid.getGridSpacing();
		snap.setSnapToGrid();
		grid.showGrid();
	},

	selectInputText : function()
	{
		$(this).select();
	},
	
	/*input : false, // DO NOT COMMENT OUT -this is a good code for making sure that an input field captures the number that the user has entered
	keyToggle : false,
	keyInGridSpacing : function()
	{
		if($(this).val().length > 3) return;
		
		grid.input = $(this).val();
		//console.log($(this).val().length);
		if(grid.keyToggle == 'on')
		{
			return false;
		}
		grid.keyToggle = 'on';
		grid.launchTimer();
	},
	
	launchTimer : function()
	{
		function selectValue()
		{
			var input = grid.input;
			console.log("got input",grid.input);
			
			grid.changeGridSpacing(null,input);
			grid.keyToggle = false;
			grid.input = false;
		}
		
		setTimeout(selectValue,500);
	},*/
	
	/*changeGridSpacing : function(e, input)
	{
		//var input = input || $(this).val();
		console.log("eeee",e);
		if(input)
		{
			var input = input;
		}
		else
		{
			if(e.type = "change")
			{
				var input = e.target.value;
			}
		}
		
		if(input.length < 1 || input == 0 || input > 100) 
		{
			$("gridSpacingInput").attr("value",100); 
			var input = 100;
		}
		var gridSpacing = parseInt(input);
		
		$("#gridSpacingInput").val(gridSpacing);
		$("#gridSpaceSlider").val(gridSpacing);
        //$("#gridSpacingValue").text(gridSpacing + "px");
		account.set({gridSpacing : gridSpacing});
		snap.checkSnapStatus();
		
		grid.drawGrid();
	},*/ 
	
	/*changeGridSpacing : function()
	{
		var input = $(this).val();
		
		if(input.length < 1 || input == 0 || input > 100) 
		{
			$("gridSpacingInput").attr("value",100); 
			var input = 100;
		}
		var gridSpacing = parseInt(input);
		
		$("#gridSpacingInput").val(gridSpacing);
		$("#gridSpaceSlider").val(gridSpacing);
		account.set({gridSpacing : gridSpacing});
		snap.checkSnapStatus();
		
		grid.drawGrid();
	},*/
	
	
	/*initGridSpacing : function(e, ui)
	{
		var gridSlider = $("#gridSpaceSlider");
		grid.gridSlider = gridSlider;
		var gridSliderWidth = parseInt(gridSlider.css("width"));
		var gridSliderPadding = parseInt(gridSlider.css("padding"));
		var gridSliderWidth = gridSliderWidth + (2 * gridSliderPadding);
		var gridSliderParentWidth = parseInt($("#gridSliderArea").css("width"));
		grid.gridSliderLimit = gridSliderParentWidth - gridSliderWidth;
	},*/
	
	changeGridSpacing : function(e, ui)
	{
		var pos = ui.position.left;
		var slope = Math.abs((100 - 4) / (grid.gridSliderLimit));
		var gridSpacing = parseInt((slope * pos) + 4);
		//console.log("position",input);
		grid.gridSliderText.text(gridSpacing + " px");
		account.set({gridSpacing : gridSpacing});		
		snap.checkSnapStatus();
		
		snap.setSnapToGrid();
		grid.drawGrid();
	},
	
	/*stopGridSpacing : function()
	{
		grid.dragObject = false;
		grid.gridSliderLimit = false;
	},*/
	
	getGridSpacing : function()
	{
		var gridSpacing = account.get("gridSpacing");

		var slope = (100 - 4) / (grid.gridSliderLimit);
		var newPosition = Math.abs((gridSpacing - 4) / slope);
		snap.setSnapToGrid();
		grid.updateSliderPos(newPosition, gridSpacing);
	},
	
	sliderPosClick : function(e)
	{
		if(e.target.id == "gridSpacingInput") return;
		
		var getSliderCoords = parseInt($("#gridSliderArea").offset().left);
		var getPagePos = parseInt(e.pageX);

		var sliderAreaWidth = parseInt($("#gridSliderArea").css("width"));
		var sliderWidth = parseInt($("#gridSpaceSlider").css("width"));
		var difference = (sliderAreaWidth - sliderWidth) / sliderAreaWidth;
		var newPosition = Math.abs((getPagePos - getSliderCoords) * difference);
		
		var slope = Math.abs((100 - 4) / (sliderAreaWidth * difference));
		var gridSpacing = parseInt((newPosition * slope) + 4);
		//console.log(slope,gridSpacing,newPosition);
		grid.updateSliderPos(newPosition, gridSpacing);
		account.set({gridSpacing : gridSpacing});
		snap.setSnapToGrid();
		snap.checkSnapStatus();
		
		grid.drawGrid();
	},
	
	updateSliderPos : function(newPosition, gridSpacing)
	{
		$("#gridSpaceSlider").css("left", newPosition);
		grid.gridSliderText.text(gridSpacing + "px");
	},	
	
	pageDims : false,
	currentPageID : false,
	currentPageGridHolder : false,
	getPageProps : function()
	{
		var currentPageID = $("#canvasPages").find(".active").attr("id");
		var currentPageGridHolder = $("#" + currentPageID).find(".page").find(".widgetHolder");
		
		grid.currentPageID = currentPageID;
		grid.currentPageGridHolder = currentPageGridHolder;
		
		//set width, height etc parameters
		var width = page.get(currentPageID, "width"); 
		var height = page.get(currentPageID, "height"); 
		
		var pageDims = {width: width, height: height};
		grid.pageDims = pageDims;

		return currentPageGridHolder;
	},

	showGrid : function(projectWh,pageWh)
	{
		if (project.readOnly()) 
		{ 
			return false; 
		}
		$("#gridSquares").remove(); // remove everything
		//var gridHolder = (projectWh || pageWh) ? getLivePageProps() : grid.getPageProps();
		var gridHolder = grid.getPageProps();
		var getBackgroundWidget = gridHolder.find(".backgroundWidget").attr("id");

		if(getBackgroundWidget)
		{
			//$("#tmplGrid").tmpl(grid.pageDims).insertAfter("#" + getBackgroundWidget);
			$("#tmplGrid").tmpl(grid.pageDims).appendTo("#" + getBackgroundWidget);
		}
		else 
		{ 
			$("#tmplGrid").tmpl(grid.pageDims).prependTo(gridHolder); 
		}

		grid.drawGrid();
	},
	
	drawGrid : function()
	{
		function drawIntermediateLines()
		{
			c.beginPath();
			c.strokeStyle='rgb(127,185,240)';
			for(var i = (gridSpacing*5); i < grid.pageDims.height; i+=(gridSpacing*5)) // horozontal lines
			{
				c.moveTo(0, i + 0.5);
				c.lineTo(grid.pageDims.width, i + 0.5);
			}
		
			for(var i = (gridSpacing*5); i < grid.pageDims.width; i+=(gridSpacing*5)) // vertical lines
			{
				c.moveTo(i + 0.5, 0);
				c.lineTo(i + 0.5, grid.pageDims.height);
			}
			c.stroke();
		}
		
		if (account.get("gridStatus") != "on") { return ; }

		var gridSpacing = account.get("gridSpacing");
        var squares = $("#gridSquares");
        if (squares.size() == 0) { return; }
		var c = (squares[0]).getContext("2d");
		c.clearRect(0, 0, grid.pageDims.width, grid.pageDims.height); // remove everything
		
		if(gridSpacing < 4)
		{
			c.clearRect(0, 0, grid.pageDims.width, grid.pageDims.height); // remove everything
			return;
		}

		c.beginPath();
		c.strokeStyle='rgb(176,217,255)';
		
		for(var i = gridSpacing; i < grid.pageDims.height; i+=gridSpacing) // horozontal lines
		{
			c.moveTo(0, i + 0.5);
			c.lineTo(grid.pageDims.width, i + 0.5);
		}
		
		for(var i = gridSpacing; i < grid.pageDims.width; i+=gridSpacing) // vertical lines
		{
			c.moveTo(i + 0.5, 0);
			c.lineTo(i + 0.5, grid.pageDims.height);
		}
			
		c.stroke();

		drawIntermediateLines(gridSpacing);
		
	},
	
	hideGrid : function()
	{
		$("#gridSquares").remove();
	},
	
	selectBackground : function()
	{
		var zoom = project.get("currentZoom");
		if(zoom == 1){
			var gridStatus = account.get("gridStatus");
			if(gridStatus == 'on')//if you've clicked on something and the grid is on
			{
				grid.showGrid();
			}	
			else return;
		}
	},
	
	zoomIn : function()
	{
        if (project.readOnly()) { return; }
		var gridStatus = account.get("gridStatus");

		// if grid status is set to on in the current page ID - show grid; if it's set to on in a different page ID, don't show grid
		if(gridStatus == 'on')
		{
			grid.showGridSettingsMenu(); //show the grid
		}
		else if(gridStatus == 'off')
		{
			grid.hideGridSettingsMenu();//reset toggle
		}
		
		snap.checkSnapStatus();
	}
};
var snap = 
{
	closeSnapSettings : function()
	{
		var settingsPanel = $("#snapSettingsPanel");
		if(settingsPanel.hasClass("openPanel")){ page.showDefaultSnapOptions();}
	},
	toggle : function(e)
	{
		var snapWidgetStatus = account.get("snapToWidget");
		(snapWidgetStatus == 'on') ? snap.disableWidgSnap() : snap.setSnapToWidgEdges();
	},
	
	checkSnapStatus : function()
	{
		var gridStatus = account.get("gridStatus");
		var snapWidgetStatus = account.get("snapToWidget");
		if(snapWidgetStatus == 'off' || gridStatus == 'off') { return false;}
		
		if(snapWidgetStatus == 'on') { snap.setSnapToWidgEdges();}
		
		if(gridStatus == 'on') {snap.setSnapToGrid();}
	},
	
	setSnapToGrid : function()
	{
			var gridSpacing = account.get("gridSpacing");
			if(gridSpacing < 4)
			{
				$("#canvasPages .pageWidget").draggable( "option", "grid", false);
			}
			else
			{
				$("#canvasPages .pageWidget").draggable( "option", "grid", [gridSpacing, gridSpacing] );
			}
		return false;
	},
	
	topDiff : 0,
	leftDiff : 0,
	topConstant : 0,
	leftConstant : 0,
	groupConstantTop : 0,
	groupConstantLeft : 0,
	setMovementConstant : function($this,ui,snapToGrid)
	{
		snap.topConstant = 0;
		snap.leftConstant = 0;
		snap.groupConstantTop = 0;
		snap.groupConstantLeft = 0;
		
		if($this.length > 1)
		{
			$this = $this.eq(1);
			var multipleSelection = true;
		}
		else 
		{
			var multipleSelection = false;
		}
		
		if(widget._activeGroup)
		{
			var activeGroupEl = $("#" + widget._activeGroup);
			snap.groupConstantTop = parseInt(activeGroupEl.css("top"));
			snap.groupConstantLeft = parseInt(activeGroupEl.css("left"));
		}

		if($this.hasClass("rootWidget"))
		{	
			snap.topDiff = 0;
			snap.leftDiff = 0;
		}
		else
		{
			var gridSpacing = account.get("gridSpacing");
			var lockTo = $this.attr("data-lockto");
			var rootWidgetPos = $this.siblings(".rootWidget").filter('[data-lockto="' + lockTo + '"]').offset();
			var selectedPos = $this.offset();
			snap.topDiff = (selectedPos.top - rootWidgetPos.top) % gridSpacing;
			snap.leftDiff = (selectedPos.left - rootWidgetPos.left) % gridSpacing;
		}
		
		if(snapToGrid == 'on' && multipleSelection == true)
		{
			var gridSpacing = account.get("gridSpacing");
			$("#canvasPages .pageWidget").draggable( "option", "grid", [gridSpacing,gridSpacing]);//set the snapping BRUTE FORCE FIX
			
			var multiselBoxPos = widget._selectionBoxCoord;
			var leftSelBox = multiselBoxPos.left;
			var topSelBox = multiselBoxPos.top;
			snap.topConstant = topSelBox;// % gridSpacing;
			snap.leftConstant = leftSelBox;// % gridSpacing;
		}
	},
	
	widgetSnapToGrid : function($this,top,left)
	{
		var gridSpacing = account.get("gridSpacing");
		if(widget._activeGroup)
		{
			$this.data().draggable.position.top = top - ((top + snap.groupConstantTop) % gridSpacing);
			$this.data().draggable.position.left = left - ((left + snap.groupConstantLeft) % gridSpacing);
			return;
		}
		
		if(widget._moveMultiSelection == true)
		{
			$this.data().draggable.position.top = top - (snap.topConstant % gridSpacing);
			$this.data().draggable.position.left = left - (snap.leftConstant % gridSpacing);
		}
		else
		{
			$this.data().draggable.position.top = top + snap.topDiff - (top % gridSpacing);
			$this.data().draggable.position.left = left + snap.leftDiff - (left % gridSpacing);
		}
	},
	
	snapResize : function(snapToGrid)
	{
			if(snapToGrid == 'on') //snap to grid// init the snapping if the grid is on
			{
				var gridSpacing = account.get("gridSpacing");
				var snapSetting = [gridSpacing,gridSpacing];
			}
			else if(snapToGrid == 'off')
			{
				var snapSetting = false;
			}
			return snapSetting;
	},
	
	snapResizeDragStart : function(ui, $this)
	{
		var gridSpacing = account.get("gridSpacing");
		var originalPosition = ui.originalPosition;
		var originalSize = ui.originalSize;
		var topConstant = gridSpacing - ((originalPosition.top + originalSize.height) % gridSpacing);
		var leftConstant = gridSpacing - ((originalPosition.left + originalSize.width) % gridSpacing);
		var resizeTconstant = originalPosition.top % gridSpacing;
		var resizeLconstant = originalPosition.left % gridSpacing;
			
		if(widget._resizeAxis == 'se' || widget._resizeAxis == 'sw')
		{	
			$($this).data().resizable.originalSize.height += topConstant;
			$($this).data().resizable.originalSize.width += leftConstant;
		}
		else if(widget._resizeAxis == 'ne' || widget._resizeAxis == 'nw')
		{
			$($this).data().resizable.originalSize.width += resizeLconstant;
			$($this).data().resizable.originalSize.height += resizeTconstant;
		}
		else if(widget._resizeAxis == 'w')
		{
			$($this).data().resizable.originalPosition.left -= resizeLconstant;
			$($this).data().resizable.originalSize.width += resizeLconstant;
		}
		else if(widget._resizeAxis == 'e')
		{
			$($this).data().resizable.originalSize.width += leftConstant;
		}
		else if(widget._resizeAxis == 'n')
		{
			$($this).data().resizable.originalPosition.top -= resizeTconstant;
			$($this).data().resizable.originalSize.height += resizeTconstant;
		}
		else if(widget._resizeAxis == 's')
		{
			$($this).data().resizable.originalSize.height += topConstant;
		}
		
	},
	
	libraryGridSnapOn : function(ret,pageEdges)
	{
		if(ret){ return; }
		
		if(pageEdges){ return;}
		else
		{
			var gridSpacing = account.get("gridSpacing");
			$(".libraryWidget").draggable( "option", "snap", false );
			$(".libraryWidget").draggable( "option", "grid", [gridSpacing,gridSpacing]); //reset everything
		}
	},
	
	libraryGridSnapOff : function(ret)
	{
		if(ret){return;}
		else
		{ 
			$(".libraryWidget").draggable( "option", "grid", false);
			$(".libraryWidget").draggable( "option", "snap", "#canvasPages .widgetHolder, #canvasPages  .pageWidget" );
		}
	},
	
	setSnapToWidgEdges : function()
	{
		account.set({snapToWidget : 'on'});
		$("#snapSwitchOn, #snapSwitchOff").hide();
		$("#snapSwitchOn").show();
	},
	
	disableWidgSnap : function()
	{
		account.set({snapToWidget : 'off'});
		$("#snapSwitchOn, #snapSwitchOff").hide();
		$("#snapSwitchOff").show();
	},
	
	multiSelDLeft : false,
	multiSelDTop : false,
	multiSelOffset : function(widgetPos)
	{
		if(widget._moveMultiSelection == true)
		{
			var boxOffset = $("#multiSelBox").offset();
			snap.multiSelDLeft = widgetPos.left - boxOffset.left;
			snap.multiSelDTop = widgetPos.top - boxOffset.top;
		}
		else
		{
			snap.multiSelDLeft = 0;
			snap.multiSelDTop = 0;
		}
	},
	
	snapToWidgEdges : function($this,top,left) //maybe don't need to pass the "top" and "left"
	{
		function setLeftRightPos(leftPos,rightPosOffset)
		{
			$this.data().draggable.position.left = (rightPosOffset) ? rightPosOffset + snap.multiSelDLeft + snap.leftDiff : leftPos + snap.multiSelDLeft + snap.leftDiff;
			$("#tmplVsnapHelper").tmpl({left : leftPos}).appendTo("#" + grid.currentPageID);
			setTimeout(function(){return;},timeDelay);
		}
		
		function setTopBottomPos(topPos,bottomPosOffset)
		{
			$this.data().draggable.position.top = (bottomPosOffset) ? bottomPosOffset + snap.multiSelDTop + snap.topDiff : topPos + snap.multiSelDTop + snap.topDiff;
			$("#tmplHsnapHelper").tmpl({top : topPos}).appendTo("#" + grid.currentPageID);
			setTimeout(function(){return;},timeDelay);
		}
		
		function setMidTopPos(topMidPos,topMidOffset)
		{
			$this.data().draggable.position.top = topMidOffset + snap.topDiff + snap.multiSelDTop;
			$("#tmplMidHsnapHelper").tmpl({top : topMidPos}).appendTo("#" + grid.currentPageID);
			setTimeout(function(){return;},timeDelay);
		}
		
		function setMidLeftPos(leftMidPos,leftMidOffset)
		{
			$this.data().draggable.position.left = leftMidOffset + snap.multiSelDLeft + snap.leftDiff;
			$("#tmplMidVsnapHelper").tmpl({left : leftMidPos}).appendTo("#" + grid.currentPageID);
			setTimeout(function(){return;},timeDelay);
		}
		
		snap.removeAlignGuides(); // important : remove everything
		
		var right = left + snap.widgWidth;
		var bottom = top + snap.widgHeight;
		var pageRight = grid.pageDims.width + 80; 
		var pageBottom = grid.pageDims.height + 80;
		var pageLeft = -80;
		var pageTop = -80;
		
		if(((bottom > pageTop) && (top < pageBottom)) && ((right > pageLeft) && (left < pageRight)))
		{
			var timeDelay = 1500;
			var snapToGrid = account.get("gridStatus");
			var snapTolerance = (snapToGrid == 'on') ? 3 : 6;
			
			var left = left - snap.multiSelDLeft - snap.leftDiff;
			var top = top - snap.multiSelDTop - snap.topDiff;
			
			$.each(snap.leftSnapArr, function(item) 
			{ 
				var leftPos = snap.leftSnapArr[item];
				var posLeftMin = leftPos - snapTolerance;// - snap.multiSelDLeft;
				var posLeftMax = leftPos + snapTolerance;// - snap.multiSelDLeft;
				var widgWidthOffset = left + snap.widgWidth;
				
				if (left >  posLeftMin && left < posLeftMax) 
				{ 
					setLeftRightPos(leftPos);
				}
				else if(widgWidthOffset > posLeftMin && widgWidthOffset < posLeftMax)
				{
					var rightPosOffset = leftPos - snap.widgWidth;
					setLeftRightPos(leftPos,rightPosOffset);
				}
			});
			
			$.each(snap.topSnapArr, function(i) 
			{ 
				var topPos = snap.topSnapArr[i];
				var posTopMin = topPos - snapTolerance;
				var posTopMax = topPos + snapTolerance;
				var widgHeightOffset = top + snap.widgHeight;
				
				if (top > posTopMin && top < posTopMax)  
				{ 
					setTopBottomPos(topPos);	
				}
				else if(widgHeightOffset > posTopMin && widgHeightOffset < posTopMax)
				{
					var bottomPosOffset = topPos - snap.widgHeight;
					setTopBottomPos(topPos,bottomPosOffset);
				}
			});
			
			$.each(snap.midTopSnapArr, function(j) 
			{ 
				var topMidPos = snap.midTopSnapArr[j];
				var posMidTMin = topMidPos - snapTolerance - snap.widgMidPointHeight;// - snap.multiSelDTop;
				var posMidTMax = topMidPos + snapTolerance - snap.widgMidPointHeight;// - snap.multiSelDTop;
				var topMidOffset = topMidPos - snap.widgMidPointHeight;
				
				if ( top > posMidTMin && top < posMidTMax) 
				{
					setMidTopPos(topMidPos,topMidOffset);
				}
			});
			
			$.each(snap.midLeftSnapArr, function(k) 
			{ 
				var leftMidPos = snap.midLeftSnapArr[k];
				var posMidLMin = leftMidPos - snapTolerance - snap.widgMidPointWidth;// - snap.multiSelDLeft;
				var posMidLMax = leftMidPos + snapTolerance - snap.widgMidPointWidth;//- snap.multiSelDLeft;
				var leftMidOffset = leftMidPos - snap.widgMidPointWidth;
				
				if ( left > posMidLMin && left < posMidLMax) 
				{
					setMidLeftPos(leftMidPos,leftMidOffset);
				}
			});
		}
	},
	
	originalResizePosRight : false,
	originalResizePosBottom : false,
	setResizeEdgeBounds : function(ui)
	{
		snap.originalResizePosRight = ui.originalSize.width + ui.originalPosition.left;
		snap.originalResizePosBottom = ui.originalSize.height + ui.originalPosition.top;
	},
	
	resizeToWidgEdges : function(ui,t)
	{
		function setRightPos(x,xMid)
		{
			var xPos = (x) ? x : xMid;
			$this.data().resizable.size.width = xPos - ui.originalPosition.left;
			$this.data().resizable.position.left = ui.originalPosition.left;
			if(x) { $("#tmplVsnapHelper").tmpl({left : xPos}).appendTo("#" + grid.currentPageID);}
			else { $("#tmplMidVsnapHelper").tmpl({left : xPos}).appendTo("#" + grid.currentPageID);}
			
			setTimeout(function(){return;},timeDelay);
		}
		
		function setLeftPos(x,xMid)
		{
			var xPos = (x) ? x : xMid;
			$this.data().resizable.position.left = xPos;
			$this.data().resizable.size.width = snap.originalResizePosRight - xPos; //ui.originalSize.width + (ui.position.left - ui.originalPosition.left);
			
			if(x) { $("#tmplVsnapHelper").tmpl({left : xPos}).appendTo("#" + grid.currentPageID);}
			else { $("#tmplMidVsnapHelper").tmpl({left : xPos}).appendTo("#" + grid.currentPageID);}
			
			setTimeout(function(){return;},timeDelay);
		}
		
		function setTopPos(y,yMid)
		{
			
			var yPos = (y) ? y : yMid;
			$this.data().resizable.position.top = yPos;
			$this.data().resizable.size.height = snap.originalResizePosBottom - yPos;
			
			if(y) { $("#tmplHsnapHelper").tmpl({top : yPos}).appendTo("#" + grid.currentPageID);}
			else {  $("#tmplMidHsnapHelper").tmpl({top : yPos}).appendTo("#" + grid.currentPageID);} 
			
			setTimeout(function(){return;},timeDelay);
		}
		
		function setBottomPos(y,yMid)
		{
			var yPos = (y) ? y : yMid;
			$this.data().resizable.position.top = ui.originalPosition.top;
			$this.data().resizable.size.height = yPos - ui.originalPosition.top;
			
			if(y) { $("#tmplHsnapHelper").tmpl({top : yPos}).appendTo("#" + grid.currentPageID);}
			else { $("#tmplMidHsnapHelper").tmpl({top : yPos}).appendTo("#" + grid.currentPageID);}
			
			setTimeout(function(){return;},timeDelay);
		}
		
		var w = ui.position.left;
		var east = ui.size.width + ui.originalPosition.left;
		var n = ui.position.top;
		var s = ui.size.height + ui.originalPosition.top;
		
		resizeDirX = (ui.position.left != ui.originalPosition.left) ? 'left' : 'right';
		resizeDirY = (ui.position.top != ui.originalPosition.top) ? 'up' : 'down';

		var snapToGrid = account.get("gridStatus");
		var snapTolerance = (snapToGrid == 'on') ? 3 : 8;
		var timeDelay = 1500;
		 //set for left, right, top, bottom
		snap.removeAlignGuides();
		var $this = $(t);
		
		if(ui.originalSize.width > 4){
			$.each(snap.leftSnapArr, function(item) 
			{ 
				var x = snap.leftSnapArr[item];
				var posXMin = x - snapTolerance;// - snap.multiSelDLeft;
				var posXMax = x + snapTolerance;// - snap.multiSelDLeft;
				
				if(resizeDirX == 'right')
				{
					if (east >  posXMin && east < posXMax) { setRightPos(x);}
				}
				else if(resizeDirX == 'left')
				{
					if (w >  posXMin && w < posXMax) { setLeftPos(x);}
				}
			});
		}
		
		if(ui.originalSize.height > 4){
			$.each(snap.topSnapArr, function(i) 
			{ 
				var y = snap.topSnapArr[i];
				var posYMin = y - snapTolerance;
				var posYMax = y + snapTolerance;
				
				if(resizeDirY == 'up')
				{
					if (n > posYMin && n < posYMax) {setTopPos(y);}
				}
				else if(resizeDirY == 'down')
				{
					if (s > posYMin && s < posYMax) {setBottomPos(y);}
				}
			});
		}
		
		if(ui.originalSize.height > 4){
			$.each(snap.midTopSnapArr, function(j) 
			{ 
				var yMid = snap.midTopSnapArr[j];
				var posMidYMin = yMid - snapTolerance;
				var posMidYMax = yMid + snapTolerance;
				
				if(resizeDirY == 'up')
				{
					if (n > posMidYMin && n < posMidYMax) { setTopPos(false,yMid);}
				}
				else if(resizeDirY == 'down')
				{
					if (s > posMidYMin && s < posMidYMax) { setBottomPos(false,yMid);}
				}
			});
		}
		
		if(ui.originalSize.width > 4){
			$.each(snap.midLeftSnapArr, function(k) 
			{ 
				var xMid = snap.midLeftSnapArr[k];
				var posMidXMin = xMid - snapTolerance;// - snap.multiSelDLeft;
				var posMidXMax = xMid + snapTolerance;
				
				if(resizeDirX == 'right')
				{
					if (east > posMidXMin && east < posMidXMax) { setRightPos(false,xMid);}
				}
				else if(resizeDirX == 'left')
				{
					if (w >  posMidXMin && w < posMidXMax) { setLeftPos(false,xMid);}
				}
			});
		}
		
	},
	
	removeAlignGuides : function()
	{
		$("#canvasPages .hGuide, #canvasPages .vGuide, #canvasPages .midHGuide, #canvasPages .midVGuide").remove();
	},
	
	widgWidth : false,
	widgHeight : false,
	widgMidPointWidth : false,
	widgMidPointHeight : false,
	selectedWidgSnapPos : function() //called on dragStart
	{
		snap.widgWidth = widget._selectionTLWH.width;
		snap.widgHeight = widget._selectionTLWH.height;
		// init middle top points
		snap.widgMidPointWidth = snap.widgWidth / 2;
		snap.widgMidPointHeight = snap.widgHeight / 2;
	},
	
	leftSnapArr : false,
	topSnapArr : false,
	midLeftSnapArr : false,
	midTopSnapArr : false,
	initSnapPositions : function()
	{
		function erasePosData()
		{
			snap.leftSnapArr = false;
			snap.topSnapArr = false;
			snap.midLeftSnapArr = false;
			snap.midTopSnapArr = false;
		}
		
		var snapWidgetStatus = account.get("snapToWidget");
		if(snapWidgetStatus == 'on')
		{
			var currentPageID = grid.getPageProps(); // grid.CurrentPageID is set there!
			var selected = $("#canvasPages .ui-selected");
			var selectedLockTos = $([]);
			var selectedRoots = [];
			selected.each(function()
			{
				var t = $(this);
				if(t.hasClass("rootWidget"))
				{
					var id = t.attr("id");
					selectedLockTos = selectedLockTos.add($('[data-lockto="' + id + '"]')).not(".rootWidget");
				}
				else {
					var root = widget.getRoots(t);
					var rootId = $(root).attr("id");
					selectedRoots.push(rootId);
				}
			});
			
			if($(currentPageID).find(selected).length == 0) //check if the selected widget is the element of the current page
			{
				erasePosData();
				return;
			}
	
			var unselectedWidgets = $(currentPageID).children().not(selected).not(".backgroundWidget").not(selectedLockTos).filter(".rootWidget");
		
			snap.leftSnapArr = new Array(); //init positions of array
			snap.topSnapArr = new Array();
			snap.midLeftSnapArr = new Array();
			snap.midTopSnapArr = new Array();
			
			unselectedWidgets.each(function(){
				var t = $(this);
				var top = parseInt(t.css("top"));
				var left = parseInt(t.css("left"));
				var width = parseInt(t.css("width"));
				var height = parseInt(t.css("height"));
				var bottom = top + height;
				var right = left + width;
	
				var matchSelRootId = selectedRoots.indexOf(t.attr("id"));
				if(matchSelRootId < 0){ //prevent midpoint aligning on root widgets of selected subwidgets
					var midTop = parseInt(top + (height / 2));
					var midLeft = parseInt(left + (width / 2));
				}
				
				snap.leftSnapArr.push(left,right);
				snap.topSnapArr.push(top,bottom);
				snap.midLeftSnapArr.push(midLeft);
				snap.midTopSnapArr.push(midTop);		
			});
		}
	},
	
	disableGridSnap : function()
	{
		$("#canvasPages .pageWidget").draggable( "option", "grid", false);
	}
	
};
/************************************************************************
Class widget.
*************************************************************************/
var widget = 
{
	editing : false,
	//copies : [],
	selectMulti : false,
	widgetOffset : null, 
	locked : null,
	currSelection : null,
	useCanvas : false, // whether to use canvas or image rendering for widgets.

	
	// get obj from storage
	get : function(id)
	{
		var data;
		if(typeof widgets !== 'undefined')
		{
			data = widgets.summary[id] && $.extend(true, {id : id}, widgets.summary[id]);
		}
		if(data == undefined)
		{		
			data = storage.get(id);
		}
		return data || false;
	},

	// Sets storage.
	set : function(obj, id)
	{
		var j = storage.get(id);
		if(!j)
		{ 
			return false; 
		}
		
		for (var o in obj)
		{ 
			j[o] = obj[o]; 
		}
		storage.set(id, j);
	},		
	

	//gets set of widgets and returns true if any of the widgets contain text content
	containsText : function($sel)
	{
		for (var i = 0; i < $sel.length; i++)
		{
            var widgId = $sel.eq(i).attr('id');
			var wdgObj = widget.get(widgId);
			if( wdgObj.tc )
            {
                return true;
            }
            else
            {
                var sub = widget.getDependents(widgId);
                if (sub.length > 0)
                {
                    return widget.containsText(sub);
                }
            }
		}
		return false;
	},

    //gets set of widgets and returns the first object that contain text content
    getSubTextElements: function(widgEl)
    {
        var response = $([]);

        var widgId = widgEl.attr('id');
        var allSubs = widget.getDependents(widgId);
        allSubs.each(function(){
            response = response.add(widget.getSubTextElements($(this)));
        });
        var wdgObj = widget.get(widgId);
        if( wdgObj.tc )
        {
            response = response.add(widgEl);
        }

        return response;
    },



    getRoots : function(sel) // TODO: we can store this data locally if this select is slow?
	{
		var all = $([]);
		$(sel).each(function()
		{
			if($(this).hasClass("rootWidget"))
			{
				all = all.add($(this));
			}
			else
			{
				var lockTo = $(this).attr("data-lockto");
				all = all.add($(this).siblings(".rootWidget").filter('[data-lockto="' + lockTo + '"]') );
			}
		});
		
		return all;
	},
	
	getLockTos : function(sel)
	{
		var all = $([]);
		var roots = widget.getRoots(sel);
		roots.each(function()
		{
			all = all.add( $('[data-lockto="' + $(this).attr("id") + '"]'));
		});
		return all;
	},
	
	getSelectedOnly : function(sel) //select a root widget and exclude all AD's
	{
		function addMultiSegment(id)
		{
			sel.each(function()
			{
				if($(this).attr("data-segment") == $(this).attr("id"))
				{
					if($(this).attr("data-lockto") == id)
					{
						all = all.add($(this)); //selEl.filter($(this));
					}
					else
					{
						return;
					}
				}
			});
		}
		
		var all = $([]);
		sel.each(function()
		{
			//if($(this).hasClass('ui-selected')) //if the user clicked on a widget or subwidget, add to selection or else remove it
			if($(this).hasClass('ui-selected'))
			{
				var widgObj = widget.get($(this).attr("id"));
				if(widgObj.sc && !widgObj.bg) //if it's a multisegment, skip, cause we will add them later
				{
					var id = $(this).attr("id");
					addMultiSegment(id);
				}
				else // if this multisegment has a background, add the root only
				{
					//console.log("why are we adding this?",$(this).attr("id"));
					all = all.add($(this));
				}
			}
		});
		//console.log("all",all);
		return all;
		
	},
	
	
	// gets list of widgets with OffsetFrom (of) of widgId. Uses rootSel if passed.	
	getDependentsCache : [], 
	getDependents : function (widgId, lockTos, useCache)
	{	
		if(useCache && widget.getDependentsCache[widgId])
		{		
			return widget.getDependentsCache[widgId];
		}
		if(!useCache)
		{
			widget.getDependentsCache = [];
		}
		
		var lockTos = lockTos || widget.getLockTos($("#" + widgId));
		var all = $([]);
		
		lockTos.each(function() // speedup: build a tree rather than doing this every iteration.
		{
			var subWidgEl = $(this);
			var subWidgId = subWidgEl.attr("id");
			var subWidgObj = widget.get(subWidgId);
			if(!subWidgObj.of)
			{
			
			}
			if(subWidgObj.of == widgId)
			{
				all = all.add(subWidgEl);
			}
		});
		widget.getDependentsCache[widgId] = all;
		return all;
	},
	
	
	//a helper function to get page having widgetId without dom traversing
	getPageOf: function(widgetId) 
	{
		var arrPages = project.get("pages");
		var arrWidgets;
		
		for(var i=0; i<arrPages.length; i++){
			arrWidgets = page.get(arrPages[i], 'widgets');
			for(var j=0; j<arrWidgets.length; j++){
				if( widgetId == arrWidgets[j] ) return arrPages[i];
			}
		}
	},

	saveTempFile : function(id, file)
	{
		storage.setTempItem(id + '_file', file);
	},
	
	getTempFile : function(id)
	{
		return storage.get(id + '_file');
	},
	
	removeTempFile : function(id)
	{
		storage.remove(id + '_file');
	},


	verticalAlign : function(obj) //Factors In the Padding And Side of text for alignment
	{		
		var divEl = obj.find(".widgetText");   
		
		if(divEl.length == 0)
		{
			return;
		}
		// DO NOT REMOVE - NEW STUFF
		/*
		var size = parseInt( obj.css("height"));	
	
		var fontSize = divEl.css("font-size");
		var style = divEl.css("font-family");
		divEl.contents().wrapAll('<span></span>');
		
		var span = divEl.find('span').eq(0);
		span.css("font-size",fontSize);
		span.css("font-family",style);
	    var textHeight = parseFloat(span.css("height"));//Get height of text displayed 
		span.contents().eq(0).unwrap();
		
		var percentage = 100 * (parseFloat(divEl.css('top')) / size); 
	
		var verticalpos = (size - textHeight) * percentage;
	
		verticalpos =  (verticalpos <= 0) ? 0: verticalpos;
		divEl.css("margin-top", "0px");		
		//divEl.css("padding-top", verticalpos.toString() + "px");
		divEl.css("top", verticalpos.toString() + "px");
        updateTLWH();
		*/
		
		var size = parseInt( obj.css("height"));	

		var fontSize = divEl.css("font-size");
		var style = divEl.css("font-family");
		divEl.contents().wrapAll('<span></span>');

		var span = divEl.find('span').eq(0);
		span.css("font-size",fontSize);
		span.css("font-family",style);
	    var textHeight = parseFloat(span.css("height"));//Get height of text displayed 
		span.contents().eq(0).unwrap();
		//console.log("TOP!",divEl.css('top'));
		var percentage = (parseFloat(divEl.css('top')) / size) * 100; 
		//var verticalpos = (size * percentage) - (textHeight * percentage)
		var verticalpos = (size - textHeight) * percentage;
		verticalpos =  (verticalpos <= 0) ? 0 : verticalpos;
		//console.log("VEVEVEVEVEVEV",verticalpos,size - textHeight,percentage);
		//divEl.css("top", 0);
		divEl.css("padding-top", verticalpos + "px");
        updateTLWH();
		
		var singleWdgObj = widget.get(obj.attr('id'));
		singleWdgObj.ts = divEl.attr('style');
		widget.set(singleWdgObj, singleWdgObj.id);
	},

	
	autoWidth : function(data,mode) // Update Widgets with auto with tag 
	{
		//var wh = [data.wh[0], data.wh[1]];
		var wh = [data.tlwh[2], data.tlwh[3]];
		var pagew = mode != 'library' ? $('.active .widgetHolder').width() : 320;
		
        if(pagew == null && wh[0] == "a")
		{
			wh[0] = 320;
		}
		else if(wh[0] == "a" )
		{
			wh[0] = pagew;
		}
		
		return wh;
	},
	
	//library function.
	addUploads : function ()
	{
		var uploads = account.get("uploads");
		for(var u in uploads)	// get it from memory.
		{
			//console.log("Obj in uploads:", storage.get(uploads[u].id));
			var obj = storage.get(uploads[u].id);
			widgets.summary[uploads[u].id] = obj;		// add it in to widgets.summary so it can render
		}
	},

	_redraw : function(el, widgetObj, conf)
	{
		if(widgetObj.segment)
		{
			var segRoot = widget.get(widgetObj.lockTo);
			var segData = widget._setupSegments(segRoot);
			widget._updateSegments(segRoot, segData, conf);
			//return;
		}
		var pageId = $(".screen.active").attr("id");
		var absTLWH = widget._setTMPLVars(el.attr('id'),widgetObj,[0,0, parseInt(page.get(pageId, "width")), parseInt(page.get(pageId, "height"))]);  
		widget._drawCanvasOrImage(el,absTLWH);
	},

	hasOwnColorProperties : function(wgt)
	{
		if (typeof wgt == 'string')
		{
			wgt = widget.get(wgt);
		}

		return !wgt.srps && Boolean(wgt.bg || wgt.bgc || wgt.b);
	},

	serialize : function(id)
	{
		function bundleDependentsRecursively(id) {
			widget.getDependents(id).each(function() {
				var swId = $(this).attr("id");
				bundle[swId] = storage.get(swId);
				bundleDependentsRecursively(swId);
			});
		}

		var widgetObj = storage.get(id);
		if (!widgetObj)
			return;

		var bundle = {
			id: id,
		};
		bundle[id] = widgetObj;
		bundle[id].insertAfterId = $('#'+id).prev().attr('id'); 

		if ($('#'+id).prev().length == 0) {
			bundle[id].insertAfterId = 'first';
		}

		bundleDependentsRecursively(id);

		return JSON.stringify(bundle);
	},

	deserialize : function(jsonString, toPageId, segRootId, segPos)
	{
		var bundle = JSON.parse(jsonString);
		if (bundle)
		{
			// Root widget has to be created first
			var widgetId = bundle.id;
			var widgetObj = bundle[widgetId];

			var pageElem = $('#' + toPageId);
			var container = pageElem.find('.widgetHolder');
			var containerTLWH = [0, 0, container.outerWidth(), container.outerHeight()];

			var insertAfterId = widgetObj.insertAfterId;

			widget._save(widgetId, widgetObj, pageElem);
			widget._draw(widgetId, container, containerTLWH, false, false, insertAfterId);

			// Set up this widgets as segment, if it is
			var segRootObj = segRootId && storage.get(segRootId);
			if (segRootObj && segRootObj.seg && 'segment' in widgetObj && widgetObj.segment == widgetId)
			{
				widget._insertSegmentObj(segRootObj, widgetId, widgetObj, segPos);
			}

			insertAfterId = widgetId;

			delete bundle.id;
			delete bundle[widgetId];

			for (widgetId in bundle)
			{
				widgetObj = bundle[widgetId];
				if (widgetObj) {
					widget._save(widgetId, widgetObj, pageElem);
					widget._draw(widgetId, container, containerTLWH, false, false, insertAfterId);
					insertAfterId = widgetId;
				}
			}
		}
	},

	//DA: 08-Mar-2012: Check the Widget's integrity.  (Check if the name of the widget has been changed and maps it to the new Widget
	//id:  Widget's Instance ID.
	checkIntegrity : function(id, pageData) {
		var obj = widget.get(id);
		//console.log("Checking Widget Integrity: " + id, obj);
		if (!obj)
		{
			return true;
		}

		//Check if the widget is still a valid widget or replace it by the new widget
		if (obj.name)
		{
			//Map of Old Widgets
			var oldWidgets = {
				"blackSearch": "widget201010120",
				"tablerowsliderlongblank": "widget201010120",
				"pROGRESSBAR": "widget893",
				"iconStatusBarDark": "widget730",
				"iconStatusBarLight": "widget729",
				"iconStatusBarTrans": "widget731",
				"webLoading":"widget615",
				"webUrlEntry":"widget613",
				"webShortcuts":" widget614",
				"barmapbottomwithtext":"widget910",
				"iPHONEMENUSDARK1":"widget917",
				"rOWCONTENTX1SELECTED":"widget926",
				"spinner":"widget308",
				"dIALINGPAD":"widget908",
				"mEDIAPLAYER":"widget3071",
				"buttonbackandnext":"widget919",
				"switchonwithtext":"widget309",
				"iconLibrary":"widget137",
				"iconAdd":"widget127",
				"iconNext":"widget133",
				"iconRemove":"widget135",
				"sortAlpha":"widget788",
				"iconsorthandles":"widget789",
				"iconAttach":"widget128",
				"iconBack":"widget129",
				"iconForward":"widget130",
				"iconForward1":"widget1301293847",
				"iconInfo":"widget131",
				"'iconTick":"widget136",
				"iconTick1":"widget1342343236",
				"iconWorking":"widget132"

			};

			if (oldWidgets[obj.name])
			{
				//console.log("Updating: obj.name", obj.name);
				widget.replace(id, oldWidgets[obj.name]);
			}
		}

		//console.log("Checking Widget Integrity: " + id + ". Top: " + obj.top + ". Left: " + obj.left, obj);
		//DA: 25-May-2012: Check TLWH properties for backwards compatibility after new widgets methods
		if (!obj.tlwh)
		{
			widget.fixTLWH(id, obj, pageData);
		}

		return true;

	},

	// Loads widgets on a page.
	load : function (pageId, widgList, loadPreview) {
		var appendTo = $("#" + pageId).find(".widgetHolder");
		var container = [0, 0, appendTo.outerWidth(), appendTo.outerHeight()];

		if(loadPreview == true) {
			var staticWidgetHolder = $("#" + pageId).find(".fixedWidgetHolderFront");
			//var staticWidgetHolderBack = $("#" + pageId).find(".fixedWidgetHolderBack");
			var ordinaryWidgetHolder = appendTo;
		}
		
		for(var j=0; j<widgList.length; j++) {
			if(loadPreview == true) {
				var widgetObject = widget.get(widgList[j]);
				appendTo = ordinaryWidgetHolder;
				
				var positionInBounds = false;
				if(widgetObject.st == 'f') { 
					positionInBounds = staticWidgets.findPositionOnScreen($([]),widgList[j],loadPreview);
					if(positionInBounds == true){
						appendTo = staticWidgetHolder;
					}
				}/*
				else if(widgetObject.st == 'fb' || widgetObject.st == 'b') { 
					positionInBounds = staticWidgets.findPositionOnScreen($([]),widgList[j],loadPreview);
					if(positionInBounds == true){
						appendTo = staticWidgetHolderBack;
					}
				}
				*/				
			}
				
			widget._draw(widgList[j], appendTo, container, false, false, widgList[j].insertAfterId);
		}
	}
};

	
	
	//hover : function(e)
	widget.hover = function(e)
	{
		if (project.readOnly()) return false;
		if(project.get("currentZoom") != 1) return true;  // only hover links at 100%.
		
		var l = link.from( $(this).attr("id") ); // get any link that comes from this.
		var type = (e.type == "mouseover") ? "active" : "ahref";
		if(l)
		{
			var dest = link.goesTo(l);
			link.draw($("#"+ l), $(this).attr('id'), dest, type);
			//link.draw($("#"+ l), $(this), $("#" + dest), type)
		}
	};
	
	//click : function(e)
	widget.click = function(e)
	{
		//console.log("Clicking on a widget");
		if (!$('#canvas').data('zooming'))
		{
			if( $(".pageWidget textarea").length > 0 ) return true; // text editing, let propagate. 
			if(project.get("currentZoom") != 1) return true; // zoomed out, propagate to page click. 

			$this = $(this);
	
			var editingText = $(".pageWidget textarea");
			if( editingText.length > 0 && editingText.closest(".pageWidget").attr("id") != $this.attr("id")  ) 
			{ 
				widget._stopEditingText();
			} 	
			
			var screen = $this.closest(".screen"); // the screen the widget is in.
			var activeScreenId = $(".active").attr("id");

			if(activeScreenId != screen.attr("id"))
			{
                var duration = 300;
				var centering = zoomInAndCenterOnPage(screen, 1, 1, duration);
				page.activate(screen, false);
                setTimeout(function() {
                    widget.select(e, $this);
                }, duration);
			} else {
                widget.select(e, $this);
            }

			page.hideOptionsMenu();
			
			// YURI quick fix for page menu hiding
			if(	$("#fluidDropdown").is(":visible") )
			{
				contextMenu.place();
				fluidMenu.hide();
			}
		}
		return false;
	};	
	
	// Library only - dbl click to add widgets.
	widget.addDefault = function(e)
	{
		var active = $("#canvasPages .active");
		var widgetId;
		
		if(active.length == 1)
		{
			// get default position if there is one. 
			var dp = {top: 0, left: 0}; // top, left
			if(widgets.summary[$(this).attr("id")].dp)
			{
				dp.top = widgets.summary[$(this).attr("id")].dp[0] ;
				dp.left = widgets.summary[$(this).attr("id")].dp[1] ;
			}
			var wh = active.find(".widgetHolder");

			widgetId = widget.add(e, {top: wh.offset().top + dp.top -5, left: wh.offset().left + dp.left -5}, $(this).attr("id"), wh); // TODO: -5 is a horrible fix to the drop snap problem.
            tracker.record("addWidget", 1, $(this).attr("id"), e);
		}

        return widgetId;
	};


	// calculate the size of the widget and sizes and coordinates of segments // if seg is defined, treat the widget as multisegment;
	widget._setupSegments = function(rootObj, containerTlwh, insDelPos, isDel)
	{
		var segments = [];
		var rootObj = $.extend(true, {}, rootObj); //throwaway object copy

		rootObj.sc = rootObj.sc || 1; // set defaults
		rootObj.sl = rootObj.sl || 'h';
		rootObj.sa = rootObj.sa || 'tl';
		rootObj.sp = rootObj.sp || [0, 0, 0, 0]; // sp is a ltbr

		// enumerate segments, calculate total fixed size, find autosized segments
		var segData = widget._enumSegments(rootObj, insDelPos);
		
		// set up segment borders for segments that has not been rendered yet; otherwise borders 
		// will be updated in updateSegments
		// TODO: this is actually very wrong: will set 'border' property for library widgets
		if (!rootObj.segments)
		{
			for (var idx = 0, len = segData.segments.length; idx < len; idx++)
			{
				var seg = segData.segments[idx];
				widget._setSegmentBorder(rootObj, segData.segments, idx);
				widget.set({b: seg.wObj.b}, seg.id);
			}
		}
		else if (!isDel)
		{
			var idx = typeof insDelPos != 'undefined' ? insDelPos : segData.segments.length - 1;
			var seg = segData.segments[idx];
			widget._setSegmentBorder(rootObj, segData.segments, idx);
			widget.set({b: seg.wObj.b}, seg.id);
		}

		var rootTLWH = rootObj.tlwh || rootObj.wh;
		var sizeIdx = (rootObj.sl == 'h' ? 2 : 3) - (rootObj.tlwh ? 0 : 2);

		if (typeof rootTLWH[sizeIdx] == 'string')
		{
			if (!containerTlwh)
			{
				var container = rootObj.of ? $('#' + rootObj.of) : $('#canvasPages .active .widgetHolder');
				containerTlwh = [0, 0, container.width(), container.height()];
			}

			var containerSize = rootObj.sl == 'h' ? containerTlwh[2] : containerTlwh[3] ;

			// if multisegment widget is autosized and any of the segments are autosized as well, then set 
			// the widget size to maximum
			if (rootTLWH[sizeIdx] == 'a' && segData.autoSizeSegments.length > 0)
			{
				rootTLWH[sizeIdx] = containerSize;
			}
			else
			{
				var pc = utils.fromPercentString(rootTLWH[sizeIdx], containerSize);
				if (!isNaN(pc))
				{
					rootTLWH[sizeIdx] = pc;
				}
			}
		}

		segData.rootTlwh = rootTLWH;

		// layout segments: calculate segment positions and sizes
		widget._setSegmentTLWH(rootObj, segData);

		return segData;
	};

	widget._enumSegments = function(rootObj, insPos)
	{
		function enumSegment(segId, segObj, isNew)
		{
			if(!segObj){ return; } // prevent error in case of segment not being defined.

			var segment = {wId: segId, wObj: segObj};
			
			
			if (!isNew || insPos === undefined)
			{
				segments.push(segment);
			}
			else
			{
				segments.splice(insPos, 0, segment);
				insPos++;
			}

			//var size = segObj.tlwh ? segObj.tlwh[sizeIdx] : segObj.wh[sizeIdx - 2];
			var size = segObj.tlwh ? segObj.tlwh[sizeIdx] : segObj.wh[sizeIdx - 2]; // 0 width or 1 height
			
			//console.log("  ======segObj.wh", segObj.wh);
			
			if (segObj.autoSize || typeof size === "string") // size == 'a' || // figure out the size later.
			{
				//console.log("  ==== size percentage conversion needed", size, rootObj, insPos)
				segObj.autoSize = true; // set auto size flag as we need to replace 'a' with real size
				autoSizeSegments.push(segment);
			}
			else
			{
				//console.log("  ======Adding total size", totalSize, size);
				totalSize += size;
			}
			//console.log("    ======TotalSize", totalSize);
		}

		var segments = [];
		var autoSizeSegments = [];
		var totalSize = 0;
		var sizeIdx = rootObj.sl == 'h' ? 2 : 3;

		if (rootObj.segments && rootObj.segments.length > 0) // updating or cloning existing widget
		{
			if (rootObj.segments.length > 0 && rootObj.segments[0].hasOwnProperty('id')) // updating
			{
				var exSegCount = 0;   // total existing segment count
				var widgetUsage = {}; // per-widget segment usage counts to determine which segment to add

				for (var idx = 0, len = rootObj.segments.length; idx < len; idx++)
				{
					var segObj = widget.get(rootObj.segments[idx].id);

					if (segObj)
					{
						var wgtId = rootObj.segments[idx].widget;
						enumSegment(wgtId, segObj);

						exSegCount++;
						if (widgetUsage[wgtId])
						{
							widgetUsage[wgtId]++;
						}
						else
						{
							widgetUsage[wgtId] = 1;
						}
					}
				}

				// add new segments, if needed
				for (var addIdx = exSegCount; addIdx < rootObj.sc; addIdx++)
				{
					// find segment widget with minimal usage and add it
					var minUseCnt = Number.MAX_VALUE;
					var addSegId;
					for (var segIdx = 0; segIdx < rootObj.seg.length; segIdx++)
					{
						var segId = rootObj.seg[segIdx];
						var useCnt = widgetUsage[segId] || 0;
						if (useCnt < minUseCnt)
						{
							minUseCnt = useCnt;
							addSegId = segId;
						}
					}

					var segData = widget.get(addSegId);

					//DA: 24-Apr-2012: Adjust size when the segment should have the same size of the root widget
					//TODO:  Define attribute [rr] behavior.
					// TODO: the following doesn't take into account obj.sp
					/*
					if (segData.rr)
					{
						if (segData.rr == "y")
						{
							segData.wh = [rootObj.tlwh[2], rootObj.tlwh[3]];
						}
						else
						{
							if (segData.rr.indexOf("h") > -1)
							{
								segData.wh[0] = rootObj.tlwh[2];
							}
							if (segData.rr.indexOf("v") > -1)
							{
								segData.wh[1] = rootObj.tlwh[3];
							}
						}
					}
					*/

					enumSegment(addSegId, segData, true);
				}
			}
			else // cloning
			{
				for (var idx = 0, len = rootObj.segments.length; idx < len; idx++)
				{
					//var segId = rootObj.segments[idx].widget;
					//enumSegment(segId, widget.get(segId));
					var segId = rootObj.segments[idx].originalID;
					var segData = widget.get(segId);

					if (!segData)
					{
						segData = widget.get(rootObj.segments[idx].widget);
					}
					else
					{
						//DA: 23-Apr-2012: This allows the addOrUpdateSegments to know that this is a new segment to add
						segData.id = rootObj.segments[idx].widget;
					}
					//console.log("Setting Segments: " + segData.id + ". Widget: " + rootObj.segments[idx].widget, segData, widget.get(obj.segments[idx].widget));
					enumSegment(rootObj.segments[idx].widget, segData);
				}
			}
		}
		else // creating new widget
		{
			var widgetCount = rootObj.seg.length;
			for (var segIdx = 0, wgtIdx = 0; segIdx < rootObj.sc; segIdx++, wgtIdx = segIdx % widgetCount)
			{
				var segId = rootObj.seg[wgtIdx];
				var newWidget = widget.get(segId);
				enumSegment(segId, newWidget);
			}
		}

		return {
			segments : segments,
			autoSizeSegments : autoSizeSegments,
			totalSize : totalSize
		};
	};

	widget._setSegmentTLWH = function(rootObj, segData)
	{
		var tlwh = rootObj.tlwh || [0, 0, rootObj.wh[0], rootObj.wh[1]];
		var posIdx = rootObj.sl == 'h' ? 1 : 0;
		var sizeIdx = rootObj.sl == 'h' ? 2 : 3;
		var segPos = [rootObj.sp[1] || 0, rootObj.sp[0] || 0];
		var segPosBR = rootObj.sp[2 + posIdx] || 0;
		
		var segAreaAvailSpace = tlwh[sizeIdx] - segPos[posIdx] - segPosBR - segData.totalSize;

		// set segment auto sizes
		if (segData.autoSizeSegments.length > 0)
		{
			var segSize = Math.floor(segAreaAvailSpace / segData.autoSizeSegments.length);
			var segSizeRem = segAreaAvailSpace - (segSize * segData.autoSizeSegments.length); // remainder to be distributed between segments

			for (var idx = 0; idx < segData.autoSizeSegments.length; idx++, segSizeRem--)
			{
				var seg = segData.autoSizeSegments[idx].wObj;
				var size = segSize + Number(segSizeRem > 0);
				segData.totalSize += size;

				if (seg.tlwh)
				{
					seg.tlwh[sizeIdx] = size;
				}
				else
				{
					seg.wh[sizeIdx - 2] = size;
				}
			}
		}

		// set widget auto size
		if (tlwh[sizeIdx] == 'a' || segData.autoSize)
		{
			segData.autoSize = true; // set auto size flag as we need to replace 'a' with real size now
			tlwh[sizeIdx] = segData.totalSize + segPos[posIdx] + segPosBR;
		}

		// set segment positions according to alignment
		var segDist = 0;
		var segDistRem = 0;
		if (!segData.autoSize)
		{
			switch(rootObj.sa)
			{
				case 'br': // bottom/right
					segPos[posIdx] = tlwh[sizeIdx] - segPosBR - segData.totalSize;
					break;

				case 'c': // center
					segPos[posIdx] += segAreaAvailSpace >> 1;
					break;

				case 'd': // distribute evenly
					segDist = Math.floor(segAreaAvailSpace / (rootObj.sc + 1));
					segDistRem = segAreaAvailSpace - (segDist * (rootObj.sc + 1));
					break;
			}
		}

		for (var idx = 0; idx < segData.segments.length; idx++, segDistRem--)
		{
			segPos[posIdx] += segDist + Number(segDistRem > 0);
			segData.segments[idx].pos = [segPos[0], segPos[1]];

			var seg = segData.segments[idx].wObj;
			var segTlwh = seg.tlwh || [0, 0, seg.wh[0], seg.wh[1]];

			segPos[posIdx] += segTlwh[sizeIdx];
		}

		// update root object size as well if autosized
		if (segData.autoSize)
		{
			segData.rootTlwh = tlwh;

			if (rootObj.tlwh)
			{
				rootObj.tlwh[sizeIdx] = tlwh[sizeIdx];
			}
			else
			{
				rootObj.wh[sizeIdx - 2] = tlwh[sizeIdx];
			}
		}
	};

	// takes the segments object and recalculates the obj (root) based on it.
	// called after all segment operations. Repositions/redraws. 
	widget._updateSegments = function(rootObj, segData, conf)
	{
		var segments = segData.segments;
		var objElem = $('#' + rootObj.lockTo);

		// for each remaining segment 
		for (var idx = 0; idx < segments.length; idx++) // for each segment passed.
		{
			var borderUpdated = widget._setSegmentBorder(rootObj, segments, idx);
			var seg = segments[idx];
			var segId = rootObj.segments[idx].id;

			// segments position in relation to each other.
			if (segId && (segId.substr(0, 2) == 'w_' || (segId.substr(0, 1) == 'w' && segId.length == 33)) ) // old version fix where _ wasnt present.
			{
				var objPos = objElem.position();
				var segObj = widget.get(segId);

				var segElem = $('#' + segId);
				var segPos = segElem.position();
				
				var ofsLeft = seg.pos[1] + objPos.left - segPos.left;
				var ofsTop = seg.pos[0] + objPos.top - segPos.top;
				var moved = ofsLeft != 0 || ofsTop != 0;

				var props = {tlwh: $.merge([], segObj.tlwh)};
				
				var autoSized = typeof props.tlwh[2] == 'string' || typeof props.tlwh[3] == 'string';
				var resized = false;

				var objTlwh = [0, 0, objElem.width(), objElem.height()];
				var tmplVars = widget._setTMPLVars(segId, seg.wObj, objTlwh);

				var canvas = $('canvas, img', segElem);
				
				conf = conf || {};
				var forceRedraw = conf.redraw == 'all' || (conf.redraw == 'seg' && conf.segId == segId);

				if (moved)
				{
					segElem.css({left: segPos.left + ofsLeft + 'px', top: segPos.top + ofsTop + 'px'});
					props.tlwh[0] = seg.pos[0];
					props.tlwh[1] = seg.pos[1];
				}

				if (autoSized)
				{
					resized = tmplVars.absTLWH[2] != canvas.width() || tmplVars.absTLWH[3] != canvas.height();
				}
				else
				{
					var segSize = [canvas.width(), canvas.height()];
					resized = segSize[0] != props.tlwh[2] || segSize[1] != props.tlwh[3];
				}

				if (resized || forceRedraw)
				{
					function updateCanvas(canvas, segElem, tlwh)
					{
						segElem.add(canvas).add($('textarea, .widgetText', segElem)).css({width: tlwh[2] + 'px', height: tlwh[3] + 'px'});
						canvas.attr({width: tlwh[2], height: tlwh[3]});
					}

					if (conf.redraw == 'img' && canvas.get(0).tagName == 'CANVAS')
					{
						// save canvas image and restore it after resizing canvas
						if (!canvas.data('replacing'))
						{
							canvas.data('replacing', true);

							var img = new Image();
							img.src = canvas.get(0).toDataURL('image/png');
							img.onload = (function(canvas, img, segId, seg) {
								return function () {
									if (canvas.data('cancelReplace'))
									{
										canvas.data({'replacing': false, 'cancelReplace': false});
									}
									else
									{
										$(img).data('origCanvas', canvas);
										canvas.data('replacing', false).replaceWith(img);

										var tmplVars = widget._setTMPLVars(segId, seg.wObj, [0, 0, objElem.width(), objElem.height()]);
										updateCanvas($(img), $('#' + segId), tmplVars.absTLWH);
									}
								}
							})(canvas, img, segId, seg);
						}
					}
					else
					{
						updateCanvas(canvas, segElem, tmplVars.absTLWH);
					}
				}

				if (borderUpdated)
				{
					props.b = $.merge([], seg.wObj.b);
				}

				if (conf.redraw != 'none' && conf.redraw != 'img' && (borderUpdated || resized || forceRedraw))
				{
					if (canvas.data('replacing'))
					{
						canvas.data('cancelReplace', true);
					}
					else
					{
						var origCanvas = canvas.data('origCanvas');
						if (origCanvas)
						{

							canvas.replaceWith(origCanvas).data('origCanvas', null);
							origCanvas.
								attr({width: tmplVars.absTLWH[2], height: tmplVars.absTLWH[3]}).
								css({width: tmplVars.absTLWH[2] + 'px', height: tmplVars.absTLWH[3] + 'px'});
						}
					}

					widget._drawCanvasOrImage(segElem, tmplVars);
				}

				widget.set(props, segId);
				
				var ads = $('#canvasPages [data-segment="' + segId + '"]').not(segElem);
				widget._updateDependents(segId, objTlwh, ads);
			}		
		}

		widget.set({tlwh: rootObj.tlwh,sc: segments.length,segments: rootObj.segments}, rootObj.lockTo); // update the root.
		widget._updateSegmentRoot(rootObj.lockTo, rootObj, segData);
	};

	widget._updateSegmentRoot = function(rootId, rootObj, segData)
	{
		var tlwh = rootObj.tlwh || [0, 0, rootObj.wh[0], rootObj.wh[1]];
		var rootTlwh = widget._getSegmentRootTLWH(rootId, rootObj, segData); // return correct px value.

		if (!utils.arraysEqual(rootObj.tlwh, rootTlwh) || utils.isPercentString(rootTlwh[2]) || utils.isPercentString(rootTlwh[3]))
		{
			var container = $('#canvasPages .active .widgetHolder');
			var containerTlwh = [0, 0, container.width(), container.height()];

			var tmplVars = widget._setTMPLVars(rootId, rootObj, containerTlwh);
			tmplVars.tlwh = $.merge([], rootTlwh);

			//widget.set({tlwh: tmplVars.tlwh}, rootId); // may not handle %
			
			var rootElem = $('#' + rootId);
			rootElem.css({
				width: rootTlwh[2] + 'px',
				height: rootTlwh[3] + 'px'
			});
			widget._drawCanvasOrImage(rootElem, tmplVars);
		}
	};

	widget._getSegmentRootTLWH = function(id, obj, segData)
	{
		var tlwh;

		if (segData && segData.rootTlwh)
		{
			tlwh = segData.rootTlwh;
		}
		else
		{
			var isHorz = !obj.sl || obj.sl == 'h';
			var sizeIdx = isHorz ? 2 : 3;
			
			tlwh = $.merge([], obj.tlwh);

			if (tlwh[sizeIdx] == 'a')
			{
				segData = widget._enumSegments(obj);
				
				var segPosLT = obj.sp ? obj.sp[isHorz ? 0 : 1] : 0;
				var segPosBR = obj.sp ? obj.sp[isHorz ? 3 : 2] : 0;

				tlwh[sizeIdx] = segData.totalSize + segPosLT + segPosBR;
			}
		}
		return tlwh;
	};

	widget._setSegmentBorder = function(wgt, segments, idx)
	{
		if (!segments)
		{
			segments = wgt.segments || [];
		}

		if (segments && segments.length > 0)
		{
			var lastSegIdx = segments.length - 1;
			var layout = wgt.sl || 'h';
			var prop = 'bs';

			if (lastSegIdx > 0)
			{
				switch(idx)
				{
					case 0:
						prop = layout == 'h' ? 'bls' : 'bts';
						break;
					case lastSegIdx:
						prop = layout == 'h' ? 'brs' : 'bbs';
						break;
					default:
						prop = 'bms';
						break;
				}
			}
		}

		var seg = segments[idx].wObj;

		if (!seg.hasOwnProperty('bs'))
		{
			seg.bs = seg.b;
		}

		var oldBorder = seg.b;
		seg.b = $.merge([], seg[prop] || seg.b || []);

		return !utils.arraysEqual(seg.b, oldBorder || []);
	};

	widget._isMultiSegment = function ($id)
	{
		if($id == "")
		{
			return false;
		}
	
		// if its a segment - get the root.
		var segmentOrigin = $("#" + $id).attr("data-lockto");	
		var selectedWidget = storage.get(segmentOrigin);
	
		var segments = selectedWidget && selectedWidget.seg;
		if (segments && segments.length > 0)
		{
			return true;
		}
		return false;
	};
	
	
	//TODO: needs to add data segment data. 
	widget._addSegment = function()
	{
		var addedSegIds = [];

		// clicking add when multiple in same select results in multiple rows added. 
		$(".ui-selected").addClass("rememberSelected").each(function()
		{
			var $id = $(this).attr("id");
			var segmentId = $(this).attr('data-segment');
			var isSegment = Boolean(segmentId);

			if (isSegment && $(this).attr('data-segment') != $id)
			{
				$id = $(this).attr('data-segment');
			}

			var root = widget.getRoots($(this));
			var rootId = root.attr("id");
			var rootWidget = widget.get(rootId);
			//console.log("Root is", root, rootWidget);
			
			var insPos;
			if (isSegment)
			{	
				insPos = 0;
				for (var len = rootWidget.segments.length; insPos < len; insPos++)
				{
					if (rootWidget.segments[insPos].id == $id)
					{
						insPos++;
						break;
					}
				}
			}
			
			if (rootWidget && rootWidget.seg) // if multisegment
			{
				var pageElem = $('#canvasPages .active');
				var pageObj = storage.get(pageElem.attr('id'));

				var container = rootWidget.of ? $('#' + rootWidget.of) : pageElem.find('.widgetHolder');
				var containerTLWH = [0, 0, container.width(), container.height()];

				rootWidget.sc++;
				var segData = widget._setupSegments(rootWidget, containerTLWH, insPos);

				if (typeof insPos == 'undefined')
				{
					insPos = segData.segments.length - 1;
				}

				var newSegment = segData.segments[insPos];

				// if border or background properties has been set for all segments, apply to new segment
				/*
				if (!widget.hasOwnColorProperties(rootWidget))
				{
					var brdProp = ['b', 'bs', 'bts', 'bls', 'bms', 'bbs', 'brs'];
					for (var bIdx = 0; bIdx < brdProp.length; bIdx++)
					{
						var propVal = newSegment.wObj[brdProp[bIdx]];
						if (propVal)
						{
							propVal[0] = rootWidget.b[0]; // border width
							propVal[1] = rootWidget.b[1]; // border color
						}
					}

					newSegment.wObj.bgc = rootWidget.bgc;
				}
				*/

				//drops relevant ads
				//console.log("Dropping segment at ", newSegment.pos);
				
				var id = widget._createSaveAndDraw(newSegment.wObj, rootWidget["lockTo"], pageElem, newSegment.pos, container, containerTLWH, root.attr('id'), true);
				rootWidget.segments.splice(insPos, 0, {id: id, widget: newSegment.wId});

				widget._updateSegments(rootWidget, segData);

				addedSegIds.push(id);
			}

			return false;
		});

		widget.resetSelection();
		widget.select("dontMovePosition", $('.rememberSelected')); // show - but dont move.
		$('.rememberSelected').removeClass('rememberSelected');
		
		return addedSegIds; // stop the cm going away. 
	};

	widget._insertSegmentObj = function(rootWidget, segId, segObj, insPos)
	{
		rootWidget.segments.splice(insPos, 0, {id: segId, widget: segObj.wId});
		rootWidget.sc++;

		widget._updateSegments(rootWidget, widget._setupSegments(rootWidget));
	};

	// TODO: Make this ageneric for position, - first - last - n + get segment data?
	widget._getLastSegment = function(rootEl) // id is the id of a rootwidget.
	{
		var selectedWidget = storage.get(rootEl);
		var segments = selectedWidget && selectedWidget.segments; // the list of segments in the object saved. 
		
		if (segments && segments.length > 0)
		{
			return segments[segments.length - 1].id;
		}
		return false;
	};
	
	widget.getSegmentsFromSelection = function(sel) // make a generic getSegmentsFromSel?
	{
		var widgSel = $([]);
	
		$(sel).each(function()
		{
			var widgEl = $(this);
			var seg = widgEl.attr("data-segment"); // ad or segment
			if (!seg && widgEl.hasClass("rootWidget"))
			{
				var seg = widget._getLastSegment(widgEl.attr("id"))
			}
			widgSel = widgSel.add($("#" + seg));
		});
		return widgSel;
	};
	
	widget._deleteSegment = function(e, id)
	{	
		function deleteSegmentFromProject() // may not need root. 
		{
			var segEl = $(this);
			var segId = segEl.attr("data-segment");
			var rootId = segEl.attr("data-lockTo");
			if(!segId){ return; } // not a segment.
			
			
			var rootObjTmp =  storage.get(rootId);
			if(!rootObjTmp) return; // root no longer exists. The widgets are free. Error from upgrade case.
			
			var rootObj = $.extend(true, {}, storage.get(rootId));
			var delPos = 0;
			
			//console.log("Root before error:", rootObj);
			
			for (; delPos < rootObj.segments.length; delPos++) // TODO: Check delPos is valid. 
			{
				if (rootObj.segments[delPos].id == segId)
				{
					break; // delPos now set.
				}
			}	
			
			widget.remove(segId); // delete the last segment
			rootObj.segments.splice(delPos, 1); // get rid of the object
			rootObj.sc--;
			storage.set(rootId, rootObj); //TODO: widget.set?
				
			if(rootObj.segments.length == 0) // if there are no segments left, delete this root and we are done here.  
			{
				//console.log("rootObj.segments.length", rootObj.segments.length);
				widget.del($('#' + rootId));
				contextMenu.hide();
				propInspector.resetPropInspector();
				return;
			}

			var segData = widget._setupSegments(rootObj, null, delPos, true); // TODO: These need to be reviewed. 
			widget._updateSegments(rootObj, segData);
			
			if( $("#" + rootId).hasClass("ui-selected")) // deleting a selected segment, select previous.
			{
				toSelectAfter += "#" + rootId + ",";
			}
			else
			{
				var prev = (delPos > 0) ? delPos -1 : 0;
				toSelectAfter += "#" + rootObj.segments[prev].id + ",";
			}
		}
	
		//var segsToDel = $([]);
		//$(".ui-selected").each(getSegmentToDelete);
		
		var toSelectAfter = "";
		var segsToDel = id ? $('#' + id) : widget.getSegmentsFromSelection(".ui-selected");
		segsToDel.each(deleteSegmentFromProject);
		
		widget.resetSelection();
		widget.select("dontMovePosition", toSelectAfter);		
		return false;	
	};

	widget._getSegmentPosition = function(segEl)
	{
		var segId = $(segEl).attr('id');
		var rootObj = storage.get($(segEl).attr('data-lockto'));
		var pos = 0;
		for (var len = rootObj.segments.length; pos < len; pos++)
		{
			if (rootObj.segments[pos].id == segId)
			{
				break;
			}
		}

		return pos;
	};


	// Draws an entire widget from the id passed, including sub and segment.
	// called from library and from dragging onto page. 
	widget._drawFromRoot = function(widgId, appendTo, contTLWH, widgObj, adPositioning) //widgObj can have some alterations already done to it (size mostly) by drag widget.
	{
		//console.log('!!! ', widgId, appendTo, contTLWH, widgObj, adPositioning);
		widgObj = widgObj || widget.get(widgId); // no extend , that done as soon as anyway. 
		var expandedWidgObj = widget._draw(widgId, appendTo, contTLWH, widgObj, adPositioning);

		if(widgObj.seg && widgObj.sc)
		{
			var segData = widget._setupSegments(widgObj, contTLWH);
			for(var i=0, len = segData.segments.length; i < len; i++)
			{
				var segment = segData.segments[i];
				var container = [segment.pos[0], segment.pos[1], contTLWH[2], contTLWH[3]];
				
				//console.log("  Container adding a Segment", container,segment, segData );
				widget._drawFromRoot(segment.wId, appendTo, container, segment.wObj, adPositioning);	
			}
		}	

		for(var i in widgObj.ad) // update the container - its the parent of the previous?
		{
			var adId = (expandedWidgObj.ad[i])[0];
			var pos = (expandedWidgObj.ad[i])[3] || "tl"; // likely not needed TL.
			var adPositioning = [(expandedWidgObj.ad[i])[2], (expandedWidgObj.ad[i])[1], pos]; // 2/1 order = convert XY pos into TL!
			var adObj = false;
			widget._drawFromRoot(adId, appendTo, expandedWidgObj.absTLWH, adObj, adPositioning);	
		}

		return expandedWidgObj; 
	}

	// Draws a single widget, no ad's or segments.
	widget._draw = function(id, appendTo, contTLWH, widgObj, adPositioning, insertAfterId)
	{
		var widgObj = widgObj || widget.get(id);
		//console.log('_draw: ', widgObj);
		if(!widgObj){ return false; }	
		
		var tmplVars = widget._setTMPLVars(id, widgObj, contTLWH, adPositioning); // extended version of object. , containerTLWH

		//id of the upload is expected in data attr when drawing the upload
		if(tmplVars.isHelperWidget && tmplVars.upload && tmplVars.upload === 'y') {
			tmplVars.data = id;
		}

		// VK 2012-11-01: fix for Android scaling problem which manifests as 1 pixel white margin on the right and bottom at some specific 
		// scale values; add 1 to widget width/height in case widget right/bottom edge is on the edge of the page; this added width/height
		// will not be visible where device pixel ratio is > 1 and the page is scaled down

		// TODO: this will need to be removed or changed as we move our widget positioning/dimensions from device to CSS pixels
		/* doesn't work in stock browser with HW acceleration
		if (browserDetect.OS == 'Android' &&
			window.hasOwnProperty('devicePixelRatio') && window.devicePixelRatio > 1)
		{
			var pageWidth = widgObj.lockTo == id ? contTLWH[2] : appendTo.width();
			var pageHeight = widgObj.lockTo == id ? contTLWH[3] : appendTo.height();

			if (tmplVars.absTLWH[1] + tmplVars.absTLWH[2] == pageWidth)
			{
				tmplVars.absTLWH[2] += 1;
			}

			if (tmplVars.absTLWH[0] + tmplVars.absTLWH[3] == pageHeight)
			{
				tmplVars.absTLWH[3] += 1;
			}
		}
		*/
		//console.log(tmplVars);
		var obj = $("#tmplWidget2").tmpl(tmplVars);

		widget._drawCanvasOrImage(obj, tmplVars); // draws the canvas part of the widget.  canvas, obj, mode

		if (appendTo) {
			if (widgObj.st == 'b') {
				appendTo.prepend(obj) //prepend backgrounds
			} else {
				if (insertAfterId) {
					if (insertAfterId === 'first') {
						appendTo.prepend(obj);
					} else {
						obj.insertAfter($('#'+insertAfterId));
					}
				} else { 
					appendTo.append(obj);
				}
			}
		}

		return tmplVars; // needed sometimes to position subwidgets.
	}
	
	// sets everything needed in tmplVars before calling .tmpl() and _drawCanvasOrImage()
	widget._setTMPLVarsCache = [];
	widget._setTMPLVars = function(id, data, contTLWH, adPositioning, useCache) //, containerTLWH
	{
		if(useCache && widget._setTMPLVarsCache[id])
		{		
			return widget._setTMPLVarsCache[id];
		}
		if(!useCache)
		{
			widget._setTMPLVarsCache = [];
		}
	
		var tmplVars = $.extend(true, {}, data); // copy the widget object from memory
		tmplVars.id = id; // set id temporarily for drawing widget.
		tmplVars.useCanvas = widget.useCanvas; // safari = canvas, chrome = img.
		tmplVars.includeCanvasOrImage = (((tmplVars.b || tmplVars.bg) && !tmplVars.srps) || tmplVars.upload || tmplVars.i) ? true : false; // include an image/canvas tag.
		tmplVars.isRootwidget = (id == tmplVars.lockTo) ?  true : false; // include class rootwidget
		tmplVars.isLibaryWidget = (tmplVars.lockTo != undefined) ?  true : false;
		tmplVars.of = (tmplVars.of) ? tmplVars.of : tmplVars.lockTo; // not relevant to lib or dragging widgets.
        tmplVars.isText = (data.ts || data.tc) ? true : false;
		tmplVars.isBackgroundWidget = (data.st == 'b') ? true : false;
		tmplVars.isStaticWidgetForeground = (data.st == 'f') ? true : false;
		//tmplVars.isStaticWidgetBackground = (data.st == 'fb') ? true : false;

        //set line-height property for textWidgets to 1.14*font-size. This is done to prevent browser inconsistencies
        if(data.ts) {
            var whSuffixFound = data.ts.match(/width:\s*100\%;\s*height:\s*100%;\s*white-space:\s*pre-wrap/g);
            if(whSuffixFound && whSuffixFound.length) {
                tmplVars.addWH = false;
            } else {
                tmplVars.addWH = true;
            }
            var fontSize;
            var lineHeight = '';
            if(tmplVars.ts.indexOf('font-size') !== -1){
                fontSize = tmplVars.ts.substring( data.ts.indexOf('font-size')+10, tmplVars.ts.indexOf(';', tmplVars.ts.indexOf('font-size'))).trim();
                fontSize = parseFloat(fontSize);
            } else {
                var font = tmplVars.ts.match(/font:[^;]*;/g);
                if(font.length) {
                    var sizes = font[0].match(/[0-9]*px/g);
                    if(sizes.length) {
                        fontSize = parseFloat(sizes[0]);
                    }
                    if(sizes.length && sizes.length>1) {
                        lineHeight = sizes[1];
                    }
                }
            }

            if(lineHeight === '' && tmplVars.ts.indexOf('line-height') !== -1) {
                lineHeight = tmplVars.ts.substring( tmplVars.ts.indexOf('line-height')+12, tmplVars.ts.indexOf(';', tmplVars.ts.indexOf('line-height'))).trim();
            }

            if(fontSize && lineHeight.indexOf('normal') !== -1 ) {
                if(tmplVars.ts.indexOf('line-height') !== -1) {
                    tmplVars.ts = tmplVars.ts.replace(/line-height:\s*normal/g, 'line-height: '+Math.round(fontSize*1.14)+'px');
                } else {
                    tmplVars.ts = tmplVars.ts.replace(/[0-9]*px\/[0-9]px/g, fontSize+'px/'+Math.round(fontSize*1.14)+'px');
                }
            } else if(fontSize && lineHeight === '') {
                tmplVars.ts = tmplVars.ts + '; line-height: '+Math.round(fontSize*1.14)+'px;'
            }
        }
		
		
		if(!tmplVars.tlwh) // library or updating color from colorpicker
		{
			//console.log("  calculating tlwh from wh or container", tmplVars.wh, [contTLWH[2], contTLWH[3]] );
			// may need to handle "a" segment width here.
			var wh = tmplVars.wh || [contTLWH[2], contTLWH[3]];		// no width/height fills the container - background.
			tmplVars.tlwh = [0,0, wh[0], wh[1]]; // lib widgets have wh, not tlwh
		}
			
		tmplVars.ca = (adPositioning) ? adPositioning[2] || 'tl' : tmplVars.ca || "tl"; // its position in an AD, or its listed CA, or default to top left.
		tmplVars.absTLWH = widget._getAbsTLWH(id, tmplVars, contTLWH, adPositioning); //, containerTLWH

		if(useCache)
		{
			widget._setTMPLVarsCache[id] = tmplVars;
		}	
		return tmplVars;
	}
	
	// Returns the absolute coordinates with respect to the page/container its in.
	// TODO: Cache these - iterations happen a lot.
	// TODO: this can only get called from inside _setTMPLVars - move it in there.

	widget._getAbsTLWH = function(id, tmplVars, contTLWH, adPositioning)
	{
		function pcToPx(pc, widthPX)
		{
			var v = parseFloat(pc);
			return Math.round(v * widthPX/100);
		}

		if(!tmplVars.of || id == tmplVars.of) // no lockto (lib) or at the root, get the tlwh of the page
		{
			//console.log("Extending page - ", contTLWH);
			var containerTLWH = $.extend([], contTLWH); 
			//console.log("    Container at root:", id , tmplVars.of, containerTLWH, contTLWH);
		}
		else // not the root, recurse and build up the position.
		{
			var containerTLWH = $.extend([], contTLWH);
			var parentObj = widget.get(tmplVars.of);
			if (parentObj)
			{
				containerTLWH = widget._getAbsTLWH(tmplVars.of, parentObj, contTLWH, false);
			}
			//console.log("    Container:", containerTLWH, contTLWH, parentObj);
		}

		var tlwh2, tlwh3;

		//console.log("  Segment data", tmplVars.seg , tmplVars.segments , tmplVars.tlwh[2] , tmplVars.tlwh[3] );
		
		var hasMargin = Boolean(tmplVars.segment && parentObj && parentObj.sp);
		var marginH = hasMargin ? parentObj.sp[0] + parentObj.sp[3] : 0;
		var marginV = hasMargin ? parentObj.sp[1] + parentObj.sp[2] : 0;

		// this not working maybe?
		if ((tmplVars.seg || tmplVars.segments) && (tmplVars.tlwh[2] == 'a' || tmplVars.tlwh[3] == 'a'))
		{
			var segRootTlwh = widget._getSegmentRootTLWH(id, tmplVars); // needs to handle % i suspect.
			tlwh2 = segRootTlwh[2];
			tlwh3 = segRootTlwh[3];
			
			//console.log("  segRootTlwh", segRootTlwh);
		}
		else
		{
			// width and height first - needed to be able to position based on width if % positioned.
			var tlwh2 = (tmplVars.tlwh[2] === "a") ? "100%" : tmplVars.tlwh[2]; // "a" case
			var tlwh3 = (tmplVars.tlwh[3] === "a") ? "100%" : tmplVars.tlwh[3]; // "a" case

			//console.log("  tlwh2tlwh3", [tlwh2, tlwh3], [containerTLWH[2], tmplVars.tlwh[2], containerTLWH[2]], [containerTLWH[3], tmplVars.tlwh[3], containerTLWH[3]]);
		}

		tlwh2 = (typeof(tlwh2) === "string") ? pcToPx(tlwh2, containerTLWH[2] - marginH) : tlwh2;
		tlwh3 = (typeof(tlwh3) === "string") ? pcToPx(tlwh3, containerTLWH[3] - marginV) : tlwh3;

		// top and left - function me and call twice?
		var offsetT = (adPositioning) ? adPositioning[0] : tmplVars.tlwh[0];  
		var offsetL = (adPositioning) ? adPositioning[1] : tmplVars.tlwh[1];
			
		var t1 = (typeof(offsetT) === "string") ? pcToPx(offsetT, containerTLWH[3] - marginV) : offsetT; //  - pcToPx(offsetT, tlwh3)
		var t2 = (typeof(offsetL) === "string") ? pcToPx(offsetL, containerTLWH[2] - marginH) : offsetL; // - pcToPx(offsetL, tlwh2)
			
		var ca = tmplVars.ca || "tl";// backward compatibility.
			
		try
		{		
			// TODO: these 4 lines should be a switch.
			var tlwh0 = (ca[0] == 'b') ? containerTLWH[3] - tlwh3 - t1 : t1; // top or bottom align
			var tlwh1 = (ca[1] == 'r') ? containerTLWH[2] - tlwh2 - t2 : t2; // left or right align
		}
		catch(e)
		{
			//console.log(e, tmplVars, containerTLWH, t1, t2);
			var tlwh0 = 0;
			var tlwh1 = 0;
		}
		
		
		tlwh0 = (ca[0] == 'c') ? t1 + containerTLWH[3]/2 - tlwh3/2 : tlwh0; // top or bottom align 
		tlwh1 = (ca[1] == 'c') ? t2 + containerTLWH[2]/2 - tlwh2/2 : tlwh1; // left or right align
								
		tlwh0 += containerTLWH[0]; // offset from parent
		tlwh1 += containerTLWH[1];

		return [ Math.round(tlwh0),Math.round(tlwh1),Math.round(tlwh2),Math.round(tlwh3)];
	};
	
	
	// draws the canvas/image portion of any widget. el is <img> or <canvas>
	// changes now mean this function is misnamed!
	widget._drawCanvasOrImage = function(widgEl, tmplVars)
	{
		//console.log('_drawCanvasOrImage: ', widgEl, tmplVars);
		if (!tmplVars.includeCanvasOrImage){return false;}
		
		var wh = {width: tmplVars.absTLWH[2], height: tmplVars.absTLWH[3]};
		var $canv = $("<canvas>").attr(wh); // .css(wh)
		var ctx = $canv[0].getContext("2d");
		widget._paintCanvas(widgEl, ctx, tmplVars);

		return true;
	};

	//widget._drawImageUpload = function(widgEl, ctx, tmplVars, wh)
	widget._drawImageUpload = function(widgEl, tmplVars)
	{
		var wh = {width: tmplVars.absTLWH[2], height: tmplVars.absTLWH[3]};
		var canvas = widgEl.find("canvas");
		var destCanv = canvas.size() > 0 ? canvas : $("<canvas/>");
		destCanv.attr(wh); // test remove jumpiness .css(wh)
		var ctx = destCanv[0].getContext('2d');

		function imageLoad() // have img
		{
			// old image fix for library images.
			if(!tmplVars.tlwh[2] || !tmplVars.tlwh[3])
			{
				//console.log("img dimensions", tmplVars.tlwh[2], tmplVars.tlwh[3], img.width, img.height);
				tmplVars.tlwh[2] = img.width;
				tmplVars.tlwh[3] = img.height;
				widgEl.css({width:tmplVars.tlwh[2], height:tmplVars.tlwh[3]});
				$(ctx.canvas).attr({width:tmplVars.tlwh[2], height:tmplVars.tlwh[3]});
				widget.scale( widgEl.closest(".widgetParts"), tmplVars);
			}
			ctx.drawImage(img, 0, 0, tmplVars.tlwh[2], tmplVars.tlwh[3]);
			
			img.onload = null;
			img.onerror = null;
            img.src = ''; // this "helps" Safari remove image from memory
		}

		function errorLoading()
		{
			if(this.src.indexOf('/data/img') === -1) {
				var fallbackImg = new Image();
				//fallbackImg.crossOrigin = 'Anonymous';
				fallbackImg.src = getImageData(false);
				fallbackImg.onload = imageLoad;
				img = fallbackImg;
				fallbackImg.onerror = function() {
					$(ctx.canvas).addClass("failureImage");
					ctx.font = "32pt Arial";
					ctx.fillText("Image", 35, 50);
					ctx.fillText("not found", 10, 115);
				};
				//this.src = getImageData(false);
			} else {
				//TODO: Draw text according to the available space
				$(ctx.canvas).addClass("failureImage");
				ctx.font = "32pt Arial";
				ctx.fillText("Image", 35, 50);
				ctx.fillText("not found", 10, 115);
				//console.log("Unable to draw image.");
			}

            this.onerror = null;

		}

		function errorLoadingImage()
		{

            if(this.src.indexOf('/data/img') === -1) {
				delete this.crossOrigin;
				this.removeAttribute('crossorigin');
				this.src = getImageData(false);
			} else {
				errorLoading.apply(this, arguments);
				widget._convertCanvasToImg($(ctx.canvas), widgEl.find("img"), tmplVars);
			}

            this.onerror = null;
		}

		function getImageData(tryFromCloud)
		{
			var uploadObj = storage.get(tmplVars.data);
			var response = tmplVars.data || false;
			if(response && response.substr(0, 5) != 'data:')
			{
				if(tryFromCloud && (!uploadObj || !uploadObj.storage || uploadObj.storage == 'cloud') ) response = imgCloudUrl + tmplVars.data + '.png';
				else response = ajax.apiObjectUrl('img', tmplVars.data); // download the image.
			}
			else if(tmplVars.id)
			{
				if(tryFromCloud && (!uploadObj || !uploadObj.storage || uploadObj.storage == 'cloud') ) response = imgCloudUrl + tmplVars.id + '.png';
				else response = ajax.apiObjectUrl('img', tmplVars.id);
			}
			return response || errorLoading();
		}

        //when image is resized manually the images is not loaded to prevent latency
        if( ( canvas.length || widgEl.find('img') ) && tmplVars.simpleUploadResize) {
            return;
        }

		var url = getImageData(true);
		if(tmplVars.useCanvas) // When canvas is required, load the image and draw it in the canvas
		{
			var img = new Image();
			img.onload = imageLoad;
			img.onerror = errorLoading;
			img.src = url;
		}
		else
		{
			var $img = widgEl.find("img");
			if( $img.get(0).src.indexOf('/data/img') !== -1 ) url = getImageData(false);
			$img.get(0).onerror = errorLoadingImage;
			$img.get(0).onload = function(id) {
				if( window.uploadsCache && !window.uploadsCache[id] ) {
					//console.log('loaded the image: ', this);
					if(!project.uploadCanvas) project.uploadCanvas = document.createElement('canvas');
					project.uploadCanvas.width = this.naturalWidth;
					project.uploadCanvas.height = this.naturalHeight;
					project.uploadCanvasCtx = project.uploadCanvas.getContext('2d');
					project.uploadCanvasCtx.drawImage(this, 0, 0);
					window.uploadsCache[id] = project.uploadCanvas.toDataURL('image/png');
					dbStorage.set('uploads', {id: id, data: window.uploadsCache[id]}/*, function() {
						//console.log('upload saved...');
					}*/);
				}

			}.bind($img.get(0), tmplVars.data);

			if(window.uploadsCache && tmplVars.data && window.uploadsCache[tmplVars.data]) {
				$img.get(0).src = uploadsCache[tmplVars.data];
			} else {
				if(url.indexOf('data/img/') !== -1) {
					$img.get(0).crossOrigin = true;
				}
				$img.get(0).src = url;
			}
		}
	}

	// Converts a canvas to an image.
	widget._convertCanvasToImg = function($canv, $img, tmplVars)
	{
		function setImageData()
		{
			var imgData =  $canv[0].toDataURL('image/png');
			if (imgData != 'data:,') // let it be blank?
			{
				$img.attr('src', imgData);
			}
		}
		/*
		if (tmplVars.i || tmplVars.upload == 'y') // delayed for images.
		{
			function canvasChange()
			{
				setImageData();
				$img.data('canvas', null); // now can go to garbage
			}
			
			//console.log("Not tested - callback after image load.");
			$img.data('canvas',  $canv); // to prevent from being garbage-collected
			$canv.onchange = canvasChange;
		}
		else
		{
			setImageData();
		}
		*/
		setImageData();
	}

	// context, storageObj, mode, width/height.
	widget._paintCanvas = function(widgEl, c, tmplVars)
	{		
		var draw = 
		{
			blur : function () {
				//BD: second condition disables the blur effect on html export in chrome/safari due to its harsh security limitations
                if (tmplVars.blur && !((browserDetect.browser === 'Chrome' || browserDetect.browser === 'Safari') && document.domain === '')) {
                    var widgetElement = widgEl[0],
                        pages,
                        pageId;

                    if (window.g_preview || !widgetsCache[tmplVars.id]) {
                        pages = storage.get(window.g_preview || project.get('id')).pages;

                        for (var i = 0, len = pages.length; i < len; i++) {
                            var p = pages[i];

                            if (storage.get(p).widgets.indexOf(tmplVars.id) !== -1) {
                                pageId = p;
                                break;
                            }
                        }
                    pageId = pageId || document.querySelector('.canvasObject.active').id;
                    }
                    else {
                        pageId = widgetsCache[tmplVars.id].pageId;
                    }

                    widget.renderBlurLayer(widgetElement.id, pageId, function (imgData) {
	                    widget.blurLayers[widgetElement.id] = imgData;
	                    widget.setBlurBG(widgetElement);
                    });

					if(widget.blurLayers[widgetElement.id]) widget.setBlurBG(widgetElement);
                }
			},

			background : function()// top left is relative to the canvas, for things like shadows etc.
			{
				c.save();
				
				function drawStriped()
				{
					var colors = (tmplVars.bgc) ? tmplVars.bgc : ['#CAD1D7', '#C4CBD3'];
					
					var distances = [5, 2];
					var orientation = "v";
					if(tmplVars.bgd)
					{
						orientation = tmplVars.bgd[0];
						distances = [tmplVars.bgd[1], tmplVars.bgd[2]];
					}

					c.fillStyle = colors[1];
					c.fill();
					c.fillStyle = colors[0];
					
					if(orientation == "v") 
					{
						for(var i = distances[0] ; i< width; )
						{	  
							c.fillRect (i, 0, distances[1], height);		
							i += distances[0];
						}
					}
					else
					{
						for(var i = distances[0] ; i< height; )
						{	  
							c.fillRect (0, i, width, distances[1]);		
							i += distances[0];
						}	
					}	
				}
				
				if(!width) width = 0; // fix for if wh gets corrupted!
				if(!height) height = 0; // fix for if wh gets corrupted!
				
				if(tmplVars.bg == 'c')	// plain colour.
				{
					c.fillStyle = tmplVars.bgc[0];
					c.fill();
				}
				else if(tmplVars.bg == 's')	// striped
				{
					drawStriped();
				}
				else if(tmplVars.bg == 'l')		// Linear Gradient top to bottom
				{
					g = c.createLinearGradient(0, 0, 0, height );  
					draw._gradient(g, c, tmplVars);
				}
				else if(tmplVars.bg == 'lrl')		// Linear right left.
				{
					g = c.createLinearGradient(0, 0, width, 0 );  
					draw._gradient(g, c, tmplVars);
				}
				else if(tmplVars.bg == 'ld')		// Linear Gradient top left to bottom right
				{
					g = c.createLinearGradient(0, 0, width, height );  
					draw._gradient(g, c, tmplVars);
				}
				else if(tmplVars.bg == 'ld2')		// Linear Gradient top right to bottom left
				{
					g = c.createLinearGradient(width, 0, 0, height );  
					draw._gradient(g, c, tmplVars);
				}
				else if(tmplVars.bg == 'r')		// Radial gradient.
				{
					g = c.createRadialGradient(width/2, height/2, 0.0, width/2, height/2, height/2);
					draw._gradient(g, c, tmplVars); 
				}
					
				c.restore();
			},
			
			border : function(c, tmplVars, width, height)
			{
				var top = 0, left = 0;
				c.lineWidth = (typeof adjustedBorderWidth) === 'number'
					? adjustedBorderWidth
					: borderWidth;
				c.strokeStyle = tmplVars.b[1];	    // rounding is b2.
				c.stroke();
				c.save()
				//console.log(c, tmplVars, width, height, tmplVars.b);
			},

			// draw a path of a certain type.
			path : function(c, type, rounding, top, left, width, height, borderWidth, tmplVars) // TODO: Just pass the object, getting mad...
			{
				c.beginPath();
				
				// subtract any border
				var t = top + Math.floor(borderWidth/2);
				var l = left + Math.floor(borderWidth/2);
				var b = top + height - Math.floor(borderWidth/2);
				var r = left + width - Math.floor(borderWidth/2);

				//subract any shadow
				if(tmplVars.sh && tmplVars.sh[3] && tmplVars.sh[2]) // reduce the widget size by the size of the blur. TODO: in the right direction.
				{
					t+= Math.floor(tmplVars.sh[3] - tmplVars.sh[2]/2);
					l+= Math.floor(tmplVars.sh[3] - tmplVars.sh[2]/2);
					b-= Math.floor(tmplVars.sh[3] + tmplVars.sh[2]/2);
					r-= Math.floor(tmplVars.sh[3] + tmplVars.sh[2]/2);
				}
				
				if ($.isArray(rounding)) // make sure all 4 values are set
				{
					for (var idx = 0; idx < 4; idx++)
					{
						rounding[idx] = rounding[idx] || 0;
					}
				}
				else
				{
					rounding = [rounding, rounding, rounding, rounding]; // rounding rounding rounding
				}
				
				if(type == "sq")
				{
					// Limit the raduis to half of the shortest dimension
					var min = Math.min((r - l) / 2, (b - t) / 2);
					
					rounding[0] = Math.min(rounding[0], min);
					rounding[1] = Math.min(rounding[1], min);
					rounding[2] = Math.min(rounding[2], min);
					rounding[3] = Math.min(rounding[3], min);
                
                    c.moveTo(l+rounding[0], t),
                    c.lineTo(r-rounding[1], t),
                    c.quadraticCurveTo(r, t, r, t+rounding[1]),
                    c.lineTo(r, b-rounding[2]),
                    c.quadraticCurveTo(r, b, r-rounding[2], b),
                    c.lineTo(l+rounding[3], b),
                    c.quadraticCurveTo(l, b, l, b-rounding[3]),
                    c.lineTo(l, t+rounding[0]),
                    c.quadraticCurveTo(l, t, l+rounding[0], t)
	
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
					
				}
				if(type == "arrU")
				{
					// proportionality constant for the VERTICAL arrow
					var arrowProportion =
							widgHeight <= arrowHeadHeight? (b-t)/2: (r-l)+(5/4),
						widgHeight = b-t,
						arrowHeadHeight = (r-l)*1.5;

					var points = [
						utils.Vector((l+r)/2, t+borderWidth),
						utils.Vector(r-(borderWidth/2), t+arrowProportion),
						utils.Vector((l+r)*0.65, t+arrowProportion),
						utils.Vector((l+r)*0.65, b),
						utils.Vector((l+r)*0.35, b),
						utils.Vector((l+r)*0.35, t+arrowProportion),
						utils.Vector(l+(borderWidth/2), t+arrowProportion)
					];
					
					utils.drawVectors(c, points, rounding);
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
				}
				if(type == "arrD")
				{
					var arrowProportion = (r-l)+(5/4);
					var widgHeight = b-t;
					var arrowHeadHeight = (r-l)*1.5;
					if(widgHeight <= arrowHeadHeight)
					{
						var arrowProportion = (b-t)/2;
					}
					var points = [
                        utils.Vector((l+r)/2, b-borderWidth),
                        utils.Vector(r-(borderWidth/2), b-arrowProportion),
                        utils.Vector((l+r)*0.65, b-arrowProportion),
                        utils.Vector((l+r)*0.65, t),
                        utils.Vector((l+r)*0.35, t),
                        utils.Vector((l+r)*0.35, b-arrowProportion),
                        utils.Vector(l+(borderWidth/2), b-arrowProportion),
                        utils.Vector((l+r)/2, b)
                    ];

                    utils.drawVectors(c, points, rounding);
					
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
				}
				if(type == "arrR")
				{
					// drawing shape starts at the tip of the arrowhead and moves in a clockwise direction
					var arrowProportion = (b-t)+(5/4);
					var widgWidth = r-l;
					var arrowHeadWidth = (b-t)*1.5;
					if(widgWidth <= arrowHeadWidth)
					{
						var arrowProportion = (r-l)/2;
					}
					var points = [
                        utils.Vector(r-borderWidth, (t+b)/2),
                        utils.Vector(r-arrowProportion, b-(borderWidth/2)),
                        utils.Vector(r-arrowProportion, (t+b)*0.65),
                        utils.Vector(l, (t+b)*0.65),
                        utils.Vector(l, (t+b)*0.35),
                        utils.Vector(r-arrowProportion, (t+b)*0.35),
                        utils.Vector(r-arrowProportion, t+(borderWidth/2)),
                        utils.Vector(r-borderWidth, (t+b)/2),
                    ];

                    utils.drawVectors(c, points, rounding);
					
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
				}
				if(type == "arrL")
				{
					// drawing shape starts at the tip of the arrowhead and moves in a clockwise direction
					var arrowProportion = (b-t)+(5/4);
					var widgWidth = r-l;
					var arrowHeadWidth = (b-t)*1.5;
					if(widgWidth <= arrowHeadWidth)
					{
						var arrowProportion = (r-l)/2;
					}
					var points = [
                        utils.Vector(l+borderWidth, (t+b)/2),
                        utils.Vector(l+arrowProportion, b-(borderWidth/2)),
                        utils.Vector(l+arrowProportion, (t+b)*0.65),
                        utils.Vector(r, (t+b)*0.65),
                        utils.Vector(r, (t+b)*0.35),
                        utils.Vector(l+arrowProportion, (t+b)*0.35),
                        utils.Vector(l+arrowProportion, t+(borderWidth/2)),
                        utils.Vector(l+borderWidth, (t+b)/2)
                    ];

                    utils.drawVectors(c, points, rounding);
					
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
				}
				if(type == "image")
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
					// diagonal line
					c.moveTo(l, t);
					c.lineTo(l+1, t);
					c.lineTo(r, b-1);
					c.lineTo(r, b);
					c.lineTo(r-1, b);
					c.lineTo(l, t-1);
					c.lineTo(l, t);
				
					// diagonal line
					c.moveTo(r-1, t);
					c.lineTo(r, t);
					c.lineTo(r, t-1);
					c.lineTo(l+1, b);
					c.lineTo(l, b);
					c.lineTo(l, b-1);
					c.lineTo(r-1, t);
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);	
				}
				else if(type == "tri") // does not support rounding.
				{
                    var points = [
                        utils.Vector(l, t),
                        utils.Vector(r, t),
                        utils.Vector(r, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "trR") // does not support rounding.
				{
                    var points = [
                        utils.Vector(l, t),
                        utils.Vector(r, t),
                        utils.Vector(l, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "ttrL")
				{
                    var points = [
                        utils.Vector(r, t),
                        utils.Vector(r, b),
                        utils.Vector(l, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "ttrR")
				{
                    var points = [
                        utils.Vector(l, t),
                        utils.Vector(r, b),
                        utils.Vector(l, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "triU") 
				{
                    var points = [
                        utils.Vector((l+r)/2, t),
                        utils.Vector(r, b),
                        utils.Vector(l, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "triD") 
				{
                    var points = [
                        utils.Vector(l, t),
                        utils.Vector(r, t),
                        utils.Vector((l+r)/2, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "triR") 
				{
                    var points = [
                        utils.Vector(l, t),
                        utils.Vector(r, (t+b)/2),
                        utils.Vector(l, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "triL") 
				{
                    var points = [
                        utils.Vector(r, t),
                        utils.Vector(l, (t+b)/2),
                        utils.Vector(r, b)
                    ];

                    utils.drawVectors(c, points, rounding);
				}
				else if(type == "ribU") // ribbon
				{
					c.moveTo(l, t);
					c.lineTo((l+r)/2, (t+b)/4);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "ribD") // ribbon
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo((l+r)/2, (3/4)*(t+b));
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "flagR") // flag
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo((4/5)*(l+r), (t+b)/2);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "flagL") // flag
				{
					c.moveTo(l, t);
					c.lineTo((1/5)*(l+r), (t+b)/2);
					c.lineTo(l, b);
					c.lineTo(r, b);
					c.lineTo(r, t);
					c.lineTo(l, t);
				}
				else if(type == "houseU") // house/envelope shape
				{
					var points = [
						utils.Vector(r, (3/7)*(t+b)),
						utils.Vector(r, b),
						utils.Vector(l, b),
						utils.Vector(l, (3/7)*(t+b)),
						utils.Vector((l+r)/2, t)
					];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "houseD") 
				{
					var points = [
						utils.Vector((l + r) / 2, b),
						utils.Vector(r, (4 / 7) * (t + b)),
						utils.Vector(r, t),
						utils.Vector(l, t),
						utils.Vector(l, (4 / 7) * (t + b))
					];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "oct") 
				{
					var _21_72 = 21 /72,
						_51_72 = 51 / 72,
						horiz  = l + r,
						vert   = t + b,
						points = [
							utils.Vector( _21_72 * horiz, t),
							utils.Vector( _51_72 * horiz, t),
							utils.Vector( r, _21_72 * vert ),
							utils.Vector( r, _51_72 * vert ),
							utils.Vector( _51_72 * horiz, b),
							utils.Vector( _21_72 * horiz, b),
							utils.Vector( l, _51_72 * vert ),
							utils.Vector( l, _21_72 * vert )
						];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "star")
				{
					var points = [
							utils.Vector((l+r)/2, t),
							utils.Vector((33/54)*(l+r), (39/102)*(b+t)),
							utils.Vector(r, (39/102)*(b+t)),
							utils.Vector((75/108)*(l+r), (63/102)*(b+t)),
							utils.Vector((87/108)*(l+r), b),
							utils.Vector((l+r)/2, (39/51)*(b+t)),
							utils.Vector((21/108)*(l+r), b),
							utils.Vector((33/108)*(l+r), (63/102)*(b+t)),
							utils.Vector(l, (39/102)*(b+t)),
							utils.Vector((21/54)*(l+r), (39/102)*(b+t))
						];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "pgL") 
				{
					var points = [
						utils.Vector(l, b),
						utils.Vector(r, b),
						utils.Vector(r, t),
						utils.Vector((l+r)/3, t),
						utils.Vector(l, (t+b)/4)
					];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "pgR") 
				{
					var points = [
						utils.Vector(r, b),
						utils.Vector(l, b),
						utils.Vector(l, t),
						utils.Vector((2/3)*(l+r), t),
						utils.Vector(r, (t+b)/4)
					];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "pointrL") 
				{
					var points = [
						utils.Vector(l, t),
						utils.Vector(r, t),
						utils.Vector((5/7)*(l+r), (3/7)*(t+b)),
						utils.Vector((5/7)*(l+r), b),
						utils.Vector(l, t)
					];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "pointrR") 
				{
					var points = [
						utils.Vector(l, t),
						utils.Vector(r, t),
						utils.Vector((2/7)*(l+r), b),
						utils.Vector((2/7)*(l+r), (3/7)*(t+b)),
						utils.Vector(l, t)
					];

					utils.drawVectors(c, points, rounding);
				}
				else if(type == "ldL") 
				{
					c.moveTo(l, t);
					c.lineTo(l+2, t);
					c.lineTo(r, b);
					c.lineTo(r-2, b);
					c.lineTo(l, t);
				}
				else if(type == "ldR") 
				{
					c.moveTo(r, t);
					c.lineTo(r-2, t);
					c.lineTo(l, b);
					c.lineTo(l+2, b);
					c.lineTo(r, t);
				}
				else if(type == "dropD") 
				{
					c.moveTo((l+r)/2, t);       
					c.lineTo((l+r)/6, (t+b)/2); 
					c.bezierCurveTo(l-((l+r)*(1.5/6)), b+((b+t)/6.2),  r+((l+r)*(1.5/6)), b+((b+t)/6.2),  (l+r)*(5/6), (t+b)/2);
					c.lineTo((l+r)/2, t);
				}
				
				else if(type == "dropU") 
				{
					c.moveTo((l+r)/2, b);       
					c.lineTo((l+r)/6, (t+b)/2); 
					c.bezierCurveTo(l-((l+r)*(1.5/6)), t-((b+t)/6.2),  r+((l+r)*(1.5/6)), t-((b+t)/6.2),  (l+r)*(5/6), (t+b)/2);
					c.lineTo((l+r)/2, b);
					
				}
				else if(type == "oval") 
				{
					c.moveTo(l, (b+t)/2);       
					c.bezierCurveTo((l+r)*(1/4), t-((b+t)/7),  (l+r)*(3/4), t-((b+t)/7),  r, (b+t)/2);
					c.bezierCurveTo((l+r)*(3/4), b+((b+t)/7), (l+r)*(1/4), b+((b+t)/7),  l, (b+t)/2);
					
				}
				else if(type == "cloud") 
				{
					c.moveTo((l+r)*(1.5/9), b);       
					c.bezierCurveTo(l, b,  l, (t+b)*(7/11),  (l+r)*(1.6/9), (b+t)*(7/11));
					c.bezierCurveTo((l+r)/9, (b+t)/3, (l+r)/3, (b+t)/6.3,  (l+r)*(4/9), (b+t)/3.2);
					c.bezierCurveTo((l+r)*(4.5/9), t, (l+r)*(7.4/9), t,  (l+r)*(7.3/9), (b+t)/2);
					c.bezierCurveTo(r, (b+t)/2, r, b,  (l+r)*(7.7/9), b);
					c.lineTo((l+r)*(1.5/9), b);
					
				}
				else if(type == "person") 
				{
					c.moveTo(l, b);       
					c.bezierCurveTo((l+r)/16, (t+b)*(11/14),  (l+r)*(3/16), (t+b)*(10/14),  (l+r)*(6/16), (b+t)*(9/14));
					c.bezierCurveTo((l+r)*(2.5/16), (t+b)*(4/7), (l+r)*(2.5/16), t,  (l+r)/2, t);
					c.bezierCurveTo((l+r)*(13.5/16), t, (l+r)*(13.5/16), (t+b)*(4/7),  (l+r)*(10/16), (b+t)*(9/14));
					c.bezierCurveTo((l+r)*(13/16), (t+b)*(10/14),  (l+r)*(15/16), (t+b)*(11/14),  r, b);
					c.lineTo(l, b);
					
				}
				else if(type == "thumbsU") 
				{
					c.moveTo(l, (t+b)*(16/17));
					c.lineTo(l, (t+b)*(15/34));
					c.bezierCurveTo((l+r)*(2/15), (t+b)*(7/17),  (l+r)*(9/30), (t+b)*(4/17),  (l+r)/3, (b+t)*(3/34));
					c.bezierCurveTo((l+r)*(5.2/15), t, (l+r)*(9/15), t,  (l+r)*(8.5/15), (t+b)*(2/17));
					c.lineTo((l+r)*(7/15), (t+b)*(11/34));
					c.bezierCurveTo((l+r)*(9/15), (t+b)*(13/34), (l+r)*(11/15), (t+b)*(13/34),  (l+r)*(12/15), (t+b)*(13/34));
					c.bezierCurveTo(r, (t+b)*(13/34),  r, (t+b)*(19/34), (l+r)*(12/15), (t+b)*(19/34) ); // finger
					c.bezierCurveTo((l+r)*(14/15), (t+b)*(19/34),  (l+r)*(27/30), (t+b)*(12/17), (l+r)*(23/30), (t+b)*(12/17)); // finger1
					c.bezierCurveTo((l+r)*(13/15), (t+b)*(12/17),  (l+r)*(25/30), (t+b)*(29/34), (l+r)*(11/15), (t+b)*(29/34)); // finger2
					c.bezierCurveTo((l+r)*(25/30), (t+b)*(29/34),  (l+r)*(12/15), b, (l+r)*(8.5/15), b); // finger3
					c.bezierCurveTo((l+r)/2, b,  (l+r)/5, b, l, (t+b)*(16/17)); // close the shape
					
				}
				else if(type == "thumbsD") 
				{
					c.moveTo(l, (t+b)/17);
					c.lineTo(l, (t+b)*(19/34));
					c.bezierCurveTo((l+r)*(2/15), (t+b)*(10/17),  (l+r)*(9/30), (t+b)*(13/17),  (l+r)/3, (b+t)*(31/34));
					c.bezierCurveTo((l+r)*(5.2/15), b, (l+r)*(9/15), b,  (l+r)*(8.5/15), (t+b)*(15/17));
					c.lineTo((l+r)*(7/15), (t+b)*(23/34));
					c.bezierCurveTo((l+r)*(9/15), (t+b)*(21/34), (l+r)*(11/15), (t+b)*(21/34),  (l+r)*(12/15), (t+b)*(21/34));
					c.bezierCurveTo(r, (t+b)*(21/34),  r, (t+b)*(15/34), (l+r)*(12/15), (t+b)*(15/34) ); // finger
					c.bezierCurveTo((l+r)*(14/15), (t+b)*(15/34),  (l+r)*(27/30), (t+b)*(5/17), (l+r)*(23/30), (t+b)*(5/17)); // finger1
					c.bezierCurveTo((l+r)*(13/15), (t+b)*(5/17),  (l+r)*(25/30), (t+b)*(5/34), (l+r)*(11/15), (t+b)*(5/34)); // finger2
					c.bezierCurveTo((l+r)*(25/30), (t+b)*(5/34),  (l+r)*(12/15), t, (l+r)*(8.5/15), t); // finger3
					c.bezierCurveTo((l+r)/2, t,  (l+r)/5, t, l, (t+b)/17); // close the shape
				}
				else if(type == "arcL") 
				{
					var width = r-l; //this arc is split into two semicircles
					var height = b-t;
					var radius = (height >= (width * 2)) ? width : height / 2;
			
					c.moveTo(l+radius, t);
					c.arcTo(l, t, l, t+radius, radius);
					c.arcTo(l, t+(2*radius), l+radius,t+(2*radius), radius);
					c.lineTo(l+radius,t);
				}
				else if(type == "arcR")
				{
					var width = r-l; //this arc is split into two semicircles
					var height = b-t;
					var radius = (height >= (width * 2)) ? width : height / 2;
					
					c.moveTo(l, t);
					c.arcTo(l+radius, t, l+radius, t+radius, radius);
					c.arcTo(l+radius, t+(2*radius), l,t+(2*radius), radius);
					c.lineTo(l, t);
				}
				else if(type == "arcU")
				{
					var width = r-l; //this arc is split into two semicircles
					var height = b-t;
					var radius = (width >= (height * 2)) ? height : width / 2;
					
					c.moveTo(l, t+radius);
					c.arcTo(l, t, l+radius, t, radius);
					c.arcTo(l+(2*radius), t, l+(2*radius),t+(2*radius), radius);
					c.lineTo(l, t+radius);
				}
				else if(type == "arcD")
				{
					var width = r-l; //this arc is split into two semicircles
					var height = b-t;
					var radius = (width >= (height * 2)) ? height : width / 2;
					
					c.moveTo(l, t);
					c.arcTo(l, t+radius, l+radius, t+radius, radius);
					c.arcTo(l+(2*radius), t+radius, l+(2*radius),t, radius);
					c.lineTo(l, t);
				}
				else if(type == "folder")
				{
					var ro = rounding[0],
						width = r - t,
						height = b - t,
						slopeEnd = {
							x: (3/8)*(r+l),
							y: (2/15)*(t+b)
						},
						slopeTop = {
							x: (5/16)*(r+l),
							y: t
						},
						midSlope = {
							x: slopeTop.x + (slopeEnd.x - slopeTop.x) / 2,
							y: t + (slopeEnd.y - t) / 2

						},
						halfSlope = Math.sqrt(midSlope.x * midSlope.x + midSlope.y * midSlope.y);

					rounding[1] = Math.min(ro, (width - slopeEnd.x) / 2, height / 2);	   // 1 - top right
					rounding[2] = Math.min(ro, (b - slopeEnd.y) / 2, (slopeEnd.x - t) / 2); // 2 - bottom right
					rounding[4] = Math.min(ro, height / 2, (slopeTop.x - l) / 2),		   // 4 - top left

					rounding[1] = rounding [4] = Math.min(rounding[1], rounding[4]);
					rounding[3] = Math.min(rounding[4], rounding[2]);			 			// 3 - bottom left
					rounding[0] = Math.min(ro, halfSlope, rounding[4]);		   			// 0 - end of slope
					rounding[5] = rounding[0];				   								// 5 - top of slope

					c.moveTo(slopeEnd.x + rounding[0], slopeEnd.y);
					c.lineTo(r-rounding[1], slopeEnd.y);
					c.quadraticCurveTo(r, slopeEnd.y, r, slopeEnd.y + rounding[1]);
					c.lineTo(r, b-rounding[2]);
					c.quadraticCurveTo(r, b, r-rounding[2], b);
					c.lineTo(l+rounding[3], b);
					c.quadraticCurveTo(l, b, l, b-rounding[3]);
					c.lineTo(l, t+rounding[4]);
					c.quadraticCurveTo(l, t, l+rounding[4], t);

					// start of tab slope radius
					c.lineTo(slopeTop.x - rounding[5], slopeTop.y);

					// should do something like curve(slope, midSlope - rounding)
					c.quadraticCurveTo(slopeTop.x, slopeTop.y, midSlope.x, midSlope.y);
					c.quadraticCurveTo(slopeEnd.x, slopeEnd.y, slopeEnd.x + rounding[0], slopeEnd.y);

					/*
					c.moveTo((3/8)*(r+l), (2/15)*(t+b));
					c.lineTo(r-rounding[1], (2/15)*(t+b));
					c.quadraticCurveTo(r, (2/15)*(t+b), r, ((2/15)*(t+b))+rounding[1]);
					c.lineTo(r, b-rounding[2]);
					c.quadraticCurveTo(r, b, r-rounding[2], b);
					c.lineTo(l+rounding[3], b);
					c.quadraticCurveTo(l, b, l, b-rounding[3]);
					c.lineTo(l, t+rounding[0]);
					c.quadraticCurveTo(l, t, l+rounding[0], t);
					c.lineTo((5/16)*(r+l), t);
					c.lineTo((3/8)*(r+l), (2/15)*(t+b));
					*/
				}
				if(type == "speechRight")
				{
					c.moveTo(r-17, b);
					c.lineTo(r-96, b-13);
					c.lineTo(l, b-13);
					c.lineTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b-13);
					c.lineTo(r-38, b-13);
					c.lineTo(r-17, b);
			
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
					
				}
				if(type == "speechLeft")
				{
					c.moveTo(l+17, b);
					c.lineTo(l+96, b-13);
					c.lineTo(r, b-13);
					c.lineTo(r, t);
					c.lineTo(l, t);
					c.lineTo(l, b-13);
					c.lineTo(l+38, b-13);
					c.lineTo(l+17, b);
			
					//console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
					
				}
				else if(type == "bubr")
				{
					right = width-1; 
					bottom = height-2; 
					tailSize = 7; // centralise
					
					if(tmplVars.b) // TODO: c/p in bubbL - merge
					{
						top = top + tmplVars.b[0]/2;
						left = left + tmplVars.b[0]/2; 
						right = right - tmplVars.b[0]/2; 
						bottom = bottom - tmplVars.b[0]/2; 
					}
					
					c.moveTo(right-tailSize, bottom-7); // right side before curve, give 10 pixels for the tail.
					c.lineTo(right-tailSize, top+rounding[1]);
					c.quadraticCurveTo(right-tailSize, top, right-rounding[1]-tailSize, top);
					c.lineTo(left+rounding[0], top);
					c.quadraticCurveTo(left, top, left, top+rounding[0]);
					c.lineTo(left, bottom-rounding[3]);
					c.quadraticCurveTo(left, bottom, left+rounding[3], bottom);
					c.lineTo(right-19, bottom);
					c.quadraticCurveTo(right-15,	   bottom-1, right-14,	   bottom-2); // bottom lead in to tail.
					c.quadraticCurveTo(right-7,		bottom+1, right-1,		bottom-2); // bottom of tail
					c.quadraticCurveTo(right-tailSize, bottom-3, right-tailSize, bottom-7); // top of tail.
				}
				else if(type == "bubl")
				{
					right = width-1; // doesnt account for borders!
					bottom = height-2; // doesnt account for borders!
					tailSize = 7; // centralise
					
					if(tmplVars.b)
					{
						top = top + tmplVars.b[0]/2;
						left = left + tmplVars.b[0]/2;
						right = right - tmplVars.b[0]/2;
						bottom = bottom - tmplVars.b[0]/2; 
					}	
					
					c.moveTo(right, bottom-rounding[2]); // bottom right line,
					c.lineTo(right, top+rounding[1]);	// right side line.
					c.quadraticCurveTo(right, top, right-rounding[1], top);
					c.lineTo(left+rounding[0]+tailSize, top); // top line
					c.quadraticCurveTo(left+tailSize, top, left+tailSize, top+rounding[0]);
					c.lineTo(left+tailSize, bottom-6); // left side line
					c.quadraticCurveTo(left+4,  bottom-1, left+1,  bottom-2); // top of tail.
					c.quadraticCurveTo(left+2,  bottom+2, left+13, bottom-2); // bottom of tail
					c.quadraticCurveTo(left+15, bottom,   left+19, bottom);   // bottom lead in to tail.
					c.lineTo(right-rounding[2], bottom);
					c.quadraticCurveTo(right, bottom, right, bottom-rounding[2]); // this is bottom left gets replaced.
				}
				else if (type == "arrowL" || type == "arrowR" || type == "arrowU" || type == "arrowD")
				{
					var aCurve = 2.0; 
					if(tmplVars.aCurve)
					{
						aCurve = tmplVars.aCurve;
					}
					
					var aSize = 12; 
					if(tmplVars.aSize)
					{
						aSize = tmplVars.aSize;
					}
					
					if(type == "arrowL")
					{
						c.moveTo(l+aSize, t);       //top left.
						c.lineTo(r-rounding[1], t); //top right
						c.quadraticCurveTo(r, t,  r, t+rounding[1]);
						c.lineTo(r, b-rounding[2]); // right line
						c.quadraticCurveTo(r, b, r-rounding[2], b);
						c.lineTo(l+aSize, b);       //bottom left.
						c.bezierCurveTo(l+aSize-aCurve, b, l, ((b+t)/2)+aCurve, l, (b+t)/2);
						c.bezierCurveTo(l, ((b+t)/2)-aCurve, aSize-aCurve, t, l+aSize, t);
					}
					else if(type == "arrowR")
					{
						c.moveTo(l+rounding[0], t); //top left.
						c.lineTo(r-aSize, t);       //top right
						c.bezierCurveTo(r-aSize+aCurve,t,   r,((t+b)/2)-aCurve, r, (t+b)/2);
						c.bezierCurveTo(r,((t+b)/2)+aCurve, r-aSize+aCurve,b,   r-aSize, b);
						c.lineTo(l+rounding[3], b);
						c.quadraticCurveTo(l, b, l, b-rounding[3]);
						c.lineTo(l, t+rounding[0]);
						c.quadraticCurveTo(l, t, l+rounding[0], t);
					}
					else if(type == "arrowD")
					{
						var aw = (tmplVars.aW) ? tmplVars.aW : aw;				
						var center = (l+r)/2;
						var aWidth = aw/2;
						
						c.moveTo(l+rounding[0], t); //top left.
						c.lineTo(r-rounding[1], t); //top right
						c.quadraticCurveTo(r, t, r, t+rounding[1]);
						c.lineTo(r, b-aSize-rounding[2]);
						c.quadraticCurveTo(r, b-aSize, r-rounding[2], b-aSize);
						
						c.lineTo(center+aWidth, b-aSize); // this is the bottom line 1
						c.lineTo(center, b);  // arrow right
						c.lineTo(center-aWidth, b-aSize);  // arrow left
						c.lineTo(l+rounding[3], b-aSize); // this is the bottom line 2
							
						c.quadraticCurveTo(l, b-aSize, l, b-aSize-rounding[3]);
						c.lineTo(l, t+rounding[0]);
						c.quadraticCurveTo(l,t, l+rounding[0], t);
					}	
					else if(type == "arrowU")
					{
						var aw = (tmplVars.aW) ? tmplVars.aW : 20;				
						var center = (l+r)/2;
						var aWidth = aw/2;
						
						c.moveTo(l+rounding[0], t+aSize); //top left.
						c.lineTo(center-aWidth, t+aSize); // top left line
						c.lineTo(center, t);  // arrow right
						c.lineTo(center+aWidth, t+aSize);  // arrow left
						c.lineTo(r-rounding[1], t+aSize); //top right
							
						c.quadraticCurveTo(r, t+aSize, r, t+aSize+rounding[1]); // top right corner
						c.lineTo(r, b-rounding[2]);
						c.quadraticCurveTo(r, b, r-rounding[2], b);// bottom right corner
						c.lineTo(l+rounding[2], b); // bottom line 
						
						c.quadraticCurveTo(l, b, l, b-rounding[3]); // bottom left 
						c.lineTo(l, t+aSize+rounding[0]);
						c.quadraticCurveTo(l,t+aSize, l+rounding[3], t+aSize); // top left
					}
				}
				else if (type == "c") {
					var x = width / 2,
						y = height / 2,
						shortestSide = Math.min(x, y),
						stroke = Math.min(borderWidth|0, shortestSide),
						radius = shortestSide - stroke / 2;

					if (radius < 0) {
						radius = 0;
					}

					adjustedBorderWidth = stroke;

					c.arc(x, y, radius, 0, Math.PI * 2, true); // x, y, radius, 
				}
				c.closePath();
			},
			
			// draws a gradient on the current path.
			_gradient : function (g, c, tmplVars)
			{
				var colors = ["#ffffff","#000000"];
				var stops = [0.00, 1.00];
				if(tmplVars.bgc && tmplVars.bgd)
				{
					colors = tmplVars.bgc;
					stops = tmplVars.bgd;
				}		
				
				for(var i = 0; i < colors.length && i < stops.length; i++)
				{
					try
					{
						g.addColorStop(stops[i], colors[i]);
					}
					catch(e)
					{
						//console.log("unable to add color stop to .", stops[i], colors[i], tmplVars.bgc, tmplVars.bgd);
					}
				}
				c.fillStyle = g;
				c.fill();
			},	

			_glaze : function (c, tmplVars)
			{	 
				var rounding = 5, 
					top = 2.0, 
					left=10, 
					width=tmplVars.absTLWH[2]-27, 
					height=10, 
					borderWidth=0,
					tailSize = 7; //TAILSIZE SAME AS ABOVE - ALSO EDIT. (or jsut fix properly)
				
				if(tmplVars.s == 'bubl') // TODO HACK: this just offsets by the 
				{ 
					left += tailSize;
				}

				draw.path(c, "sq", rounding, top, left, width, height, borderWidth, tmplVars);

				var g = c.createLinearGradient(0, top+height, 0, top);
				g.addColorStop(0.00, "rgba(231, 231, 231, 0.2)");
				g.addColorStop(0.59, "rgba(240, 240, 240, 0.25)");
				g.addColorStop(1.00, "rgba(249, 249, 249, 0.3)");
				c.fillStyle = g;
				c.fill();
				c.restore();	
			},

			_shadow : function (c, tmplVars)
			{		
				c.shadowColor = tmplVars.sh[0];
				c.shadowOffsetX = tmplVars.sh[1];
				c.shadowOffsetY = tmplVars.sh[2];
				c.shadowBlur = tmplVars.sh[3];
			},
			
			_effect : function (c, tmplVars)
			{
				var effects = tmplVars.fx;
				for(var i=0; i<effects.length; i++) {
					var singleEffect = effects[i];
					if(singleEffect[0] == 'dots') {
						var size = singleEffect[1];
						var hSpacing = singleEffect[2];
						var vSpacing = singleEffect[3];
						c.fillStyle = singleEffect[4];
						
						var widgWidth = tmplVars.absTLWH[2];
						var widgHeight = tmplVars.absTLWH[3];
						
						var tileWidth = size + hSpacing;
						var tileHeight = size + vSpacing;
						var horizontalTileNumber = parseInt(widgWidth / tileWidth) + 1;
						var verticalTileNumber = parseInt(widgHeight / tileHeight) + 1;
						var offset = 0;
						
						
						for(var j=0; j < verticalTileNumber; j++){
							offset = (offset) ? 0 : size;
							for(var k=0; k < horizontalTileNumber; k++){
								c.beginPath();
								c.arc((k * tileWidth) + offset,(j * tileHeight),size/2,0,2*Math.PI);
								c.closePath();
								c.fill();
							}
						}
					}
				}
			
				
			
			},

			_setImage : function(widgEl, c, tmplVars)
			{
				try
				{
					if (tmplVars.useCanvas)
					{
						var wh = {width: tmplVars.absTLWH[2], height: tmplVars.absTLWH[3]};
						var destCanv = widgEl.find("canvas").attr(wh); // .attr(wh)
						var destCtx = destCanv[0].getContext('2d');
						destCtx.drawImage(c.canvas, 0, 0);
					}
					else
					{
						var $img = widgEl.find("img"); // image is 100%100%
						widget._convertCanvasToImg($(c.canvas), $img, tmplVars);
					}
				}
				catch(e) // this can fail if widget gets corrupted and wont allow previewing - quick live fix by dave replicated here.
				{
					//console.log(e)
				}
			}
		};

		// blur if it's not being resized
		if (!widgEl[0].classList.contains('ui-resizable-resizing')) {
			draw.blur();
		}

		//When drawing image uploads, only draw the image, since no other elements are currently supported
		if(typeof tmplVars.upload === "string" && tmplVars.upload == 'y')
		{
			widget._drawImageUpload(widgEl, tmplVars);
			return;
		}

		var top = 0, left = 0;
		var width = tmplVars.absTLWH[2]; 
		var height = tmplVars.absTLWH[3];
		
		var borderWidth = 0;
		var borderRadius = 0;
		var border = tmplVars.b;

		var adjustedBorderWidth = null;

		if(border)
		{
			borderWidth = border[0];
			borderRadius = border.length > 3 ? border.slice(2) : border[2];
		}
		
		var shape = tmplVars.s ? tmplVars.s : "sq";	// allow different shapes // in time this could be an array or a predefined 

		c.save();
		
		draw.path(c, shape, borderRadius, top, left, width, height, borderWidth, tmplVars); // This is the path for the Background and border.

		if(tmplVars.sh) // to be extended massively (and made work).
		{
			draw._shadow(c, tmplVars);
		}	
		
		if(tmplVars.bg)	// background
		{		
			draw.background(c, tmplVars);
		}
		
		c.restore();
		
		if(border && borderWidth > 0)	// border can be 0 in situations where we just want the rounding.
		{
			draw.border(c, tmplVars, width, height);
		}
		//c.save();
		if(tmplVars.glaze && tmplVars.glaze == 'y')// this could be made more generic with an embedded widget!
		{
			draw._glaze(c, tmplVars);
		}	
		
		if(tmplVars.fx && tmplVars.fx.length > 0)// this could be made more generic with an embedded widget!
		{
			draw._effect(c, tmplVars);
		}
		
		if(tmplVars.i)
		{
			for(var i = 0; i< tmplVars.i.length; i++) // for each image
			{
				var icon = tmplVars.i[i];
				var img = new Image();	// TODO: Cache this image.

				function imageLoaded()
				{
					var positionX = icon[5];
					if(typeof(positionX)=='string' && positionX.search("%") != -1) // its a % across. 
					{
						positionX = (width * parseInt(positionX) / 100) - icon[3]/2; // - icon[3]/2; // midway point minus half the width of the widget.
					}
					else if(positionX < 0) // its negative - align from right;
					{
						positionX = parseInt(width) + icon[5] - icon[3]; // its negative. 
					}
					
					var positionY = icon[6];
					if(typeof(positionY)=='string' && positionY.search("%") != -1) // its a % across. 
					{
						positionY = (height * parseInt(positionY) / 100) - icon[4]/2; // - icon[3]/2; // midway point minus half the width of the widget.
					}
					else if(positionY < 0) // its negative - align from right;
					{
						positionY = parseInt(height) + icon[6] - icon[4]; // its negative. 
					}
					img.onload = function()
					{
						try
						{
							c.drawImage(img,
									icon[1], icon[2] , 
									icon[3], icon[4], // source and destination width/height are the same
									positionX + left, positionY + top, 
									icon[3], icon[4]);
							draw._setImage(widgEl, c, tmplVars);
							
							if (c.canvas.hasOwnProperty('onchange')) // not nice, but works. addEventListener and dispatchEvent don't work for some reason.
							{  
								c.canvas.onchange(); 
							}
						}
						catch(e)
						{
							//console.log("Image draw fail", c, img, icon, positionX + left, positionY+ top, e, tmplVars); // probably exported version. 
						}
					}
					img.src = icon[0];
				}
				
				$(img).ready(imageLoaded);			
			}	
		}
		else
		{
			draw._setImage(widgEl, c, tmplVars);
		}
		

	};
	
		
	// Scales a widget in the library
	// "f" no longer supported. 
	widget.scale = function(widgetParts, data) 
	{
		var minSize = 10; // min width/height for a scaled widget
		var scale;
		if(data.ls)											    { scale = data.ls;}
		else if (typeof data.wh === "undefined")			    { scale = 66/80; }
		else if(data.wh[0] == 'a' || data.wh[1] == 'a')		    { scale = 66/320; }
		else if(data.wh[0] == '100%' || data.wh[1] == '100%')	{ scale = 66/320; }
		else if(typeof(data.wh[0]) === 'string' || typeof(data.wh[1]) === 'string' )
			{
				var scale1 = parseInt(data.wh[0]) / 640;
				var scale2 = parseInt(data.wh[1]) / 640;
				scale = Math.max(scale1, scale2);
			}
		else
			{
				scale = Math.min(1, 66/data.wh[0], 66/data.wh[1]);
				/*if (Math.min(data.wh[0], data.wh[1]) * scale < minSize)
				{
					//console.log("Minimum size reached " + scale + ". Min Touched: " + Math.min(data.wh[0], data.wh[1]) * scale);
					scale = Math.min(minSize*3/data.wh[0], minSize*3/data.wh[1]);
				}*/
			}
		if (scale <  1)
		{
			$(widgetParts).css({
				"-webkit-transform" : "scale(" + scale + ")",
				"-moz-transform" : "scale(" + scale + ")"
			});  //just return scale - more generic?
		}
	};

	// Adds a widget to the active page - TODO: take page as arg?
	// NOT DEPRECATED YET
	widget.add = function(e, offset, id, pageObj, lockTo)
	{
		var addToPage = $(pageObj).closest(".screen");
		var sourceWidgetToCopy = id;
		var selectAfter =  (e) ? true : false;
		return widget._add(sourceWidgetToCopy, addToPage, selectAfter); // e, offset , lockTo
	}

	// Adds a widget to page
	// why is the container not the same as the page?
	widget._add = function(sourceWidgetIdToCopy, addToPageEl, selectAfter, offset) // e, offset, , lockTo , container // not necessarily active page
	{
		if (project.readOnly())
		{ 
			return false; 
		}
		
		// general prep
        storage.cacheStart();
		widget._stopEditingText();
		widget.resetSelection(); // TODO: only if its being added from certain ways - eg not cloning
		
		// vars needed for adding a widget.
		var lockTo = false; 							// its a root
		var container = addToPageEl.find(".widgetHolder");
		
		// save these vars, dont recalculate.
        widget.afterAdding();
		var containerTLWH = [0, 0, container.width(), container.height()];
		var offset = (offset) ? offset : false; // added offset from AD - not used for root.
		var offsetFrom = false;	
		var segId = false;
		var wdgId = widget._createSaveAndDraw(sourceWidgetIdToCopy, lockTo, addToPageEl, offset, container, containerTLWH, offsetFrom, segId); // handles all subwidget drawing.

        if (selectAfter)  //DA: 12-Mar-2012: Don't select the widget when no event is present
        {
			var wEl = $("#" + wdgId);
		    widget.select(null, wEl);
        }

		storage.commitCache();

		var pageId = addToPageEl.attr('id');
		widget.renderAbove(pageId, wdgId);

		//group.drawExisting();
		return wdgId;
	};

	//takes page and widget id, checks if the widgets above widgetId use translucency. If so, redraw is needed
	widget.renderAbove = function(pageId, widgetId) {
		var pageWidgets = storage.get(pageId).widgets;
		var above = false;

		for(var i=0; i<pageWidgets.length; i++) {
			if(above && storage.get(pageWidgets[i]).blur) {
				page.drawDetailed(pageId);
				return;
			}

			if(pageWidgets[i] === widgetId) above = true;
		}
	};
	
	// Adds a widget to memory. Does not draw it.   // , offset  e, props,  t, lockTo, segment
	widget._createSaveAndDraw = function(source, lockTo, pageObj, adOrSegOffset, container, containerTLWH, offsetFrom, lastSegId)
	{
		//console.trace();
	
		var id = utils.guid("w"); 
		var sourceObj = typeof source == 'string' ? widget.get(source) : source;
		if (!sourceObj) { return false; }
		
		var obj = $.extend(true, {}, sourceObj); // make a copy of the widget data
		
		obj.lockTo = (lockTo) ? lockTo : id; // if lockto is passed use it, else lock to self (rootwidget)
		obj.tlwh = widget._getRelativeTLWH(id, obj, pageObj, adOrSegOffset); // set the tlwh of the widget.
		var ca = obj.ca || (adOrSegOffset && adOrSegOffset[2]);
		obj.ca = (ca) ? ca : 'tl';
				
		if(offsetFrom)
		{
			obj.of = offsetFrom;
		}
		
		if(lastSegId === true)
		{
			lastSegId = id;
		}
		
		if(lastSegId)
		{
			obj.segment = lastSegId;
		}
		
		widget._removeUnnecesaryProps(obj); // tidy up the widget.
		//obj.upload = false;
		if ((obj.upload) && (!obj.data))
		{
			obj.data = source;
		}

		widget._save(id, obj, pageObj);
		page.calculateWdgPositions(pageObj.attr('id'));
		widget._draw(id, container, containerTLWH);  // id, appendTo, containmentSize
		
		//if not drawn in detail, draw
		pageObj[0].querySelector('.page-preview') && page.drawDetailed(pageObj[0].id, 'init');

		if(obj.seg && obj.sc)
		{
			widget._dropSegments(id, obj, pageObj, container, containerTLWH);
		}	
		
		if(obj.ad)
		{
			widget._dropAds(id, obj, pageObj, container, containerTLWH, lastSegId);
            delete obj.ad; // can this go somewhere more sensible? //Once the AD elements are drawed, remove the reference from the object
            widget.set(obj, id);
		}

		return id;
	}

	// adds segments to a newly dropped widget.
	widget._dropSegments = function(parentId, parentProps, pageObj, container, containerTLWH) // parentId, parentProps, pageObj, container, containerTLWH
	{	
		var segData = widget._setupSegments(parentProps, containerTLWH);
	
		parentProps.segments = [];
		var len = segData.segments.length;
		for(var i = 0; i < len; i++)
		{
			var segment = segData.segments[i];
			var segId = true;
			var id = widget._createSaveAndDraw(segment.wObj, parentProps["lockTo"], pageObj, segment.pos, container, containerTLWH, parentId, segId);
			parentProps.segments.push({id: id, widget: segment.wId});
		}
		//console.log("dropSegments", parentId, parentProps, segData);
		//widget._updateSegmentRoot(parentId, parentProps, segData);
	}
	
	widget._dropAds = function(parentId, parentProps, pageObj, container, containerTLWH, lastSegId)
	{
		for(var i in parentProps.ad)
		{
			var ad = parentProps.ad[i];
			var containerAlign = ad[3] || 'tl';
			var adOffset = [ad[2], ad[1], containerAlign]; // plus my offset from parent.
			widget._createSaveAndDraw(ad[0], parentProps["lockTo"], pageObj, adOffset, container, containerTLWH, parentId, lastSegId); //sourceWidgetId, lockTo=root, pageObj=source position.
		}
	}

	
	
	// TODO: add support for OF tag. 
	widget._getRelativeTLWH = function(widgId, widgObj, pageEl, offset) // sets the correct offsets for the widget at create.
	{
		if(typeof widgObj.st !== 'undefined' && widgObj.st == 'b') // background
		{
			return [0, 0, "a", "a"];
		}

        var width = 0;
        var height = 0;
        if (widgObj.wh || widgObj.tlwh)
        {
            width = widgObj.tlwh ? widgObj.tlwh[2] : widgObj.wh[0]; // a new widget has widgObj.wh, a duplicated/copied widget has tlwh
            height = widgObj.tlwh ? widgObj.tlwh[3] : widgObj.wh[1];
        }

		if (widgObj.upload === 'y') {
			var page = storage.get(pageEl[0].id),
				newSize = fluid.util.getFitSize({
					object: {
						width: width,
						height: height
					},
					frame: {
						width: page.width,
						height: page.height
					}
				});

			width = newSize.width;
			height = newSize.height;
		}

		if(offset) // ad with set relative position
		{
			//var width = widgObj.wh ? widgObj.wh[0] : widgObj.tlwh[2]; // a new widget has widgObj.wh, a duplicated/copied widget has tlwh
			//var height = widgObj.wh ? widgObj.wh[1] : widgObj.tlwh[3];
			return [offset[0], offset[1], width, height];
		}	
		
		// widget dropped by drag/drop action on page.
		var draggingWidget = $("#libraryWidgetDragging"); // move this to init and make it this or false, same with below - calculate once.
		if( draggingWidget.length > 0 ) // its been dropped via a drag from library // move this search out of the loop. 
		{
			var dropPos = $("#libraryWidgetDragging").position(); //move me out!
			var pageOffsetFromBody = $(pageEl).offset(); // move me out! // get the ul rather than the page?	
			return [dropPos.top-pageOffsetFromBody.top+8, dropPos.left-pageOffsetFromBody.left+8, width, height];
		}
		
		if(widgId == widgObj["lockTo"]) // by double click
		{
			var dp = (widgObj.dp) ? widgObj.dp : [0,0];
			return [dp[0], dp[1], width, height];
		}
		
		//console.log("UNKNOWN TLWH Condition");
		return [0, 0, width, height];
	}
	
    //DA: 09-Mar-2012: Remove unnecesary properties
    widget._removeUnnecesaryProps = function(obj)
    {
		delete obj.title;
		delete obj.g;
		delete obj.t;
		delete obj.dp;
		delete obj.x;
		delete obj.id;
		delete obj.wh;
    }

	// saves the widget in pages and makes the localstorage object.
    widget._save = function(id, obj, pageObj)
    {
        page.addWidget(pageObj.attr("id"), id, obj); // adds the widget to the list in memory on the page.
		storage.set(id, obj);

		if(typeof obj.st !== "undefined" && obj.st == 'b' && pageObj.find(".backgroundWidget").length > 0) // Delete previous background if this is one too
		{
			widget.del(pageObj.find(".backgroundWidget"));
		}
		//console.log("Pageobj in widget._save", pageObj);
		

	}

    widget.afterAdding = function()
    {
        var pageEl = $(".screen.active");
        var pageId = pageEl.attr("id");
        var isFirstWidget = project.hasWidgets() ? false : true;
        var isFirstWidgetInPage = page.get(pageId, "widgets").length > 0 ? false : true;

        //When the first widget is added to the project, display the Preview button and make the page the home page
        if ((isFirstWidget) || (!project.get("homepage")))
        {
            //$("#previewView, #preview").fadeIn(300);
            $("#previewView, #preview, #pagePreview").animate({
				opacity: 1
			},300);
            $("#preview, #pagePreview").css("pointer-events",'auto');
			page.makeHome(null, pageEl); //ATTENTION BARTEK THIS IS THE PROBLEM LINE
        }

        //When the first widget is added to the page, display the bin
        if(isFirstWidgetInPage)
        {
            $("#trash").fadeIn(300);
        }

        //hint.show("link");
    }


	widget.duplicate = function (e)
	{
		widget._duplicate(e);
		return false;
	};
	
	widget.cut = function(e, sel)
	{
		widget._cut(e, sel);
		return false;
	};
	
	widget.copy = function(e)
	{
		widget._copy(e);
		return false;
	};
	
	widget.paste = function(e)
	{   	
		widget._paste(e);
		return false;
	};
	
	widget.replace = function(id, newID)
	{
		widget._replace(id, newID);
	};
	
	widget.editText = function (e) // t is the div that has been double clicked on.
	{	
		widget._editText(e, this);
		return false;
	};
	
	widget._copies = null;
	widget._copyOriginPageId = null;

	widget._editText = function (e, $this) // t is the div that has been double clicked on.
	{	
		if (project.readOnly()){ return false; }
		
		if( $("#canvasPages .pageWidget textarea").length > 0 ) // handle multi double click. 
		{ 
			widget._stopEditingText(); 
		} 
	
		var $this = $($this); // is the text div!
		if($this.length != 1) return; // Not a text widget.
		
		var widg = $this.closest(".pageWidget");
		var wObj = widget.get( widg.attr("id") );
				
		var height = wObj.tlwh[3] - parseInt($this.css("padding-top")) - parseInt($this.css("padding-bottom")); // account for padding in div
		var width = wObj.tlwh[2] - parseInt($this.css("padding-left")) - parseInt($this.css("padding-right"));

		$this.hide();
		var style = $this.attr("style");
		//console.log("style",style);
		var topMargin = parseFloat($this.css("padding-top"));

		//var css = {width: "100%", height: "100%"}; //css!
		var css = {width: "100%", height: wObj.tlwh[3] - topMargin}; //css!
		$("<textarea>").attr("style", style).css(css).text(wObj.tc).insertAfter($this).show().focus().select(); 	
		return false;
	};

	widget._stopEditingText = function () // gets called on blur?
	{   
		var $this = $("#canvasPages .pageWidget textarea");
		if($this.length == 0) {	return; } // not editing.
		
		var text = $this.val();
		var id = $this.closest(".pageWidget").attr("id");

		fluid.command.create('setText', {id: id, text: text}).dispatchTo('fluid.controllers.widget');

		//widget.set({tc : text}, id);
		//$this.siblings(".widgetText").text(text).show();

		$this.siblings(".widgetText").show();
		$this.remove();	
		return false;	
	};

	widget._duplicate = function (e)
	{
		if(widget.editing == true)
		{
			return true;
		}
		//Copy the selected elements but keep the original clipboard elements in memory
		var tempCopies = $.extend(true, {}, widget._copies);
		var all = widget.getLockTos("#canvasPages .ui-selected");
		widget._copy(e, all);

		//Paste the elements
		widget._paste(e);

		//Restore Clipboard
		widget._copies = $.extend(true, [], tempCopies);
		tempCopies = null;
	};

	/*
	widget._duplicate = function (e)
	{
		if(widget.editing == true)
		{ 
			return true; 
		} 
	
		function duplicateFromRoot()
		{
			var id = $(this).attr("id"); //.removeClass("ui-selected") // deselect? .resizable( "option", "disabled", true)
			var obj = widget.get(id);
			var offset = [obj.tlwh[0]+5,obj.tlwh[1]+5];
			var wId = widget._add(id, screenEl, false, offset);  // false = selectAfter
			toSelect = toSelect.add( $("#" + wId) );
		}

		var roots = widget.getRoots(".ui-selected");
		var screenEl = roots.closest(".screen");
		var toSelect = $([]);
		
		$.each(roots, duplicateFromRoot);

		widget.resetSelection();
		widget.select(null, toSelect);

		return false;
	};*/
	
	widget._cut = function(e, sel)
	{
		var all = widget.getLockTos(sel || "#canvasPages .ui-selected");
		widget._copy(null, all, true);
		widget.del(all);
		
		widget.resetSelection();
		contextMenu.hide();
		propInspector.resetPropInspector();
		return false;

	};

	widget._copy = function(e, sel, cut)
	{
		widget._copies = {oldId: [], data: [], newId: []};
		widget._copyOriginPageId = $("#canvasPages .ui-draggable .ui-selected").closest(".screen").attr("id");
		if(!sel)
		{
			var sel = widget.getLockTos("#canvasPages .ui-selected");
		}
		
		sel.each(function()
		{
			var id = $(this).attr("id");
			var data = $.extend(true, {}, widget.get(id));
			(widget._copies.oldId).push(id);
			(widget._copies.data).push(data);
            widget._copies.cut = cut;
		});
		
		group.copy(widget._copies.oldId);
		return false;
	};
	
	widget._paste = function(e)
	{
		if (!widget._copies) { return true; }
		if ($(".pageWidget textarea").length) { return true; }
	
		var activePageEl = $("#canvasPages .active");
		var activePageId = activePageEl.attr("id");
	
		if (!activePageEl.length)
		{ 
			notification.add("alert", "Cannot paste. No active page selected.")
			return false; 
		}

		widget._copies["newId"] = []; // reset in case of double paste.
		
		for (var i in widget._copies["oldId"])
		{
			(widget._copies["newId"])[i] = utils.guid("w");
		}

        widget.afterAdding();
		var container = activePageEl.find(".widgetHolder");
		var containerTLWH = [0, 0, container.outerWidth(), container.outerHeight()];
		var toSelect = "";
		
		for (var i in widget._copies["oldId"]) // needs above for loop separate as it uses the data set.
		{
			var newId = (widget._copies["newId"])[i];
			var obj = $.extend(true, {}, (widget._copies["data"])[i]);
			
			var posLockTo = $.inArray(obj.lockTo, widget._copies["oldId"]); // what position in the old array is the lockto.
			obj.lockTo = (widget._copies["newId"])[posLockTo];
			
			if (obj.segment)
			{
				var posSeg = $.inArray(obj.segment, widget._copies["oldId"]); // what position in the old array is the segment.
				obj.segment = (widget._copies["newId"])[posSeg];
			}

			if (widget._copies.data[i].segments)
			{
				var oldSegRoot = widget._copies.data[i];
			
				for (var idx = 0, len = oldSegRoot.segments.length; idx < len; idx++)
				{
					var idPos = $.inArray(oldSegRoot.segments[idx].id, widget._copies["oldId"]);
					obj.segments[idx].id = widget._copies["newId"][idPos];
				}
			}

			if (obj.of)
			{
				var posOf = $.inArray(obj.of, widget._copies["oldId"]); // what position in the old array is the Of.
				obj.of = (widget._copies["newId"])[posOf];
			}

			if (widget._copyOriginPageId == activePageId && obj.lockTo == newId && obj.st != "b" && !widget._copies.cut) // root offset if straight copy pasted.
			{
				obj.tlwh[0] += 5;
				obj.tlwh[1] += 5;
			}

			widget._save(newId, obj, activePageEl);
			widget._draw(newId, container, containerTLWH, false, false);

			//Only select the root elements
			if (!obj.of)
			{
				toSelect += "#" + (widget._copies["newId"])[i] + ", ";
			}
		}

        widget.resetSelection();
		group.paste(widget._copies.newId,group.copyGroups);
		widget.select(null, $(toSelect));

		return false;
	};

	
	widget.del = function(sel)
	{
		$("#multiSelBox").remove();
		
		//sel can contain jQuery object or a list of ids
		if(sel.jquery) {
			$(sel).each(function() {
				widget.remove($(this).attr("id"));
			});
		} else if(sel.length) {
			for(var i=0; i<sel.length; i++) {
				widget.remove(sel[i]);
			}
		}


        //If the deleted widget is the last one in the project, hide the Preview button
        if (!project.hasWidgets())
        {
            //$("#previewView, #preview").fadeOut(300);
            $("#previewView, #preview, #pagePreview").animate({
				opacity: 0
			},300);
			
			$("#preview, #pagePreview").css("pointer-events",'none');
        }
        //If the deleted widget is the last one in the selected page, hide the bin
        var activePageId = $(".screen.active").attr("id");
        var pageHasWidgets = page.get(activePageId, "widgets").length > 0 ? true : false;
        if(!pageHasWidgets)
        {
            //$("#trash").fadeOut(300);
            hint.show("library");
        }
        else
        {
            hint.show("selectWidget");
        }

		//group.removeFromGroup(sel);
		//console.log("Deleting widget in widget.del:", sel, $(sel).attr("id"));
		/*var res = true;

		var all2 = $(sel); // Get everything that is locked or segmented to this.
		var widgetsData = new Array;

		$(sel).each(function() // get roots ?
		{
			var id = $(this).attr("id");
			var all = $('[data-lockto="' + id + '"], [data-segment="' + id + '"]'); // anything with the same class as the data-lock-to attribute is locked to it.
			all2 = all2.add(all);
		});

		// add in 
		
		
		//var updateMultiseg = {};
		all2.each(function()
		{
			var $id = $(this).attr("id");
			var pageId = $(this).closest(".screen").attr("id");
			var alink = link.from($id);
			var fromSegment = $(this).attr("data-segment");
			var lockTo = $(this).attr("data-lockto");
			if(alink != false)
			{
				link.del(alink);
			}

			// Delete the widget in all the relevant places.
			page.removeWidget(pageId, $id);
			storage.remove($id); //localStorage.removeItem($id);
			$("#" + $id ).remove();

			var rootWidget = $("#" + lockTo);
			if ((fromSegment == $id) && (lockTo))
			{
				var info = storage.get(lockTo);
				if (widgetsData.indexOf(info))
				{
					widgetsData.push(info);
				}
			}
		});

		//DA: 16-Apr-2012: ONLY when deleting a segment in a widget, adjust the widget
		if (widgetsData.length > 0)
		{
			function delSeg()
			{
				if (this.seg)
				{
					this.sc--;
					widget.addOrUpdateSegments(this, widget.setupSegments(this));
				}
			}
		
			$.each(widgetsData, delSeg);
		}
		*/
		$('#trash').removeClass('droppableStyle'); // just pass the id of the deleted widget's page.
		//return res;
	};

	//Deletes 1 Widget and all its sub elements
	widget.remove = function(widgId)
	{
		//console.log("removing a widget");
		var widgEl = $("#" + widgId);

		//widget might not bee there in DOM in zoomedOut mode
		if (widgEl.size() == 0) {
			if(widgetsCache[widgId].pageId) {
				page.removeWidget(widgetsCache[widgId].pageId, widgId);
			}
			storage.remove(widgId);
			widgEl.remove();
			return false;
		}

		//remove all sub widgets
		var subWidg = widget.getDependents(widgId);
		subWidg.each(function(){
			widget.remove($(this).attr("id"));
		});

		//Remove the element and all additional elements
		var alink = link.from(widgId);
		if(alink != false)
		{
			link.del(alink);
		}
		
		

		// Delete the widget in all the relevant places.
		var pageId = widgEl.closest(".screen").attr("id");
		page.removeWidget(pageId, widgId);
		storage.remove(widgId);
		widgEl.remove();
		
		grid.selectBackground();
	},

	// clicking on a single widget to select.
	// TODO: SLOW! 
	
	widget.select = function (e, t) // e can be null for drag events, loading. 
	{
		//console.log("afsdfiing selection <><><><",e,t);
		//console.trace();
	
		if (project.readOnly()) { return false;}
		
		var changingScreen = false;
		if($("#canvasPages .ui-selected").length > 0 && $(" #canvasPages .ui-selected").closest(".screen").attr("id") != $(t).closest(".screen").attr("id"))
		{
			//console.log("Selecting on different screens!");
			changingScreen = true;
			widget.resetSelection();
		}
		
		if(e && (e.metaKey || e.ctrlKey)  )
		{
			//console.log("got ctrlKey");
			//var lockto = $("#" + $(t).attr("data-lockto")); 
			var lockto = $(t); 
			var segment = $("#" + $(t).attr("data-segment"));
	
			// remove from selection
			if( lockto.hasClass("ui-selected") || (segment.length > 0 && segment.hasClass("ui-selected"))  ) // multi segments selected?
			{
				lockto.add(segment).removeClass("ui-selected");
				widget._makeNonResizable(lockto.add(segment)); 
				
				if($("#canvasPages .ui-selected").length == 0)
				{
					contextMenu.hide();
				}
                else
                {
					contextMenu.place(e);           // When a widget is de-selected the Context Menu should be recalculated

                    updateTLWH();                   // and the multiSelectBox should be redrawn
                    widget.addResizeSettings($('.ui-selected').eq(0));
                }
				
				return;
			}
		}
		
		var prevSelection = $('.ui-selected');

		if(e != null && !(e.metaKey || e.ctrlKey) && e != "pass") // e null when loading.
		{
			widget.resetSelection();	// can skip this if ctrl is pressed.
		}
		
		if(widget.selectMulti == false)  // unless we are selecting multi, reset.
		{
			if(!$(this).hasClass("ui-selected"))
			{
				widget.resetSelection();
			}
		}
		
		if(browserDetect.browser == 'Safari')
		{
			widget._safariDragHandleFixSel = $("#canvasPages .page *").addClass("safariResizeHandleZFix");
			//widget._safariDragHandleFixSel = $("#canvas *").addClass("safariResizeHandleZFix");
		}
		
		// if clicking a segment widget
		// TODO: first click selects root
		var segment = $(t).attr('data-segment');
		if (segment && segment == $(t).attr('id'))
		{
			// if neither root widget nor another segment are selected, select root widget
			var lockTo = $(t).attr('data-lockto');
			var root = $('#' + lockTo);
			var prevLockTo = prevSelection.attr('data-lockto');
			if ((prevSelection.filter(root).size() == 0 && prevLockTo != root.attr('id')) || prevSelection.filter($(t)).size() > 0)
			{
				t = root;
			}
		}
		$(t).addClass("ui-selected");
		
		if (changingScreen)
		{
			setTimeout(contextMenu.place, 500); //Wait until the new page is properly selected and centered
		}
		else
		{
			contextMenu.place(); // called here by click and by selectable
		}
		updateTLWH(); 
		widget.addResizeSettings(t);
		
		
		$(":focus").blur();

		// probably not needed. 
		if(e != null && e.stopPropagation != undefined )
		{
			e.stopPropagation();
		}
		
		grid.selectBackground();
		snap.initSnapPositions();
		page.hideOptionsMenu();
		//widgProps.showStaticStatus();

		return false;
	};
	
	widget._selected = null;
	widget.addResizeSettings = function(t)
	{
		//console.log("resize");console.trace();
	
		$("#multiSelBox").remove();
		var sel = $("#canvasPages .ui-selected");
		widget._selected = group.select(sel);
		//widget._selected = $([]);
		var widgAmount = widget._selected.length;
		widget._makeNonResizable(widget._selected);
		
		//console.log(widgAmount);
		if(widgAmount < 2)
		{
			widget._makeResizable(t);
		}
		else
		{
			updateTLWH();
			widget.drawMultiSelBox(widget._selected); // CALLED MULTIPLE TIMES - IMPROVE!!!
		}
		
		 //if there are groups around
	};
	
	widget.drawMultiSelBox = function(selected)
	{
		//console.log("DRAWING BOX MWAAAAAN!");
		//remove any existing ones
		var firstObject = selected.eq(0);
		var firstWidget = (firstObject.hasClass("backgroundWidget")) ? selected.eq(1) : firstObject;

		var objTop = parseInt(firstWidget.css("top"));
		var objLeft = parseInt(firstWidget.css("left"));
		var finalTop = objTop - widget._selectionTLWH.top;
		var finalLeft = objLeft - widget._selectionTLWH.left;
		widget._selectionTLWH.top = finalTop*-1;
		widget._selectionTLWH.left = finalLeft*-1;
		$("#tmplSelBoundingBox").tmpl(widget._selectionTLWH).prependTo("#" + firstWidget.attr("id"));
		
		var multiSelBox = $("#multiSelBox");
		multiSelBox.css("z-index","");
		
		if(browserDetect.browser == 'Firefox')
		{
			$(firstWidget).css("outline",""); //remove the dotted line on the first object
		}
	};
	
	widget.resetSelection = function ()
	{ 
		$("#multiSelBox").remove(); //remve the multiple selection bounding box
		if(browserDetect.browser == 'Safari')
		{
			$("#canvas *").removeClass("safariResizeHandleZFix");
			widget._safariDragHandleFixSel = null;
		}
	
		$('#trash').removeClass("droppableStyle");
		$("#widgetTL, #widgetWH").text("");
		$("#canvasPages .pageWidget.ui-selected").removeClass("ui-selected");
		widget._makeNonResizable(); // just remove the whole resizable aspect of them.
        hint.show("selectWidget");
		//console.log("Hiding cm",propInspector.originalMode);console.trace(); //HERE!!!
        contextMenu.hide();
		
		group.deselect();
	};
	
	
	//DA: 12-Mar-2012: Replace Widget with another widget
	//id:  Widget's Instance ID.
	//newID: ID of the new replacing widget
	 widget._replace = function(id, newID)
	 {
		var obj = widget.get(id);
		if (obj)
		{
			try
			{
				//Get Relevant Info about the current widget
				var pageID = widget.getPageOf(id);
				var top = obj.top;
				var left = obj.left;

				//Remove current widget
				var selection = $("#" + id);
				widget.del(selection);

				//Add new Widget
				widget.add(null, {top: top,left: left}, newID, $("#" + pageID).find(".widgetHolder"));
			}
			catch(e)
			{
				//console.log("Unable to update old widget definition");
			}
		}
	 }

	//DA: 25-May-2012: Fix widget position and alignment when necessary for backwards compatibility
	//id:  Widget's Instance ID.
	//obj: Widget object to get all widget's properties
	//pageData: Page Object in storage to get the page dimensions
	widget.fixTLWH = function(id, obj, pageData)
	{
		//When the widget doesn't have any wh, don't fix anything (Probably a Background)
		if (!obj.wh)
		{
			return false;
		}

		//console.log("Updating old widget:", id, obj, pageData);
		
		//Get initial values and normalize expected values
		var newTop = obj.top.toString();
		var newLeft = obj.left.toString();
		if (newTop.indexOf("%") > -1)
		{
			newTop = newTop.substring(0, newTop.indexOf("%") + 1);
		}
		if (newLeft.indexOf("%") > -1)
		{
			newLeft = newLeft.substring(0, newLeft.indexOf("%") + 1);
		}

		//Fix subwidgets and segments
		if ((obj.lockTo != id) && (newTop.indexOf("%") == -1))
		{
			var container = widget.get(obj.lockTo);
			//console.log("  Container fail1:", container);
			var from = (!container || isNaN(container.tlwh[0])) ? 0 : container.tlwh[0];
			newTop =  obj.top - from;
		}

		if ((obj.lockTo != id) && (newLeft.indexOf("%") == -1))
		{
			var container = widget.get(obj.lockTo);
			//console.log("  Container fail2:", container);
			var from = (!container || isNaN(container.tlwh[1])) ? 0 : container.tlwh[1];
			newLeft =  obj.left - from;
		}

		//Fix values before setting in object
		if (newTop.toString().indexOf("%") == -1)
		{
			newTop = parseFloat(newTop);
		}
		if (newLeft.toString().indexOf("%") == -1)
		{
			newLeft = parseFloat(newLeft);
		}
		
		// drop "" if on string integer sizes - happened for backgrounds.
		if ((obj.wh[0]).toString().indexOf("%") == -1)
		{
			obj.wh[0] = parseFloat(obj.wh[0]);
		}
		if ((obj.wh[1]).toString().indexOf("%") == -1)
		{
			obj.wh[1] = parseFloat(obj.wh[1]);
		}
		
		// dont set tlwh for bg...
		if(obj.st != "b")
		{
			var newTLWH = [newTop, newLeft, obj.wh[0], obj.wh[1]];
			obj.tlwh = newTLWH;
		}

		

		//Set values in object
		//console.log("Fixing Widget Backwards Compatibility. ID: " + id + ". NewTLWH: " + newTop + " x " + newLeft + ": " + newTLWH.join(","), obj);
		//widget.set({tlwh: newTLWH, ca: "tl"}, id);
		obj.ca = "tl";
		
		delete obj.top;
		delete obj.left;
		delete obj.wh;
		delete obj.id;
		delete obj.title;
		delete obj.dp;
		delete obj.x;
		
		storage.set(id, obj);
	}
	


	widget._resizeEl = null;
	widget._resizePageId = null;
	widget._resizeAxis = null;
	widget._resizeLockTos = null;
	widget._resizeFromTLWH = null;

	// User starts a drag action via a handle. 
	widget._dragResizeStart = function(e, ui)  	// pause disk writing?
	{	
		storage.cacheStart();
		widget._stopEditingText();
		widget._resizeEl = $(ui.element);
		widget._resizePageId = $(this).closest(".screen").attr("id");
		widget._resizeLockTos = widget.getLockTos($(this));
		widget._resizeAxis = $(this).data('resizable').axis;
		widget._resizeFromTLWH = [
			parseInt(widget._resizeEl.css("top")),
			parseInt(widget._resizeEl.css("left")),
			widget._resizeEl.width(),
			widget._resizeEl.height()];

		var snapToGrid = account.get("gridStatus");
		var snapToWidget = account.get("snapToWidget");
		//console.log("snapToWidget is",snapToWidget);
		$(this).resizable( "option", "grid", snap.snapResize(snapToGrid));
		if(snapToGrid == 'on') {snap.snapResizeDragStart(ui,this)}
		if(snapToWidget == 'on'){snap.setResizeEdgeBounds(ui)}
		
		var scaleStart = true;
		widget.posScaleHelperInit(this,scaleStart);
		
		//widgGroup.groupDragStart($(this));
	};
		
	widget._dragResize = function(e, ui)
	{
		var snapToWidget = account.get("snapToWidget");
		if(snapToWidget == 'on'){snap.resizeToWidgEdges(ui,this);}
		var tplvars = widget._resize(widget._resizeEl, widget._resizePageId, false, true);  // widget._resizeId, widget._resizeParentId, tlwh
		//widget._redraw(widget._resizeEl,tplvars);

		var w = widget._resizeEl[0].id,
			activePage = document.querySelector('.canvasObject.active');

		if (storage.get(w).blur) {
			widget.blurLayers[w] = widget.blurLayers[w] || widget.renderBlurLayer(w, activePage.id);

			widget.setBlurBG(widget._resizeEl[0]);
		}
	};
	
	widget._dragResizeStop = function(e, ui) 
	{	
		//var pinnedWidgets = staticWidgets.rememberSelection();
		fluid.command.create('resize', {
			id: widget._resizeEl.attr('id'),
			pageId: widget._resizePageId,
			fromTLWH: widget._resizeFromTLWH	
		}).dispatchTo('fluid.controllers.widget');
		$("#widgPosDragHelper").remove(); //remove the resize helper
		snap.removeAlignGuides();
		//widgGroup.resizeGroupElement(widget._resizeEl);
		widget._resizeEl = widget._resizePageId = widget._resizeLockTos = null; // free up = widget._resizeAxis
		storage.commitCache();
	};
	
	widget._resizeTextContainer = function(elem) // This is a bugfix function
	{
		var widg = elem.find(".widgetText");
		if(widg.length > 0 && widg.length < 2)
		{
			widget.verticalAlign(elem);
		}
		else
		{
			return;
		}
	};
	// handles any resize event for a widget, calculates its correct size. 
	// this is every frame of a resize!
	// when page size happens
	// from context menu resize.
	// orientation change. 

	//widget._resize = function(widgEl, pageId, resizeTLWH, dragging) //tlwh is the new tlwh widgId, pageId, tlwh
	widget._resize = function(widgEl, pageId, resizeTLWH, dragging)
	{
		//var timer = (new Date()).getMilliseconds();
		var useCache = true;
		
		var widgId = widgEl.attr("id");
		var widgObj = widget.get(widgId);
		pageId = pageId ? pageId : widget.getPageOf(widgId);
		var pageElem = $("#" + pageId);
		
		// if the tlwh isnt passed, get it from the object on page.
		var pageTLWH = [0, 0, pageElem.width(), pageElem.height()]; // wh of the page. 
		var resizeTLWH = resizeTLWH || [parseInt(widgEl.css("top")), parseInt(widgEl.css("left")), widgEl.width(), widgEl.height()];
		
		var newTLWH = $.merge([], widgObj.tlwh); // the 	
		delete widget._setTMPLVarsCache[widgId];
		var tmplVars = widget._setTMPLVars(widgId, widgObj, pageTLWH, false, useCache);
		
		// get the offset parent of the widget
		var offsetFromId = widgObj.of || widgObj.lockTo;
		var offsetFromObj = widget.get(offsetFromId);
		
		var isRoot = offsetFromId == widgId;
		
		var offsetFromAbsTLWH = pageTLWH;
		if(!isRoot) {
			offsetFromAbsTLWH = widget._setTMPLVars(offsetFromId, offsetFromObj, pageTLWH, false, useCache).absTLWH; // does not give the right value when root.
		}

		var rtlwh2 = resizeTLWH[2] == 'a' ? '100%' : resizeTLWH[2];
		var rtlwh3 = resizeTLWH[3] == 'a' ? '100%' : resizeTLWH[3];

		//WH		
		newTLWH[2] = (newTLWH[2] == "a") ? resizeTLWH[2] : newTLWH[2];
		newTLWH[3] = (newTLWH[3] == "a") ? resizeTLWH[3] : newTLWH[3];
		
		newTLWH[2] = (typeof newTLWH[2] === "string") ? utils.toPercent(rtlwh2, offsetFromAbsTLWH[2], 5) + "%" : rtlwh2;
		newTLWH[3] = (typeof newTLWH[3] === "string") ? utils.toPercent(rtlwh3, offsetFromAbsTLWH[3], 5) + "%" : rtlwh3;

		// TL as px
		var relT = (typeof resizeTLWH[0] === "string") ? utils.fromPercentString(resizeTLWH[0], offsetFromAbsTLWH[3]) : resizeTLWH[0] - offsetFromAbsTLWH[0]; 
		var relL = (typeof resizeTLWH[1] === "string") ? utils.fromPercentString(resizeTLWH[1], offsetFromAbsTLWH[2]) : resizeTLWH[1] - offsetFromAbsTLWH[1];
		
		// TODO: switch!
		relT = (tmplVars.ca[0] == "b") ? offsetFromAbsTLWH[3] - relT - rtlwh3 : relT; // handle B and R align. 
		relL = (tmplVars.ca[1] == "r") ? offsetFromAbsTLWH[2] - relL - rtlwh2 : relL;
		relT = (tmplVars.ca[0] == "c") ? relT + (rtlwh3/2) - (offsetFromAbsTLWH[3]/2) : relT; // handle CC align. 
		relL = (tmplVars.ca[1] == "c") ? relL + (rtlwh2/2) - (offsetFromAbsTLWH[2]/2) : relL;
		
		newTLWH[0] = (typeof newTLWH[1] === "string") ? utils.toPercent(relT, offsetFromAbsTLWH[3], 5) + "%" : relT; // handle BR cases?
		newTLWH[1] = (typeof newTLWH[1] === "string") ? utils.toPercent(relL, offsetFromAbsTLWH[2], 5) + "%" : relL; // handle BR cases?
		
		// maintain "a" for segments
		if(tmplVars.segments || widgObj.segment)
		{
			newTLWH[0] = (widgObj.tlwh[0] == "a") ? "a" : newTLWH[0];
			newTLWH[1] = (widgObj.tlwh[1] == "a") ? "a" : newTLWH[1];
			newTLWH[2] = (widgObj.tlwh[2] == "a") ? "a" : newTLWH[2];
			newTLWH[3] = (widgObj.tlwh[3] == "a") ? "a" : newTLWH[3];
		}
		
		// call redraw function!

		// save and redraw canvas
		widget.set({tlwh:newTLWH}, widgId);
		if (!dragging)
		{
			tmplVars = widget._setTMPLVars(widgId, widgObj, pageTLWH, false, false); // update tlwh for canvas redraw
		} else if(widgObj.upload && widgObj.upload === 'y') {
            tmplVars.simpleUploadResize = true;
        }
		widget._drawCanvasOrImage(widgEl, tmplVars); // move this to after the other positioning is done?

		 // resizes other segments up/down.

		if (tmplVars.segments)
		{
			segData = widget._setupSegments(widgObj); // 1-2 ms.
			widget._updateSegments(widgObj, segData, dragging ? { redraw : 'img' } : { redraw : 'all' });
		}
		else if (widgObj.segment)
		{
			var segRoot = widget.get(widgObj.lockTo);
			segData = widget._setupSegments(segRoot);
			widget._updateSegments(segRoot, segData, dragging ? { redraw : 'img' } : { redraw : 'seg', segId : widgId });
		}
		else
		{
			//var milliseconds1 = (new Date()).getTime(); 
			var lockTos = widget._resizeLockTos || widget.getLockTos($("#" + widgId)); // 0 ms.
			widget._updateDependents(widgId, pageTLWH, lockTos);
			//console.log("_updateDependents", "Event time:", (new Date()).getTime() - milliseconds1);
		}
		
		updateTLWH();
		var scaling = true;
		widget.posScaleHelperDrag(false, scaling);
		
		//console.log("Execution:", (new Date()).getMilliseconds() - timer);
		return newTLWH;
	};	

	widget._updateDependents = function(widgId, containerTLWH, lockTos) // iteratively update all dependents.
	{
		function updateDependents() // TODO: there are a lot of "no change" cases we can remove here to speed up.
		{
			// GET DATA
			var subEl = $(this);
			var subId = subEl.attr("id");
			var subObj = widget.get(subId);
			var cssChange = {};
			var tmplVars = widget._setTMPLVars(subId, subObj, containerTLWH, false, true); 
			
			// CHECK IF MOVED OR RESIZED
			var axis = widget._resizeAxis || 'br';
			var align = tmplVars.ca;
			var moved = false;
			var resized = false;
			
			/*if( (axis.indexOf("e") > -1 && (align.indexOf("r") > -1 || align[1] == "c")) ||
				(axis.indexOf("w") > -1 && (align.indexOf("l") > -1 || align[1] == "c")) ||
				(axis.indexOf("n") > -1 && (align.indexOf("t") > -1 || align[0] == "c")) || 
				(axis.indexOf("s") > -1 && (align.indexOf("b") > -1 || align[0] == "c")) ||
				(tmplVars.segment && (subEl.get(0).offsetTop != tmplVars.absTLWH[0] || subEl.get(0).offsetTop != tmplVars.absTLWH[1])))*/
			{
				moved = true;
				cssChange.top = tmplVars.absTLWH[0];
				cssChange.left = tmplVars.absTLWH[1];
				delete widget._setTMPLVarsCache[subId]; // remove it from the cache
			}
				
			// this is wrong.
			if( (typeof tmplVars.tlwh[2] === "string" && (axis.indexOf("e") > -1 || axis.indexOf("w") > -1) ) || 
				(typeof tmplVars.tlwh[3] === "string" && (axis.indexOf("n") > -1 || axis.indexOf("s") > -1) )	)
			{
				resized = true;
				cssChange.width = tmplVars.absTLWH[2];
				cssChange.height = tmplVars.absTLWH[3];	
				delete widget._setTMPLVarsCache[subId]; // remove it from the cache
			}
			
			//console.log(resized, moved, cssChange);
			
			subEl.css(cssChange); 
			
			if (moved || resized)
			{
				widget._updateDependents(subId, containerTLWH, lockTos);	// needs to come back. 
			}
			
			if(resized)
			{
				//widget._drawCanvasOrImage(subEl, tmplVars);		// takes 25-30 ms.	
			}	
		}
		var lockTos = lockTos || widget._resizeLockTos || widget.getLockTos($("#" + widgId)); 
		var useCache = true;
		var w = widget.getDependents(widgId, lockTos, useCache);
		
		//console.log(w);
		
		w.each(updateDependents);
	};
	
	// turns on resizable (called when a widget is selected.
	// lot of work to do every time there is a selection? Cache some of it?
	widget._makeResizable = function(sel)
	{
		$(sel).each(function()
		{
			$t = $(this);
		
			var id = $t.attr("id");
			var data = storage.get(id);
			if(!data)
			{
				//console.log("No data for", id, sel, $(sel));
				return;
			}

			//DA:28-Mar-2012: Make all images resizable
			//DA:07-Apr-2012: Make all widgets with segments resizable
			if (data.upload == "y")
			{
				data.r = "y";
			}

			if (data.r)
			{
				// TODO: update widget spec to pass this directly rather than interpreting?
				var handles = 'n, e, s, w, ne, nw, se, sw';
				if (data.r == 'h'){ handles = 'e,w'; }
				else if (data.r == 'v'){ handles = 'n,s';}
				else if (data.r == 'se'){ handles = 'se';}

				// VK 2012-01-22: enable/disable instead of init every time to speed up
				if ($t.data('resizable'))
				{
					$t.resizable('enable');
				}
				else
				{
					$t.resizable({	handles: handles,
									start: widget._dragResizeStart,
									grid: false,
									resize: fluid.util.debounce(
                                        widget._dragResize,
                                    17),
									stop: widget._dragResizeStop}); //snap: ".widgetHolder, .pageWidget"
					//$(this).resizable("option", "disabled", true); // has to be separate from above or it draws the handles :(
				}

				if (data.r == 'h')
				{
					$t.find(".ui-resizable-e").addClass("ui-resizable-eO");
					$t.find(".ui-resizable-w").addClass("ui-resizable-wO");
				}
				if (data.r == 'v')
				{
					$t.find(".ui-resizable-n").addClass("ui-resizable-nO");
					$t.find(".ui-resizable-s").addClass("ui-resizable-sO");
				}
				
			}
		});
	};
	
	// turns off resizable (called when a widget is deselected).
	widget._makeNonResizable = function (t)
	{
		var toDestroy = t ? t : $("#canvasPages .pageWidget.ui-resizable");
		toDestroy.resizable("disable");
	};
	
	widget.toggleUploadFit = function (widgetId) {
		var widgetObject = storage.get(widgetId),
			sourceWidget = widgets.summary[widgetObject.data],
			pageId       = document.querySelector('.canvasObject.active').id,
			page         = storage.get(pageId),
			sourceSize   = {
				width: sourceWidget.wh[0],
				height: sourceWidget.wh[1],
			},
			fitSize      = fluid.util.getFitSize({
				object: sourceSize,
				frame: page
			}),
			originalTLWH = widgetObject.tlwh,
			newTLWH;

		if (fitSize.width  === widgetObject.tlwh[2] &&
			fitSize.height === widgetObject.tlwh[3] ) {

			newTLWH = [
				widgetObject.tlwh[0],
				widgetObject.tlwh[1],
				sourceWidget.wh[0],
				sourceWidget.wh[1]
			];

		} else {
			newTLWH = [
				widgetObject.tlwh[0],
				widgetObject.tlwh[1],
				fitSize.width,
				fitSize.height
			];
		}

		fluid.command.create('resize', {
				id      : widgetId,
				pageId  : pageId,
				fromTLWH: originalTLWH,
				toTLWH  : newTLWH
			}).dispatchTo('fluid.controllers.widget');
	};

	widget.toggleSelectedUploadsFit = function () {
		fluid.util._.each(document.querySelectorAll('.canvasObject .ui-selected'), function (widgetElement) {

			if (storage.get(widgetElement.id).upload === 'y') {
				try {
					// Exceptions from translucency rendering break the context menu
					widget.toggleUploadFit(widgetElement.id);
				}
				catch (e) {}
			}
		});
	};

	widget.uploadFullSize = function (widgetId) {
		var pageId       = document.querySelector('.canvasObject.active').id,
			widgetObject = storage.get(widgetId),
			sourceWidget = widgets.summary[widgetObject.data],
			originalTLWH = widgetObject.tlwh,
			newTLWH = [
				originalTLWH[0],
				originalTLWH[1],
				sourceWidget.wh[0],
				sourceWidget.wh[1]
			];

		fluid.command.create('resize', {
				id      : widgetId,
				pageId  : pageId,
				fromTLWH: originalTLWH,
				toTLWH  : newTLWH
			}).dispatchTo('fluid.controllers.widget');
	};

	widget.fit100 = function () {
		fluid.util._.each(document.querySelectorAll('.canvasObject .ui-selected'), function (widgetElement) {

			if (storage.get(widgetElement.id).upload === 'y') {
				try {
					// Exceptions from translucency rendering break the context menu
					widget.uploadFullSize(widgetElement.id);
				}
				catch (e) {}
			}
		});
	};


	widget.uploadFit = function (widgetId, expand) {
		var widgetObject = storage.get(widgetId),
			sourceWidget = widgets.summary[widgetObject.data],
			pageId       = document.querySelector('.canvasObject.active').id,
			page         = storage.get(pageId),
			widgetBox    = {
				top   : widgetObject.tlwh[0],
				left  : widgetObject.tlwh[1],
				bottom: widgetObject.tlwh[0] + widgetObject.tlwh[3],
				right : widgetObject.tlwh[1] + widgetObject.tlwh[2]
			}
			sourceSize   = {
				width : sourceWidget.wh[0],
				height: sourceWidget.wh[1],
			},
			fitSize      = fluid.util.getFitSize({
				object: sourceSize,
				frame : page,
				expand: expand
			}),
			originalTLWH = widgetObject.tlwh,
			newTLWH = [
				widgetObject.tlwh[0],
				widgetObject.tlwh[1],
				fitSize.width,
				fitSize.height
			];;

		newTLWH[0] = typeof fitSize.top  === 'number'? fitSize.top : newTLWH[0];
		newTLWH[1] = typeof fitSize.left === 'number'? fitSize.left: newTLWH[1];

		fluid.command.create('resize', {
				id      : widgetId,
				pageId  : pageId,
				fromTLWH: originalTLWH,
				toTLWH  : newTLWH
			}).dispatchTo('fluid.controllers.widget');
	};

	widget.fitExpand = function () {
		fluid.util._.each(document.querySelectorAll('.canvasObject .ui-selected'), function (widgetElement) {

			if (storage.get(widgetElement.id).upload === 'y') {
				// Exceptions from translucency rendering break the context menu
				try {
					// expand === true
					widget.uploadFit(widgetElement.id, true);
				}
				catch (e) {}
			}
		});
	};

	widget.fitShrink = function () {
		fluid.util._.each(document.querySelectorAll('.canvasObject .ui-selected'), function (widgetElement) {

			if (storage.get(widgetElement.id).upload === 'y') {
				// Exceptions from translucency rendering break the context menu
				try {
					widget.uploadFit(widgetElement.id);
				}
				catch (e) {}
			}
		});
	};


	widget.libraryDrag = function (e, ui)
	{
		widget._libraryDrag(e, ui, this);
	};
	
	
	widget.libraryDragStart = function(e,ui)
	{	
		
		/*snap.libraryGridSnapOff();
		snap.dragSnap = false;
		var snapToGrid = account.get("gridStatus"); //SNAP DRAG FROM LIBRARY
		if(snapToGrid == 'on') {snap.libraryWidgSnap(e,ui,this);}*/
		
		//console.log("stopping the drag",$(".backgroundWidget").attr("id"));
		if( $("#pageMenu").is(":visible"))
		{
			page.hideOptionsMenu();
		}
	};

	widget.dragWidgetCreate = function(e, ui)
	{
		widget._dragCreate(e, ui, this);
	};
	
	widget.dragWidgetStart = function (e, ui) // optimise - it lags
	{ 
		if (project.readOnly()) {return false;}
		page.hideOptionsMenu();
		
		widget._dragStart(e, ui, this);
		widget.posScaleHelperInit(this);
		// init widget creation here
	};
	
	widget.dragWidget = function(e, ui)
	{
		widget._drag(e, ui, this);
	};
	
	widget.dragWidgetStop = function(e, ui)
	{
		if (project.readOnly()) {return false;}
		
		widget._dragStop(e, ui, this);
	};
	
	widget._dragSelection = null;
	widget._originalDragPos = null;
	
	widget._topDiff = null;
	widget._leftDiff = null;

	widget._dragCreate = function(e, ui, $this)
	{
		// here
		if(project.get("currentZoom") != 1)
		{
			$($this).draggable('disable'); // in case we mouse over at < 100% zoom. 
		}
	};
	
	widget.posScaleHelperInit = function($this, scaleStart)
	{
		var topAlign = -35;
		
		if(scaleStart){var t = $($this);} //dragStart actions for moving and scaling
		else
		{
			if(widget._moveMultiSelection == true){var t = $("#multiSelBox");} //if more than one widget is selecteed
			else
			{
				if($($this).hasClass("rootWidget")){var t = $($this);}
				else
				{
					var lockTo = $($this).attr("data-lockTo");
					var t = $("#" + lockTo);
				}
			}
		}
		
		$("#tmplPosHelper").tmpl({topAlign : topAlign}).appendTo(t);
	};
	
	widget.posScaleHelperDrag = function(moving, scaling)
	{
		if(moving){$("#TLindicator").show();return;} // show the indicator when moving or scaling
		if(scaling)
		{
			var height = 15;
			var topAlign = -35;
			$("#WHindicator").show();
			$("#widgPosDragHelper").css("top",topAlign);
		}
	};
	
	
	widget.getRootsForDrag = function($this)
	{
			widget._activeGroup = false;
			
			var widgetGroups = project.get("widgetGroups");
			var roots = widget.getRoots($this);
			if(widgetGroups)
			{
				var selArray = group.createSelArray(roots,widgetGroups);
				if(selArray.length == 1 && selArray[0].charAt(0) == 'g')
				{
					widget._activeGroup = selArray[0];
				}
				
				roots.each(function()
				{		
					var id = $(this).attr("id");
						
					for(var i in widgetGroups)
					{
						var grp = widgetGroups[i];
						var memberCheck = grp.indexOf(id);
						if(memberCheck > -1)
						{
							for(var j = 0; j < grp.length; j++)
							{
								var t = $("#" + grp[j]);
								roots = roots.add(t);
							}
						}
					}
				});
			}
		
		return roots;
	};
	
	widget._moveMultiSelection = null;
	widget._dragStart = function(e, ui, $this)
	{
		var $this = $($this);		
		widget.draggingFromId = $this.parents('.screen').attr('id');
		widget._originalDragPos = $this.offset();
        widget._dragStartSelection = [];
        $('.ui-selected').each(function() {
            widget._dragStartSelection.push($(this).attr('id'));
        });

        $this.parents('.screen').addClass('dragging-wdg-from');
		
		if( $this.hasClass("ui-selected") || $("#" + $this.attr("data-lockto")).hasClass("ui-selected"))  // if its selected, add all the other selected widgets for dragging.
		{
			$this = $this.add($(".ui-selected")); 
		}
	
		//if you are selecting a group, add all the roots that belong to the group
		var roots = widget.getRootsForDrag($this);
		widget.resetSelection();
		
		widget._moveMultiSelection = (roots.length > 1) ? true : null;
		widget.select(null, roots);
		
		var snapToGrid = account.get("gridStatus");
		var snapToWidget = account.get("snapToWidget");
		if(snapToGrid == 'on' || snapToWidget == 'on')
		{
			snap.setMovementConstant($this,ui,snapToGrid);		
			if(snapToWidget == 'on') 
			{
				grid.getPageProps();
				snap.selectedWidgSnapPos();
				snap.multiSelOffset(widget._originalDragPos);
			}
		}
		
		contextMenu.place("hide");
        page.displayMenu(false);
		$("#canvasLinks").hide();
		widget._dragSelection = $([]);
	
		$(roots).not(".backgroundWidget").each(function()
		{
			var locked = $('[data-lockto="' + $(this).attr("data-lockto") + '"]'); 
			widget._dragSelection = widget._dragSelection.add(locked);
		});	

		widget._dragSelection.each(function() //.not(this)
		{
			var $t = $(this); 
			$t.data("offset", $t.offset());   // save the data so it can be doubly dragged.
			$t.addClass("ui-draggable-dragging");
			$t.resizable("option", "disabled", true); 
		});
	};

	widget.lastTime = null;
	widget._drag = function(e, ui, $this)
	{
		$this = $($this);

		var top = $this.data().draggable ? $this.data().draggable.position.top : parseInt($this.css('top'), 10);
		var left = $this.data().draggable ? $this.data().draggable.position.left : parseInt($this.css('left'), 10);
		//console.log("SDG", top,left);
		var snapToWidget = account.get("snapToWidget");
		if(snapToWidget == 'on'){snap.snapToWidgEdges($this,top,left);}
	
		var snapToGrid = account.get("gridStatus");
		if(snapToGrid == 'on'){snap.widgetSnapToGrid($this,top,left);}

		function moveOtherSelectedWidgets()
		{
			var offset = $(this).data("offset");  // the offset at the start of the drag.
			$(this).css({top: offset.top + dt + "px", left: offset.left + dl + "px"});
		}
		
		var dt = ui.position.top - widget._originalDragPos.top;
		var dl = ui.position.left - widget._originalDragPos.left;	
		var sel = (widget._dragSelection).not($this);
			
		$.each(sel, moveOtherSelectedWidgets);
			
		updateTLWH();	
		var moving = true;
		widget.posScaleHelperDrag(moving);
	
		intersectTrash($this, e); // highlight the trash if hovering*/

		var selectedWidgets = document.querySelectorAll('.pageWidget.ui-selected'),
			activePage = ((activePage = document.querySelector('.canvasObject.active')) && activePage.id);

		fluid.util._.forEach(selectedWidgets, function (widgetElement) {
			var w = widgetElement.id;

			if (storage.get(w).blur) {
				widget.blurLayers[w] = widget.blurLayers[w] || widget.renderBlurLayer(w, activePage.id);

                widget.setBlurBG(widgetElement);
			}
		});
	};

	// use a pre instantiated selection. 
	widget._dragStop = function(e, ui, $this)
	{
		snap.removeAlignGuides();
		//console.log("stopping drag");
		if( intersectTrash($this, e) ) // Dropped it on the bin
		{
			widget.del(".ui-selected");
			$('#trash').removeClass('droppableStyle');
            widget._dragSelection = null;
            return;
		}
		
		function restoreSelectionStatus()
		{
			var $item = $(this);
			
            $item.removeClass("rememberSelected"); // show the resize handles again.
            (widget._moveMultiSelection == true) ? $item.resizable("option", "disabled", true) : $item.resizable("option", "disabled", false);
            $item.removeClass("ui-draggable-dragging");
		}

		var selection = $("#canvasPages .ui-selected");
		var selRoots = widget.getRoots(selection);
		var toPage = selRoots.parents('.screen').attr('id');
        $('#'+widget.draggingFromId).removeClass('dragging-wdg-from');		// TODO: not the right place to issue the command from; should be fixed later when working on code structure
		// TODO: not the right place to issue the command from; should be fixed later when working on code structure
		fluid.command.create('move', {
			id: selRoots.map(function() { return $(this).attr('id'); }).get(),
            fromPage: widget.draggingFromId,
            toPage: toPage
		}).dispatchTo('fluid.controllers.widget');
		group.select(selRoots);
        widget.draggingFromId = null;

		//widget._savePosition(selRoots); // replaced by command
		widget.selectMulti = false;
		if(widget._dragStartSelection.length) $.each(widget._dragSelection, restoreSelectionStatus);

		$("#widgPosDragHelper").remove(); //remove the resize helper
		
		$("#canvasLinks").fadeIn(200);
        if(widget._dragStartSelection.length) {
            contextMenu.place();
        } else {
            page.displayMenu();
            $('.ui-selected').removeClass('ui-selected');
        }

		widget._dragSelection = null;

	};

	// triggered by the drop on canvas position and now drag stop
	// only update the root positions now. 
	// separate this out and use it for nudge too?
	widget._savePosition = function(sel)
	{
		//console.log("saving position");
		
		function updatePosition(index, obj) // Not % ads or segments. Loses % value if it has one. Root only. 
		{
			var wId = $(obj).attr('id');
			var wObj = widget.get(wId);
			var tlwh = $.extend([], wObj.tlwh); 
			tlwh[0] = parseInt( $(obj).css("top") );
			tlwh[1] = parseInt( $(obj).css("left") );	
			widget.set({tlwh : tlwh}, wId);
		}
	
		$.each(sel, updatePosition);
	};
	
	widget._libraryDrag = function (e, ui, $this)
	{
		$this = $($this);
		$this.data().draggable.position.top -=3;
		$this.data().draggable.position.left -=3;
		/*
		var snapToGrid = account.get("gridStatus"); //SNAP DRAG FROM LIBRARY
		if(snapToGrid == 'on') { snap.libraryWidgDrag(ui,$this); }
		*/
		//var wid = widget.get( $this.attr("id"));

		if($this.parents("#widgetGroupUploads").length == 1)
		{
			intersectTrash($(ui.helper), e);
		}
	};
	
	/*widget._libraryDragStop = function (e, ui, $this)
	{
		console.log("dragging from library",$this);
		$this = $($this);
		
	}*/
	
	widget.moveTo = function(id, tl) {
		var obj = widget.get(id);
		widget._moveBy(id, obj, [tl[0] - obj.tlwh[0], tl[1] - obj.tlwh[1]]);
	};

	widget._moveBy = function(id, obj, tl, options) {
		$('[data-lockto="' + id + '"]').css({"top": "+=" + tl[0], "left": "+=" + tl[1]});
		link.update($('#' + id).parent('.screen'));

		if(!(options && options.debounce)) {
			obj.tlwh[0] += tl[0];
			obj.tlwh[1] += tl[1];
			widget.set({tlwh: obj.tlwh}, id); // save it
		} else {
			if(!widget.adjustWdgPosDebounced)
				widget.adjustWdgPosDebounced = fluid.util._.debounce(widget.adjustWdgPos, 500);

			widget.adjustWdgPosDebounced(id);
		}

	};

	widget.adjustWdgPos = function(id) {
		//var wdgObj = widget.get(id);
		var selRoots = widget.getRoots($(".ui-selected")),
			fromPos = [],
			toPos = [];

		selRoots.each(function() {
			var $this = $(this),
				thisObj;

			thisObj = widget.get($this.attr('id'));

			toPos.push([parseInt($this.css('top')), parseInt($this.css('left'))]);
			fromPos.push([ thisObj.tlwh[0], thisObj.tlwh[1] ]);

		});

		fluid.command.create('move', {
			id: selRoots.map(function() { return $(this).attr('id'); }).get(),
			fromPage: widgetsCache[id].pageId,
			toPage: widgetsCache[id].pageId,
			fromPos: fromPos,
			toPos: toPos,
			skipViewAdjustment: true
		}).dispatchTo('fluid.controllers.widget');
	};

	widget.nudge = function(e)
	{
		return widget._nudge(e);
	};

	
	widget._nudge = function(e)
	{
		//console.log("getting the nudge key",shiftKey);
		var key = e.keyCode;
		var distance = (e.shiftKey || e.ctrlKey) ? 10 : 1;	
		
		storage.cacheStart();	 // can be slow, save all writes till deselect	
		var sel = $(".ui-selected").not(".backgroundWidget");
		var roots = widget.getRoots(sel);
		if (sel.children('textarea').length > 0)
		{
			return false;
		}
		roots.each(function() 
		{
			var id = $(this).attr("id");
			var tl = [0, 0];

			switch(key)
			{
				case 'left': 	case 37:  tl[1] = -distance; break; 
				case 'up': 		case 38:  tl[0] = -distance; break;
				case 'right': 	case 39:  tl[1] = +distance; break;	
				case 'down': 	case 40:  tl[0] = +distance; break;
			}

			widget._moveBy(id, widget.get(id), tl, {debounce: true});
		});

		updateTLWH();
	};
	
	widget._changePage = function(sel, fromPage, toPage)
	{
		var sel = sel.not(".backgroundWidget"); //exclude backgrounds from being moved
		//console.log(sel);
		var all = widget.getLockTos(sel); // all objects will be moved. 
		var removedWidgets = $.extend([], page.get(fromPage, 'widgets'));
		var addedWidgets   = $.extend([], page.get(toPage, 'widgets'));

		all.each(function()
		{
			var pos = $.inArray($(this).attr("id"), removedWidgets);
			if(pos == -1){return true;} // this is really bad
			removedWidgets.splice(pos, 1);
			addedWidgets.push($(this).attr("id"));
		});
		
		page.update({widgets : removedWidgets}, fromPage);
		page.update({widgets : addedWidgets}, toPage);
		
		var topDiff =   page.get(toPage, 'y') - page.get(fromPage, 'y');
		var leftDiff =  page.get(toPage, 'x') - page.get(fromPage, 'x');
		all.detach().css({top: "-=" +  topDiff, left: "-=" + leftDiff}).appendTo( $("#" + toPage).find(".widgetHolder"));
		if( widget._dragStartSelection.length ) {
            page.activate( $("#" + toPage), false, 'wdgDrag' );

        } else {
            page.activate( $("#" + toPage), true );
            setTimeout(widget.resetSelection, 300);
        }

		group.drawExisting();
	};

	
	
	
 var ajax = 
 {
 	maxSyncRetryCount : 2,

	// whenever a form on the site is submitted (other than login). 
	submit : function(e)
	{
		//console.log("Submitted a form.", e);
		//utils.prevent(e);
		var $this = $(this);
		var $id = $this.attr("id");
        var isCreateForm = $this.hasClass("createForm");
        var isShareSendMail = $this.hasClass("shareSendMail");

		// security check the form is a valid one we've created.
		if ($id != 'feedbackForm'
			&& !isCreateForm
			&& !(isShareSendMail && $('.shareSend').attr('disabled') === undefined)
			&& $id !== 'upgradeForm' && $id !== 'errorContact' )
		{
			//console.log("Invalid form submitted:", $id);
			return false;
		}
	
		if($this.find(":submit").hasClass("inactive"))
		{
			//console.log("cant submit inactive form.");
			return false;
		}
		
		var numInputs = $this.find("input").not(":hidden, :submit").length;
		var correctInputs =  $this.find(".formCorrect").length;
		
		if(isShareSendMail) // TODO: This is insecure.
		{
			fluid.main.fire('beforeShareMail');

			//$this.find("[name=p]").val(document.location.href + "?p=" + account.get("lastOpenProject") + "&preview=y" ); 
			//var url = document.location.href + "preview/" + project.get("id") + "." + project.get("updated");
			// document.location.href + "preview/" + 
			//var url = project.get("id") + "." + project.get("updated");
			//$this.find("[name=p]").val(url);
		}		
		
		if(numInputs == correctInputs)
		{
			$this.find(":submit").val("Sending...").removeClass("accept").addClass("inactive");	
		}
		else
		{
			$this.find(":submit").removeClass("accept").addClass("inactive");
		}

        try
        {
            tracker.record("Submitting Form", 1, $id, e);
        }
        catch(e) { }

		var data = $this.serialize();
		$.ajax({url: "./index.php",type: "POST", data: data, complete: ajax.complete, error: ajax.error });	
		return false;
	},
	
	//sends a data packet to the server with associated values.
	syncUp : function(data, type, objectId, callback, retriesLeft)
	{
		//console.log("Called ajax.syncUp", data, type, objectId);
		if (objectId)
		{
			account.syncPending[objectId] = type;
		}
		else if (type == 'projectSync' || type == 'imageSync')
		{
			// The following is to try to figure out where empty object ids are coming from.
			// TODO: remove when done

			var message = 'Empty object ID. Type: ' + type + '.';

			try {
				please.show.me.call.stack();
			} catch (e) {
				if ('stack' in e) {
					message += ' Call stack: ' + e.stack;
				}
			}

			throw message;
		}
		
		var data2 = JSON.stringify(data);
		var data3 = {t: type, data: data2, objectId: objectId};
	
		$.ajax({
			url: "./index.php",
			type: "POST",
			data: data3,
			success: function(result, textStatus, jqXHR)
			{
				var resultData = JSON.parse(result);
				if (resultData.r == 'f' && resultData.t == 'retry')
				{
					// failed to post; retry request up to max retry count
					if (retriesLeft === undefined)
						retriesLeft = ajax.maxSyncRetryCount;

					if (retriesLeft > 0) {
						//console.log('Retrying syncUp');
						ajax.syncUp(data, type, objectId, callback, --retriesLeft);
						return;
					}
				}

                //console.log("Data After ajax success: ", result, textStatus, jqXHR);
				ajax.syncSuccess(result, textStatus, jqXHR, type, objectId);
				if ($.isFunction(callback))
				{
					callback(result);
				}
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				ajax.syncError(jqXHR, textStatus, errorThrown, type, objectId);
			},
			complete: function(jqXHR, textStatus)
			{
				ajax.syncComplete(jqXHR, textStatus, type, objectId);
			}
		});
	}, 
	
	syncDown : function(objectId, unloaded, callback, errorCallback)
	{
		if ($.isFunction(unloaded))
		{
			errorCallback = arguments[2];
			callback = arguments[1];
			unloaded = false;
		}

		//console.log("Downloading", objectId);		
		var multiple = $.isArray(objectId);
		var data = {t: "syncDown", objectId: multiple ? objectId.join(',') : objectId, multiple: multiple};
		if (unloaded)
		{
			data.unloaded = true;
		}

		$.ajax({url: "./index.php", type: "POST", data: data, success: callback, error: errorCallback || ajax.syncError });
	},

	snapshot: function(objectId, type, callback)
	{
		var data = {t: "snapshot", objectId: objectId, type: type };
		$.ajax({url: "./index.php", type: "POST", data: data, success: callback, error: ajax.snapshotError });
	},
		
	remove : function(objectId, callback)
	{
		var data = {t: "remove", objectId: objectId};
		$.ajax({url: "./index.php", type: "POST", data: data, success: callback, error: ajax.syncError });
	},
	
	restore : function(objectId, callback)
	{
		var data = {t: "restore", objectId: objectId};
		$.ajax({url: "./index.php", type: "POST", data: data, success: callback, error: ajax.syncError });
	},
	
	syncSuccess : function(data, textStatus, jqXHR, type, objectId)
	{
        //console.log("Sync success!", type, objectId, data, textStatus);
		switch(type)
		{
			case 'imageSync':
				var res = account.findUpload(objectId);
				if (res)
				{
					tracker.record("ImageUploaded", 1);
					res.upload.s = true;
				}
				break;
			
			case 'emailRegd':
				account.emailChecked(data);
				break;

            case 'accountState':
				//console.log("AccountState result:", jqXHR.responseText);
                var result = $.parseJSON(jqXHR.responseText);

				if(result.r === 's') $('body').addClass('signed-in');
				else $('body').removeClass('signed-in');
                account.requireRefresh(result);
                break;
		}
	},
	
	syncError : function(jqXHR, textStatus, errorThrown, type, objectId)
	{
		//$("<div>An unknown error has occurred</div>").appendTo($("#livePreview .widgetHolder"));
		//console.log("Ajax syncError happened", jqXHR, textStatus, errorThrown, type, objectId);
	},
	
	syncComplete : function(jqXHR, textStatus, type, objectId)
	{
		if (objectId)
		{
			delete account.syncPending[objectId];
		}
	},

	
	complete : function (jqXHR, textStatus) 
	{
		var result;
		try
		{
			result = $.parseJSON(jqXHR.responseText);
		}
		catch(e)
		{
			//console.log("No json returned");
			return false;
		}
		
		//console.log("Result of form", jqXHR, textStatus, result);

		switch(result.a)
		{
            case 'contact' : upgrade.errorSubmitted(result);break;
			case 'feedback': fluidMenu.feedbackAjaxResponse(result); break;
			case 'login': account.login(result);break; // this can happen even when the submitted action is signup!
			case 'previewMail': share.actionMailSent(result); break;
		}
		return false; // prevent a refresh
	},
	
	// TODO: this is temporary (maybe not)
	apiCall : function(objType, op, id, data, successCallback, errorCallback)
	{
		var ajaxParams = {},
			originalData = data;

		if (data instanceof Blob) { // files are also instances of Blob
			var fd = new FormData();
			fd.append('file', data);
			data = fd;

			op = 'post';

			ajaxParams = {
				processData: false,
				contentType: false
			};

			account.syncPending[id] = objType;
		}

		//console.log("Setting type", op ? op.toUpperCase() : 'POST');

		$.ajax($.extend(ajaxParams, {
			url: this.apiObjectUrl(objType, id),
			type: op ? op.toUpperCase() : 'POST',
			data: data,
			success: function(data, textStatus, jqXHR)
			{
				if (op == 'post')
				{
					var res = account.findUpload(id);
					if (res)
					{
						res.upload.s = true;
						account.uploadSynced(id, true);
					}
				}
				
				if ($.isFunction(successCallback))
				{
					successCallback(data, id, originalData);
				}
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				ajax.syncError(jqXHR, textStatus, errorThrown, objType, id);
				
				if ($.isFunction(errorCallback))
				{
					errorCallback(data, id, originalData);
				}
			},
			complete: function(jqXHR, textStatus)
			{
				delete account.syncPending[id];
			}
		}));
	},
	
	apiObjectUrl : function(objType, id)
	{
		var ret = 'data/' + objType + (id ? '/' + id : '');
		//console.log("API call:", ret)
		return ret;
	},

    sendMessage : function(from, subject, message, callback, callbackError)
    {
        var info = { from: from, subject: subject, message: message };
        var dataSend = { t: "contact", data: JSON.stringify(info) };

        $.ajax({
            url: "index.php",
            type: "POST",
            data: dataSend,
            success: function(data, textStatus, jqXHR)
            {
                if ($.isFunction(callback))
                {
                    callback();
                }
            },
            error: function(jqXHR, textStatus, errorThrown)
            {
                if ($.isFunction(callbackError))
                {
                    callbackError();
                }
                else if ($.isFunction(callback))
                {
                    callback();
                }
            }
        });
    },

    userSettingsRequest : function(info, type, callback, asPlainFormData)
    {
        var dataSend = asPlainFormData ? $.extend({t: type}, info) : { t: type, data: JSON.stringify(info) };

        $.ajax({
            url: "index.php",
            type: "POST",
            data: dataSend,
            success: function(data, textStatus, jqXHR)
            {
                if ($.isFunction(callback))
                {
                    callback(data);
                }
            },
            error: function(jqXHR, textStatus, errorThrown)
            {
                if ($.isFunction(callback))
                {
                    callback(null, errorThrown);
                }
            }
        });
    }
}


jQuery.fn.liveDraggable = function (opts) 
{
	this.live("mouseover", function() {
		if (!$(this).data("initDraggable")) {
            //Add Draggable to active page ONLY after adding Selectable
            var isPageActive = $(this).hasClass("screen") && $(this).hasClass("active");
            if ((project.get("currentZoom") < 1) || (!isPageActive) ||
                ((isPageActive) && ($(this).data("initSelectable")))) {
			    $(this).data("initDraggable", true).draggable(opts);
            }
            canvas2.setPageContainment(this);
		}
	});
	return $(this);
};

jQuery.fn.liveSelectable = function (opts)
{
	this.live("mouseover", function() {
		if (!project.readOnly() && !$(this).data("initSelectable")) {
			$(this).data("initSelectable", true).selectable(opts);
		}
	});
	return $(this);
};

/* Going to do this one on select...
jQuery.fn.liveResizable = function (opts) 
{
    this.live("mouseover", function() 
	{
       if (!$(this).data("initResizable")) 
	   {
          $(this).data("initResizable", true).resizable(opts);
       }
    });
};	

*/

// Memory manager class. 

// objects in temp storage are stored as objects. 
var storage =
{
	tempStorage : {}, //non disk bound copy of everything for speed. 
	cachedUpdates : {}, // for saving disk writes. 
	caching : false, 
	//storageCleared: false,
	lastUpdate : new Date().getTime(),

	//gets an object from localStorage
	get: function(id)
	{
		//console.log("Asked for id in storage", id);

		if(storage.tempStorage[id])
		{
			//var ret = storage.tempStorage[id];
			//console.log("Returning in get", ret, id); // , pages
			return storage.tempStorage[id]; // return the object.
		}

		if(localStorage)
		{	
			var item = localStorage.getItem(id);
			if(item)
			{
				//console.log("Found in localstorage", id, storage.tempStorage, item);
				storage.tempStorage[id] = JSON.parse(item);
				return storage.tempStorage[id];
			}	
		}
		
		//var item = storage.loadFromSever(id);
		//if(item)
		//{
		//	return item;
		//}
		// get from server...?
		
		return null;
	},
/*  2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
	reget: function(id)
	{
		var item = localStorage.getItem(id);
		if(item)
		{
			storage.tempStorage[id] = JSON.parse(item);
			return storage.tempStorage[id];
		}
		
		return null;
	},*/
	
	tabSynchronisationCheckInterval : 3000,     //3 sec.  Test value
	lastTabSynchronisationCheck : null,
	//instanceId : g_instanceId, // local for speed
	// passed in non encoded (object) format
	set: function(id, obj, changeUpdateTime)
	{
        var update = changeUpdateTime == undefined ? true : changeUpdateTime;
		// when setting something, we want to make sure its the most recent version locally if we havent checked in 1 seconds
		if(this.lastTabSynchronisationCheck + this.tabSynchronisationCheckInterval < new Date().getTime()) // no need to check every time?
		{
			var savedInstanceId = localStorage.getItem("instanceId");
			
			//console.log("tabsyncCheck says time to check instanceIds - ", savedInstanceId, g_instanceId);
			
			//console.log("== Checking for other tabs for this user, IDs:", savedInstanceId, g_instanceId);
			if(savedInstanceId && parseInt(savedInstanceId) != g_instanceId)// if saved instance id != current instance id, another tab has made a change in localstorage - refresh
			{
				var needToRestoreInstanceId = localStorage.getItem("restoreMyInstanceId");
				if(needToRestoreInstanceId) // we logged out/reset from a different tab.
				{
					//console.log("Instance restored:", g_instanceId);
					storage._setItem("instanceId", g_instanceId);
					localStorage.removeItem("restoreMyInstanceId");
					return;	 // dont execute the actual change.
				}

				//console.log("==== Setting postload", savedInstanceId, g_instanceId, localStorage.getItem("instanceId"));
				storage._setItem("postloadMessage", "tab");
				location.reload();
				return;	 // dont execute the actual change.
			}	
		}

		if(typeof(obj) == "string") // handle string
		{
			obj = JSON.parse(obj);
		}

        //DA: Feb-23-2013 - Commented out to remove the obj.update from the list
        //storage.lastUpdate = this.lastTabSynchronisationCheck = obj.updated = new Date().getTime(); // set the date of the last modification.
        storage.lastUpdate = this.lastTabSynchronisationCheck = new Date().getTime(); // set the date of the last modification.
		if ((obj) && (update))
		{
			obj.updated = storage.lastUpdate;
		}
		
		var json = JSON.stringify(obj);
		
		try
		{			
			if(this.caching)
			{
				this.cachedUpdates[id] = obj;
			}
			else // write it immediately. 
			{
                //console.log('saving: ', id, {obj: obj, json: json})
				storage._setItem(id, json);
			}
			this.tempStorage[id] = obj;
		}
		catch(e)
		{
			//console.log("Local storage memory exceeded or another error\n", e, id, obj, json);
		}

        fluidEvent.triggerEditor("storageChanged", { id: id, obj: obj, timeUpdated: update });
	},
	
	remove : function(id)
	{
		delete this.tempStorage[id];
		delete this.cachedUpdates[id];
		localStorage.removeItem(id);
	},
	
	cacheStart : function()
	{
		//console.log("Caching started - delaying disk writes.");
		this.caching = true;
	},
	
	commitCache : function()
	{
		//console.log("Caching set to off - committing all disk writes.");
		if(!this.caching) // is this even needed?
		{
			//console.log("Caching is off, returning.");
			return;
		}
		this.caching = false;

		for(var i in this.cachedUpdates)
		{
			this.set(i, this.cachedUpdates[i]);
			delete(this.cachedUpdates[i]);
		}
	},
	
	// when previewing, we dont save to localstorage!
	setTempItem : function(id, data)
	{
		this.tempStorage[id] = data;
	},
	
	removeItem : function(id)
	{
		localStorage.removeItem(id);
	},
	
	clear : function()
	{
		//console.log("Clearing localstorage.");
		tempStorage = {};
		cachedUpdates = {};
		localStorage.clear();
	},

//    //this is only meant to be run before switching between projects to prevent localstorage filled
//    clearPagesAndWidgets: function() {
//        for(var prop in localStorage) {
//            if(localStorage.hasOwnProperty(prop)) {
//                if(prop[0] === 'w' || prop[0] === 'x') {
//                    localStorage.removeItem(prop);
//                }
//            }
//        }
//    },

    /*  2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
	//DA: 09-Mar-2012: Clears all data from a specific Object
	//This method doesn't remove the property id
	//objID: Object's ID
	//obj:  Object to be emptied
	emptyObject: function(objID, obj)
	{
		//Get Object when only the ID was passed
		if ((!obj) && (objID))
		{
			obj = storage.get(objID);
		}
		//Empty all properties except the property id and save the changes
		if (obj)
		{
			for (var p in obj)
			{
				if (p != 'id')
				{
					delete obj[p];
				}
			}
			storage.set(objID, obj);
		}
		return obj;
	},*/

	_setItem: function(id, data)
	{
		var success = false;
		while(!success)
		{
			try
			{
				localStorage.setItem(id, data);
				success = true;
			}
			catch(e)
			{
				if (e && (e.name == 'QUOTA_EXCEEDED_ERR' || e.name == 'NS_ERROR_DOM_QUOTA_REACHED' || e.code === 22))
				{
					// local storage overflow
					project.unloadOldest();
				}
				else
				{
					throw e;
				}
			}
		}
	}
	
	// is this used?
	/*
	getfromSever : function(respData, textStatus, jqXHR) // ajax response.
	{
		try
		{
			var proj = JSON.parse(jqXHR.responseText); // jqXHR.response does not work on iOS mobile.
		}
		catch(e)
		{
			return null;
		}
		try // this can fail if the project is too big. 
		{
			var data = JSON.parse(proj.t.toString()); // TODO: simplify this so it doesnt need a double parse.
		}
		catch(e)
		{
			return null;
		}
		for(var key in data)
		{
			if(storage.tempStorage[key] == null)
			{
				storage.setTempItem(key, data[key]);
			}
			if(localStorage.get(key) == null)
			{
				localStorage.setItem(key, data[key]);
			}	
		}	
	}
	*/
};




var project = 
{
	isInitialized: false,
	isModified: false,
	activeProjectTooltip : '',
	autoPreviewTimeout : 300000,
	inactiveProjectTooltip : 'This project is inactive. Editing is disabled.',
	colors : {
		hStart : 5,
		hEnd : 210,
		s : '90%',
		l : '50%'
	},
	unloadedProps : ['name', 'created', 'updated', 'active', 'preview'],
	recentProjectDays : 15,         //Indicates the amount of days for a project to be considered recent
    lastProjectClosed : false,
	
	// Change the screen orientation of the entire project.
	orient : function(e, orientation)
	{
		//var pg = $(this).closest(".screen").attr("id"); // called from page menu, get the page that waas acted on.
		var orientation = e != undefined ? $(e.target).attr("data-for") : orientation;
		var screenWH = project.get("pageWH");
        var dim1 = parseInt(screenWH[0], 10);
        var dim2 = parseInt(screenWH[1], 10);
        var min = Math.min(dim1, dim2);
        var max = Math.max(dim1, dim2);
        screenWH = orientation == "Portrait" ? [min, max] : [max, min] ;

		project.set({ orientation: orientation}); // set the orientation of the project.
		project.set({ pageWH : screenWH}); // reverse the pageWH's

		var p = project.get("pages");
		for(var i in p) {
            //Set the WH reversed, this will be transformed in the resizeAfterOrient method
            page.update({orientation: orientation, width: screenWH[1], height: screenWH[0]}, p[i]);
		}

		$(".screen").each(page.resizeAfterOrient);	// Calculate correct size for each page.
		hint.show("library");
		page.updateOptionsMenu();
	},

	isMultiOrientation : function()
	{
		var pages = project.get("pages");
		var projectOrient = project.get("orientation");
		var multiOrient = false;

		for (var idx = 0, len = pages.length; idx < len; idx++)
		{
			var orient = page.get(pages[idx], "orientation");
			if (orient != projectOrient)
			{
				multiOrient = true;
				break;
			}
		}

		return multiOrient;
	},
	
	setNumber : function(activeCount, inactiveCount)
	{
		//console.log("Setting number of projects", account.get('projectIds'), account.get('projectIds').length); console.trace();
		if (activeCount === undefined || inactiveCount === undefined)
		{
			activeCount = 0;
			inactiveCount = 0;
			
			var projects = account.get("projectIds");
			for(var idx = 0, len = projects.length; idx < len; idx++)
			{
				var proj = storage.get(projects[idx]);
				if (proj)
				{
					if (proj.active === false)
					{
						inactiveCount++;
					}
					else
					{
						activeCount++;
					}
				}
			}
		}
		
		$("#projectList h2").text('Active Projects' + (activeCount > 0 ? ' (' + activeCount + ')' : ''));
		$("#inactiveProjectList h4").text('Inactive Projects' + (inactiveCount > 0 ? ' (' + inactiveCount + ')' : ''));
		var total = (activeCount + inactiveCount);
		var projectsLabel = total == 1 ? "1 Project" : total + " Projects";
		var projectSettingBtn = $(".projectSettingsButton");
		$('.projectSettingsButton span').text(projectsLabel);
		projectSettingBtn.removeClass("buttonDisabled");
        $("#logout").removeClass("hidden");
	},
	
	// css only?
	hoverIn : function()
	{

		$(this).children(".foreground").addClass("projectHover");
		$(this).children(".popOutPage").addClass("popOutPageHover");
	},
	
	// css only?
	hoverOut : function()
	{
		$(this).children(".foreground").removeClass("projectHover");
		$(this).children(".popOutPage").removeClass("popOutPageHover");
	},	
	
	// make this draw in project creation order. 
	_template: function(dataObject, id) // draws the project html and inserts it at the correct location.
	{
		//console.log("Templating a project.", this, arguments);console.trace();
		dataObject['id'] = id;
		//var d = new Date(dataObject['created']);
		//var today = new Date();
		//var date = d.getDate() + "/" + (d.getMonth()+1) + "/" + d.getFullYear();
		//dataObject['date'] = moment(dataObject.created).format("DD/MM/YYYY");
        dataObject['name'] = dataObject.name || "New Project";
		dataObject['date'] = fluid.i18n.formatDate(dataObject.created);
		dataObject['dateCreate'] = moment(dataObject.created).format("YYYY/MM/DD HH:mm:ss");
		dataObject['dateUpdate'] = moment(dataObject.updated).format("YYYY/MM/DD HH:mm:ss");
		dataObject['tooltip'] = dataObject.active === false ? project.inactiveProjectTooltip : project.activeProjectTooltip;
		dataObject['nameLower'] = dataObject.name.toLowerCase();

		//var tmpl = $("#tmplProject").tmpl(dataObject);
		var tmplThumb = $("#tmplProjectThumb").tmpl(dataObject);


		if (dataObject.active === false)
		{
			tmplThumb.addClass("inactivePrj");
//			tmpl.
//				addClass('inactiveProject').
//				insertAfter('#inactiveProjectList .promptContainer');
		}
		else
		{
			tmplThumb.addClass("activePrj");
//			tmpl.
//				insertAfter(".addProject").
//				find(".title").
//				focus().
//				select();
		}


		tmplThumb.insertAfter("#projectAdd");
		projectSettings.updateThumbnail(id);

//		if (id == account.get("lastOpenProject"))
//		{
//			tmpl.addClass('open');
//		}

		//Remove values created temporarily for calculations
		delete dataObject['dateCreate'];
		delete dataObject['dateUpdate'];
		delete dataObject['nameLower'];

		return tmplThumb;
	},

	hasWidgets : function()
	{
		var open = account.get("lastOpenProject");
		var proj = storage.get(open);
		var response = false;
		if ((proj) && (proj.pages))
		{
			$.each(proj.pages, function(index, item){
				var widgets = page.get(item, "widgets");
				if ((widgets) && (widgets.length > 0))
				{
					response = true;
					return false;
				}
			});
		}
		return response;
	},

	hasLinks : function()
	{
		var links = project.get("links");

		if ((links) && (links.linkOrigin.length > 0))
		{
			return true;
		}

		return false;
	},
	
	get : function(name)
	{
		var open = account.get("lastOpenProject");
		if(name == 'id') return open;

		var proj = storage.get(open);

		if(!proj)
		{
			if(name == "pages")
			{
				return [];
			}
			return null;
		}
		return proj[name];
	},
	
	set : function (obj) //field, setting
	{
		//console.log("SettingProj", obj);
		//console.trace();

		var id = account.get("lastOpenProject");

		project.loadIfUnloaded(id, function() {  // TODO: can lastOpenProject be unloaded?
			var proj = storage.get(id);
			if(!proj) return;
			for (var o in obj)	// if its an object, update them all? 
			{
				proj[o] = obj[o];
			}
			//proj.updated = new Date().getTime(); // done for all objects now!
			storage.set(id, proj);
		});
	},

	//reuse the existing size changers.
	/*setDevice : function(e)
	{
		var selectedOp = $("option:selected", $(this));
		project.set({"deviceModel" : selectedOp.attr("data-type")});
		if (selectedOp.val() != "Custom")
		{
			var wh = selectedOp.val().split(",");
			$.each(wh, function(i,v){ wh[i] = parseInt(v);} );
			project.changeScreenSize(null, wh);
		}
		page.updateOptionsMenu();
	},*/
	
	changeScreenSize : function (e, wh)
	{
		// we dont know which one changed, so just get them from root.		
		if(typeof wh === "object") {
			var width = wh[0];
			var height = wh[1];
		} else {
			var width = parseInt($(".screenSize").filter(".width").val());
			var height = parseInt($(".screenSize").filter(".height").val());
		}
		
		//console.log("Changing From: " + project.get("pageWH").join("x") + ". To: " + width + "x" + height);
		var minWidth = 50;
		var minHeight = 50;

		if ((isNaN(width)) || (isNaN(height)))
		{
			width = project.get("pageWH")[0];
			height = project.get("pageWH")[1];
			$(".screenSize").filter(".width").val(width);
			$(".screenSize").filter(".height").val(height);
		}
		else
		{
            width = width < minWidth ? minWidth : width;
            height = height < minHeight ? minHeight : height;

			//console.log("Setting project wh", [width, height]);
            width = parseInt(width, 10);
            height = parseInt(height, 10);
			project.set({"pageWH" : [width, height]});


            var orientation = height >= width ? "Portrait" : "Landscape";
            project.orient(null, orientation);

            /*  All this code was replaced with the call to project.orient
                This includes auto adjust to the project orientation after
                adjusting the project dimensions
			$(".screen").css({width: width, height: height});


			//var width = $(".pageSize").filter(".width").val();
			//var height = $(".pageSize").filter(".height").val();

			// make sure each page has there minimum dimensions.
			$(".page").each(function()
			{
				var id = ($(this).attr("id")).substring(5);

				var pWidth = parseInt(page.get(id, "width"));
				var pHeight = parseInt(page.get(id, "height"));
				var projectOrientation = project.get("orientation");
				var pageOrientation = page.get(id, "orientation");

				//DA:11-Mar-2012: Get The proper minimum dimensions as a reference to resize page
				var currentWHReferences = [ width, height ];
				if (projectOrientation != pageOrientation)
				{
					currentWHReferences = [ height, width ];
				}
				//var numWidgets = $(this).children(".widgetHolder").children().length;
				//console.log("Resizing page", id, currentWHReferences[0] , pWidth, currentWHReferences[1] , pHeight);

				//DA:11-Mar-2012: If the page has dimensions smaller than the screen, resize the page with its current dimensions
				//The resize method will take care of making the minimum dimensions consistent
				//if((currentWHReferences[0] > pWidth) || (currentWHReferences[1] > pHeight) || numWidgets == 0 )
				//{
					//page.resize(id, pWidth, pHeight);
					page.resize(id, currentWHReferences[0], currentWHReferences[1]);
				//}

                if( $(this).parents('.screen').hasClass('active') && project.get('currentZoom') === 1 ) {
                    page.drawDetailed(id, "init");
                } else {
                    page.draw(id, "init");
                }

			});
            */

			//$(".page").css({"min-width": width, "min-height": height});
			//console.log("getting the screen width",width, height);
			//var projectWh = [width , height];
			//grid.changePageDimsManually(projectWh);
		}
		hint.show("library");
		staticWidgets.zoomInBoundary();

	},
	
	// get rid of this guy.
	// used by links right now?
	save : function () // obj
	{
		var id = project.get("id");
		var proj = storage.get(id);
		proj.updated = new Date().getTime();
		storage.set(id, proj);
	},
	
	dragStart : function(event, ui)
	{
		var dragInactive = $(this).hasClass('inactiveProject');
		
		var projectsHeight = $('#projects').outerHeight();
		var viewportHeight = $('#projects').closest('.viewport').height();
		var overviewTop = $('#projects').parent().position().top;
		
		var destProjects = dragInactive ? $('#projectList') : $('#inactiveProjectList');
		var destProjectsHeight = destProjects.outerHeight();
		var destHeader = destProjects.children('h2, h3, h4, h5');
		var destHeaderHeight = destHeader.outerHeight(true) || 50;
		
		var destVisibleHeight = dragInactive ? overviewTop + destProjectsHeight : destProjectsHeight - projectsHeight + viewportHeight - overviewTop;
		var showDest = destVisibleHeight < destHeaderHeight;
		var destTranslateTop = 0;
		
		if (showDest)
		{
			var sign = dragInactive ? -1 : 1;
			destTranslateTop = sign * (destVisibleHeight - destHeaderHeight - destHeader.position().top);
			
			if (dragInactive)
			{
				destTranslateTop += 2;
				
				destHeader.
					css({
						'-webkit-transform' : 'translate(0, ' + (destProjectsHeight - destHeaderHeight - 8) + 'px)', // TODO: why is this minus N neccessary?
						'-moz-transform' : 'translate(0, ' + (destProjectsHeight - destHeaderHeight - 8) + 'px)' // TODO: why is this minus N neccessary?
					});
				
				destProjects.children('.addProject, .project').
					css({
						'-webkit-transform' : 'translate(0, -' + (destHeader.outerHeight() || 0) + 'px)',
						'-moz-transform' : 'translate(0, -' + (destHeader.outerHeight() || 0) + 'px)'
					});
			}

			destProjects.
				removeClass('bouncing').
				css({
					'top' : destVisibleHeight < 0 ? destVisibleHeight + 4 + 'px' : '',
					'z-index' : 1
				}).
				addClass('bouncing scrolledIntoView');
			
			var transDuration = parseInt(destProjects.css('-webkit-transition-duration'));
			var durationScale = destVisibleHeight >= 0 ? destVisibleHeight / destHeaderHeight : 1;
			transDuration = transDuration * durationScale + (transDuration > 1 ? 'ms' : 's');
			
			destProjects.
				css({
					'top' : destTranslateTop + 'px',
					'-webkit-transition-duration' : transDuration,
					'-moz-transition-duration' : transDuration,
					'-webkit-animation-delay' : transDuration,
					'-moz-animation-delay' : transDuration
				});
				
			var popoutAreaHeight = $('#projects .project').first().outerHeight(true) || 0;
			var popoutTranslateTop = destTranslateTop - sign * popoutAreaHeight;
			$('#projects').
				data('popoutAreaHeight', popoutAreaHeight).
				data('popoutTranslateTop', popoutTranslateTop);
		}
		
		$('#projects').data('showDest', showDest);
	},
	
	drag : function(event, ui)
	{
		var $this = $(this);
		
		var viewport = $('#fluidDropdown .viewport');
		if ($('#projects').is(':visible') && utils.isMouseOver(event, viewport))
		{
			var dragInactive = $(this).hasClass('inactiveProject');
			var destProjects = dragInactive ? $('#projectList') : $('#inactiveProjectList');
		
			var projects = $('#projects');
			var popoutAreaHeight = projects.data('popoutAreaHeight');
			var popoutTranslateTop = projects.data('popoutTranslateTop');
			var relMouseTop = utils.relativeMousePos(event, viewport).top;
			
			if (projects.data('showDest') && 
				((dragInactive && relMouseTop < popoutAreaHeight) || (!dragInactive && viewport.height() - relMouseTop < popoutAreaHeight)))
			{
				destProjects.
					removeClass('bouncing').
					css({
						'top' : popoutTranslateTop + 'px',
						'-webkit-transition' : 'top 0.2s ease-in-out',
						'-moz-transition' : 'top 0.2s ease-in-out'
					}).
					bind('webkitTransitionEnd', function() {
						destProjects.unbind('webkitTransitionEnd');
						//project._updateDroppables(event, $this);
					});
			}
		
			project._updateDroppables(event, $this);
		}
		else
		{
			$('#projectList, #inactiveProjectList').removeClass('hover');
		}
		
		if(intersectTrash($this.data().draggable.helper) == true)
		{
			$('#trash').addClass('droppableStyle');
		}
		else
		{
			$('#trash').removeClass('droppableStyle');
		}
	},
	
	_updateDroppables : function(event, draggable)
	{
		var droppables = [
			{
				elem : $('#projectList'),
				accept : '.inactiveProject'
			},
			{
				elem : $('#inactiveProjectList'),
				accept : '.project:not(.inactiveProject)'
			}
		];
		
		$.each(droppables, function(idx, item) {
			var elem = item.elem;
			if (utils.isMouseOver(event, elem) && draggable && draggable.is(item.accept))
			{
				if (!elem.hasClass('hover'))
				{
					elem.addClass('hover');
				}
			}
			else if (elem.hasClass('hover'))
			{
				elem.removeClass('hover');
			}
		});
	},
	
	dragStop : function(event)
	{
		$('#projectList, #inactiveProjectList').removeClass('hover');
		
		$('#projects').data('showDest', false);
		var destProjects = $(this).hasClass('inactiveProject') ? $('#projectList') : $('#inactiveProjectList');
		destProjects.
			removeClass('bouncing').
			animate({
				'top' : '0px'
			}, 200, function() {
				destProjects.
					removeClass('scrolledIntoView').
					children('h2, h3, h4, h5, .addProject, .project').
					removeAttr('style');
			});
		
		$('#trash').removeClass('droppableStyle');
	},

	dropToActive : function(projId, bypassLimit)
    {
        var bypassLimit = bypassLimit == undefined ? false : true;
		var success = false;

        if (fluid.main.fire('project.beforeActivate') && !bypassLimit) {


            //If the activated project is the open project remove the notification
            //var projId = elem.attr("id");
            if (project.isOpen(projId))
            {
                notification.removeAll('alert', 'projectInactive');
            }
            notification.removeAll('alert', 'projectLimit');
            project._handleActiveInactiveDrop(projId, false);
            tracker.record("dropActive", 1);
            projectSettings.getItemById(projId).removeClass("inactivePrj").addClass("activePrj");
            projectSettings.displayStatus(true);
            projectSettings.applyFilter();
            $("#canvasPages .pageWidget").draggable( "option", "disabled", false );

            success = true;
        }

        page.displayMenu();
        setTimeout(hint.restart, 600);
        $('#projectList, #inactiveProjectList').removeClass('hover'); // need to do in addition to removing class in dragStop

		return success;
	},
	
	dropToInactive : function(projId)
	{
		var success = false;
//		if (elem.hasClass('project') && !elem.hasClass('inactiveProject'))
//		{
			project._handleActiveInactiveDrop(projId, true);
			notification.removeAll('alert', 'projectLimit');
            /*
			if (account.isFreeAccount())
			{
				notification.add('alert', account.alerts.projectLimitHit.onDropToInactive, {scope: 'projectLimit'});
			}
			else
			{
				notification.add('alert', "This project is now inactive and read only.", {scope: 'projectLimit'});
			}
			*/
            //notification.add('alert', "This project is now inactive and read only.", {scope: 'projectLimit'});
			tracker.record("dropInactive", 1);
			hint.cleanup();
			page.displayMenu(false);
			$('#projectList, #inactiveProjectList').removeClass('hover'); // need to do in addition to removing class in dragStop

			projectSettings.getItemById(projId).addClass("inactivePrj").removeClass("activePrj");
			projectSettings.applyFilter();
			$("#canvasPages .pageWidget").draggable( "option", "disabled", true );

			success = true;
//		}
		return success;
	},
	
	_handleActiveInactiveDrop : function(projId, toInactive)
	{
		//var projId = element.attr("id");
		project.loadIfUnloaded(projId, function() {
			var proj = storage.get(projId);
			
			proj.active = !toInactive;
			proj.updated = new Date().getTime();
			storage.set(projId, proj);
            if (projId == account.get("lastOpenProject"))
            {
                project.isModified = true;
            }
			project.sync(projId);

            project.setNumber();
		});
	},
	
	updateInactiveProjectList : function()
	{
		var inactiveProjectList = $('#inactiveProjectList');
		var inactiveProjects = inactiveProjectList.find('.inactiveProject');
		var prompt = inactiveProjectList.children('.promptContainer');
		var promptDisplayed = prompt.css('display') != 'none';
		var promptVisible = prompt.is(':visible');
		
		if (inactiveProjects.size() == 0)
		{
			if (!promptDisplayed)
			{
				if (promptVisible)
				{
					prompt.fadeIn(300);
				}
				else
				{
					prompt.show();
				}
			}
		}
		else
		{
			if (promptDisplayed)
			{
				if (promptVisible)
				{
					prompt.fadeOut(300);
				}
				else
				{
					prompt.hide();
				}
			}
		}
		
		var placeholders = inactiveProjectList.find('.projectPlaceholder');
		var placeholderCount = placeholders.size();

		placeholders.
			hide().
			slice(-1 * (placeholderCount - inactiveProjects.size() % placeholderCount)).
			fadeIn(300);

		inactiveProjectList.removeWhitespace(); // DOM manipulation can add whitespace for some reason
	},
	
	isEmpty : function(id)
	{
		if (id === undefined || id === null)
		{
			id = account.get("lastOpenProject");
		}
		
		var proj = storage.get(id);	
		return !proj || !proj.pages || proj.pages.length == 0;
	},
	
	// decompresses a saved online project (on a mobile device or in dedicated preview)
	// first call is the project - future calls are the images contained in it.
	unbundle : function(data, callback)
	{
		callback(data);
		
		/* uploads not stored in localStorage any longer -- no need for unbundling
		
		//console.log("== Data to unbundle:", data, data.uploads, callback);
		
		//console.log("Data in unbundle", data);
		if(!data.uploads) // we can just render immediately.
		{
			//console.log("Drawing a project with no uploaded images. ");
			callback(data);
			return;
		}
			
		// download and save each of the images in the project.
		// data.uploads is an array of images needed.
		// hold off on the draw callback till this is completed.
		
		//console.log("Uploads:", data.uploads);
		
		ajax.syncDown(data.uploads, function(respData, textStatus, jqXHR) 
		{
			//console.log("Uploads:", data.uploads);
			
			if(!data.uploads)
			{
				return; // no images to download.
			}
		
			//console.log("Sync Response:", jqXHR.responseText);
			try
			{
				var response = JSON.parse(jqXHR.responseText);
			}
			catch(e)
			{
				//console.log("Failed syncdown: ", jqXHR.responseText, e);
			}
			
			if(response.r == 'f')
			{
				//console.log("== No object found when unbundling:", response.t, "(probably an image missing)");
				callback(data); // do the best to draw it without the images. 
				return;
			}
			
			var uplData = JSON.parse(jqXHR.responseText).t; // jqXHR.response does not work on iOS mobile.
			var upl;
			for (var idx = 0; idx < uplData.length; idx++) // save each image independently.
			{
				//console.log("Parsing:", uplData[idx], "\n\n\n\n\n\n\n\n\n\n");
				
				try
				{
					upl = JSON.parse(uplData[idx]); // TODO: simplify this so it doesnt need a double parse.
					data = $.extend(data, upl);
				}
				catch(e)
				{
					//console.log("Unable to unbundle image:", e);
				}
			}
			
			delete data.uploads; // and then remove the uploaded file, no longer needed.
			callback(data); // the call back function here is...
		});
		*/
	},
	
	// Checks validity of a project. Used for correcting project data in new versions. 
	checkIntegrity : function(id)
	{
		//console.trace();
		// Project
		var proj = storage.get(id);
        if(proj.unloaded) {
            delete proj.unloaded;
        }

        project.save();
		
		if(!proj) // project doesnt exist in localstorage. This could be a serious problem...
		{
			account.logout(); //Log Out
			localStorage.setItem("postloadMessage", "loginAgain");
			location.reload();
		}

        if( !project.get('canvasWidth') ) project.set({canvasWidth: 24004});
        if( !project.get('canvasHeight') ) project.set({canvasHeight: 16004});
        if( !project.get('canvasPosX') && project.get('canvasPosX') !== 0 ) project.set({canvasPosX: 1000});
        if( !project.get('canvasPosY') && project.get('canvasPosY') !== 0 ) project.set({canvasPosY: 1000});
        if( !project.get('currentZoom') ) project.set({currentZoom : 0.25});
		if( typeof project.get("lastTransition") === "undefined" ) project.set({"lastTransition" : "pop"});
		if( typeof project.get("pageWH") === "undefined" ) project.set({"pageWH" : [320,480]});
		if( typeof project.get("orientation") === "undefined" ) project.set({"orientation" : "Portrait"});
		if( typeof project.get("defaultTransition") === "undefined" ) project.set({"defaultTransition" : "slide" });
		if( typeof project.get("defaultGesture") === "undefined" ) project.set({"defaultGesture" : "tap"});
		if( typeof project.get("widgetGroups") === "undefined" ) project.set({"widgetGroups" : {}});
	
		if(!proj.pages) {
            proj.pages = [];
        }

        if (!project.lastVisiblePages) {
			project.lastVisiblePages = {};
        }

        //check if the homepage exist
        if( !storage.get(proj.homepage) && proj.pages.length){
            project.set({'homepage': proj.pages[0]});
        }

        //var tmpPages = {};

		// Pages
		for (var i=0; i<proj.pages.length; i++)
		{
			var pag = storage.get(proj.pages[i]);
			// can be because the project doesnt exist in localstorage.

			if(!pag) // console.log("removing a dead page from a project.")
			{
				// open browser somewhere else has caused issues. Splice them out? Or half fixing the issue?
				// Delete the page - its been incorrectly spliced out :/
				// throw and log them out?
				//console.log("Splicing out a deleted page: ", i, pag, proj.pages[i]);
				proj.pages.splice(i,1);
                i--;
				continue;
			}

			if(pag.x > proj.canvasWidth) page.update({x: pag.x/4}, proj.pages[i]); // Sometimes a page is in the wrong place outside the canvas.
			if(pag.y > proj.canvasHeight) page.update({y: pag.y/4}, proj.pages[i]);
			
			if(!pag.height) page.update({height: 480}, proj.pages[i]); 	// Version 646 - added page height. 
			if(!pag.width) page.update({width: 320}, proj.pages[i]); 	// Version 646 - added page height. 
			if(!pag.orientation) page.update({orientation: "Portrait"}, proj.pages[i]); 	 // 646+ Orientation added.

            //tmpPages[proj.pages[i]] = pag;

			//pages width/height were once being set as strings from pageSettings dialog
			if(pag.width !== ~~pag.width) page.update({width: ~~pag.width}, proj.pages[i]);
			if(pag.height !== ~~pag.height) page.update({height: ~~pag.height}, proj.pages[i]);

			var wdgObj, uploadObj;

            //creating widget->page references
            for(var j=0; j<pag.widgets.length; j++) {

				wdgObj = storage.get(pag.widgets[j]);
				//if the widget is not in localStorage remove it from page widget List
				if(!wdgObj) {
					page.removeWidget(proj.pages[i], pag.widgets[j]);
					continue;

				//validating whether upload is there in an account (if not even as removed one, it will be removed from project)
				} else if(wdgObj.upload &&  wdgObj.upload === 'y') {
					uploadObj = storage.get(wdgObj.data);
					if(!uploadObj && account.syncedUploads) {
						storage.remove(pag.widgets[j]);
						page.removeWidget(proj.pages[i], pag.widgets[j]);
						continue;
					}

				}

                if(!widgetsCache[pag.widgets[j]]) widgetsCache[pag.widgets[j]] = {};
                widgetsCache[pag.widgets[j]].pageId = proj.pages[i];
            }
            if(!pagesCache[proj.pages[i]]) pagesCache[proj.pages[i]] = {};
		}

		// Links. If a project doesnt have link transitions yet, add them (beta 2).
		var links = project.get("links");

        if(!links) {
            links = {
                linkCanvId: [],
                linkDest: [],
                linkOrigin: [],
                linkType: [],
                transType: [],
                triggerType: []
            };

            proj.links = links;
        }
		if(typeof links.transType === "undefined")
		{
			links.transType = (links.linkType).slice(0);
			for(var i in links.transType)
			{
				links.transType[i] = (links.linkType[i] == "ahref") ? project.get("defaultTransition") : null;
			}
		}
		if(typeof links.triggerType === "undefined")
		{
			links.triggerType = (links.linkType).slice(0);
			for(var i in links.triggerType)
			{
				links.triggerType[i] = (links.linkType[i] == "ahref") ? project.get("defaultGesture") : null;
			}
		}

        //checking if the links are valid (both destination and origin exist)
        var foundOriginWidget = false;
        var originPageId;

        for(var i=0; i<links.linkDest.length; i++) {
            foundOriginWidget = false;

            //link to unexisiting page
            //if(!tmpPages[links.linkDest[i]]){
            if(!pagesCache[links.linkDest[i]]){
                //console.log('link to unexisiting page');
                links.linkCanvId.splice(i,1);
                links.linkDest.splice(i,1);
                links.linkOrigin.splice(i,1);
                links.linkType.splice(i,1);
                links.transType.splice(i,1);
                links.triggerType.splice(i,1);
                i--;
            } else {
                //link from unextisting widget
                //if(!foundOriginWidget) {
                if(!widgetsCache[links.linkOrigin[i]]) {
                    links.linkCanvId.splice(i,1);
                    links.linkDest.splice(i,1);
                    links.linkOrigin.splice(i,1);
                    links.linkType.splice(i,1);
                    links.transType.splice(i,1);
                    links.triggerType.splice(i,1);
                    i--;

                //origin and destination existed - save references to pagesCache
                } else {

                    if(!pagesCache[links.linkDest[i]].linksTo) {
                        pagesCache[links.linkDest[i]].linksTo = [];
                    }
                    if(!pagesCache[links.linkDest[i]].linksFrom) {
                        pagesCache[links.linkDest[i]].linksFrom = [];
                    }
                    pagesCache[links.linkDest[i]].linksTo.push(links.linkCanvId[i]);

                    originPageId = widgetsCache[links.linkOrigin[i]].pageId;
                    if(!pagesCache[originPageId].linksFrom) {
                        pagesCache[originPageId].linksFrom = [];
                    }
                    if(!pagesCache[originPageId].linksTo) {
                        pagesCache[originPageId].linksTo = [];
                    }
                    pagesCache[originPageId].linksFrom.push(links.linkCanvId[i]);

                    if(!pagesCache[originPageId].pagesLinked) pagesCache[originPageId].pagesLinked = {};
                    if(!pagesCache[originPageId].pagesLinked[links.linkDest[i]]) pagesCache[originPageId].pagesLinked[links.linkDest[i]] = [];

                    pagesCache[originPageId].pagesLinked[links.linkDest[i]].push(links.linkCanvId[i]);
                }
            }
        }

		project.save();
		//console.log("New project values:", project.get("links"), storage.get(id));
	},
	
	// takes a project id and gets all the data for it and returns it in a single json object.
	bundle : function(id)
	{
		var data = {uploads: {}};
		 
		//var proj = storage.getItem(id);
		var proj = storage.get(id);
		//console.log("Proj to bundle:", id, proj);
		
		//var json = JSON.parse(proj);
		
		data[id] = proj;
		//console.log("Project pages", proj.pages);

		if (!proj.pages)
		{
			return data;
		}

		for (var i = 0; i < proj.pages.length; i++)
		{
			var pjson = storage.get(proj.pages[i]); // list of pages
			if(!pjson) continue;
			
			data[proj.pages[i]] = pjson; // lot of missing pages.
			
			for(var j = 0; j < pjson.widgets.length; j++)
			{
				var wjson = storage.get(pjson.widgets[j]);
				if(wjson == null)
				{
					continue;
				}

				data[pjson.widgets[j]] = wjson;
				
				if (wjson.upload)
				{
					var title = wjson.title;
					if (!title)
					{
						var upl = storage.get(wjson.data);
						if (upl)
						{
							title = upl.title || upl.name;
						}
					}
					
					data.uploads[wjson.data] = {
						title: title,
						type: wjson.type,
						wh: wjson.wh
					};
				}
			}
		}

		return data;
	},

	//Notifies the user when the project has been synchronized to the server
	//In order to remove the notification, please comment the code inside the function, don't remove the fn.
	notifySyncAttempt: function(tried, name)
	{
		/*
		if (tried){
			setTimeout(function(){
				notification.add('alert', 'All your changes to [' + name + '] have been saved!');
			}, 1000);
		}
		else
		{
			notification.add('alert', 'No changes to [' + name + '] ' + tried);
		}
		*/
	},
	
	sync : function (id, callback)
	{
		//storage.copyTempToLocal();
		if (account.get('accType') == 'New')
		{
			//console.log("Cant sync - not logged in.", account.get('accType'));
			return;
		}
		
		//console.log("Syncing project", account.get('accType'));
		var last = account.get("lastOpenProject");
		if(id === undefined || id === null)
		{
			id = last;
		}

		function executeCallback(result)
		{
			if ($.isFunction(callback))
			{
				callback.call(null, result);
			}
		}

		project.loadIfUnloaded(id, function() {
			var toSync = id == last ? project.isModified : true;
			project.notifySyncAttempt(toSync, id);
			//console.log("Time to sync... WIll I? ", toSync, id);
			if (toSync)
			{
                //console.log("Syncing project...", id, project.isModified, toSync);
				var proj = storage.get(id);
                //if(proj.preview) proj.preview.src = project.previewData;
                //else {
                //    proj.preview = {
                //        src : project.previewData
                //    };
                //}

				proj['saved'] =  new Date().getTime();
				storage.set(id, proj, false);
				var data = project.bundle(id);
				var dataToStore = $.extend(true, {}, data);
				//console.log(project.get('id'), id, project.lastVisiblePages.projectId, project.lastVisiblePages.pages, project.getPagesInViewport());
				if( project.get('id') !== id ) {
					dataToStore[id].visiblePages = project.lastVisiblePages[id];
				} else {
					dataToStore[id].visiblePages = project.getPagesInViewport();
				}

				dbStorage.set('projects', {id: id, data: dataToStore});
				ajax.syncUp(data, "projectSync", id, function(data) {
					executeCallback({ data: data, synced: true });
				});
			}
			else
			{
				executeCallback({ synced: false });
			}

			// sync any unsynced uploads
			/*var uploads = account.get("uploads");
			if (uploads)
			{
				for (var idx = 0; idx < uploads.length; idx++)
				{
					var upl = uploads[idx];
					if (!upl.s && !account.syncPending[upl.id])
					{
						var uplItem = storage.get(upl.id);
						var uplFile = widget.getTempFile(upl.id);
						if (uplFile)
						{
							ajax.apiCall('img', 'post', upl.id, uplFile, function(id)
							{
								widget.removeTempFile(id);
								var obj = storage.get(id);
								//widget.___drawCanvasOrImage($('#' + id).find('canvas, img'), obj, null); // to replace data url with real uploaded image url
							});
						}
						//ajax.syncUp(upload.bundle(upl.id), 'imageSync', upl.id); // upload image; TODO: prolly replace syncImage with syncObject
					}
				}
			}*/
            if (id == last)
            {
                project.setModified(false);
            }
		});
	},
	
	setName : function(obj) // project doesn't need to be open to set name.
	{
		var p = storage.get(obj.id);

		if (!p)
		{
			return;
		}

		p.name = obj.name;
		storage.set(obj.id, p);

		if (account.get('lastOpenProject') == obj.id)
		{
			account.set({"name" : obj.name});
		}
	},
	
	deletePage : function (id) // called from pages - only one!!!
	{
		//console.log("Deleting a page.");
		var p = null;
		var pages = project.get("pages");
		for(var i = 0;i<pages.length; i++)
		{
			if(pages[i] == id)
			{
				p = i;
				break;
			}
		}
		pages.splice(p, 1); // this would do it anyway!
		project.set({"pages" : pages});
		project._deletePageWidgets(id);
		//project.save();
	},

	_deletePageWidgets : function(id)
	{
		var p = storage.get(id);
		if (p)
		{
			for (var idx = 0, len = p.widgets.length; idx < len; idx++)
			{
				storage.remove(p.widgets[idx]);
			}
		}
	},

	sort : function()
	{
		var projects = account.get('projectIds');
		var array = $.merge([], projects);	
		
		array.sort(function (a, b)
		{
			//console.log("Sorting", a, b);
			var time1 = storage.get(a) ? storage.get(a).created : 0;
			var time2 = storage.get(b) ? storage.get(b).created : 0;
			
			return time1 - time2;
		});
		//console.log(projects); 
		//console.log(array); 
		
		account.set({'projectIds' : array});
	},
	
	// draws the list of projects to the projects list.
	load : function() 
	{
		account.setLoadingStep(2);
		if($(".submenuLink .fluidSubmenuActive").length == 0)
		{
			$("#fluidDropdownSubmenu a:first").addClass("fluidSubmenuActive"); // probably shouldnt be here.
		}
		   
		project.sort();
		
		var accType = account.get('accType');
		var projects = account.get('projectIds');
		var maxActiveProjects = account.get('maxActiveProjects');
		
		//console.log("Loading projects from localstorage...", projects);
		
		//var moveToInactiveCount = maxActiveProjects ? project.activeProjectCount() - maxActiveProjects : 0;
		var moveToInactiveCount = 0;
		if(maxActiveProjects != 0 && project.activeProjectCount() > maxActiveProjects)
		{
			moveToInactiveCount = project.activeProjectCount() - maxActiveProjects;
		}
	
		// delete all existing projects first.
		projectSettings.displayFrame();     //Remove frame from last selected project
		$('#fluidDropdown .project').not('.addProject').remove(); // handle the case where a project is created and drawn before
		$('.projectThumb').not('#projectAdd').remove();
        projectSettings.resetFilter();

		for(var index in projects) // get the data for each project.
		{
			//var dataObject = JSON.parse(storage.getItem(projects[index]));
			var dataObject = storage.get(projects[index]);
			if (dataObject) //  && !dataObject.removed - removed removed - dave - was causing missing projects.
			{
				var objActive = dataObject.active !== undefined ? dataObject.active : true;
				if (moveToInactiveCount > 0 && objActive)
				{
					dataObject.active = false;
					moveToInactiveCount--;
				}
                dataObject = project.ensureHeaderIntegrity(dataObject);
				var tmp = project._template(dataObject, projects[index]);

				if (objActive && dataObject.active === false)
				{
                    //It's required to set the active flag to false after loading the full object
                    //Since the load could bring the active to true
                    var idToAdjust = projects[index];
                    project.loadIfUnloaded(idToAdjust, function() {
                        dataObject = storage.get(idToAdjust);
                        dataObject.active = false;
                        storage.set(idToAdjust, dataObject);
                        project.sync(idToAdjust);
                    });
				}
			}
		}

		project.setNumber();
        if (userSettings.isOpen) {
            projectSettings.open();
        }

		//this.colorize();
		this.updateInactiveProjectList();
	},

    ensureHeaderIntegrity: function(projectObj) {
        if(!projectObj.name) projectObj.name = 'New Project';
        return projectObj;
    },
	
	windowClose : function()
	{
		// commit any changes that havent been saved.
		storage.commitCache();
		if(project.isEmpty() == false)
		{
			project.sync();
		}
	},

	windowClose2 : function()
	{
		// commit any changes that havent been saved.
		alert("Close!");
		storage.commitCache();
		if(project.isEmpty() == false)
		{
			project.sync();
		}
	},
	
	close : function(callback)
	{
		if(!project.lastVisiblePages) project.lastVisiblePages = {};
		project.lastVisiblePages[project.get('id')] = project.getPagesInViewport();
		//console.log('closed project: ', project.get('id'), ' with: ', project.lastVisiblePages[project.get('id')].length, ' pages visible');

		fluid.command.history.reset();
		fluid.command.create('hideButton').dispatchTo('fluid.controllers.timeline');
		
		//storage.copyTempToLocal();
		//storage.commitCache(); // whenever the selection changes, we commit any changes to those widgets.
		page.detachFrame();
		var lastProj = account.get("lastOpenProject");

		//console.log("Closing project", account.get("lastOpenProject"));
		//var openProject = null;	/* The currently  project data. */
		$(".project").removeClass("open");
		$(".projectThumb").removeClass("open");
		$(".screen").remove(); // or empty the parent
		$("#canvasLinks").empty();
		
		if($("#dragCanvas").length == 0) // replace the dragcanvas if deleted by close
		{
			$("#tmplDragCanv").tmpl( {} ).appendTo($("#canvas")); 
		}
		
		hint.hide();
		
		//$("#canvas").fadeOut(50);
		
		if (lastProj && storage.get(lastProj) && !project.isEmpty(lastProj) && !project.lastProjectClosed)
		{
			project.sync(null, callback); // callback after sync - delete project. 
		}

		project.lastProjectClosed = true;
	},

	// takes "last", or an id of a project object.
	open : function(p, callback) // opens a specific project.
	{
        $('#canvas').removeClass('loaded');

		project.afterOpenedCallback = callback;
		project.openStartTime = new Date().getTime();
		project.uploadPreload = true;
		project.useLocalDb = true;
//            project.uploadPreload = false;
//            project.useLocalDb = false;


		fluid.command.history.reset();


		account.setLoadingStep(3);
		if ($('#previewHolder').is(':visible'))
		{
			preview.close();
		}
	
		//console.log("Opening a project", p);
		notification.removeAll('alert', ['projectInactive', 'projectLimit']);
		if (!project.lastProjectClosed)
			project.close();

		if(p == 'last') {
			p = account.get("lastOpenProject");
			var pObj = storage.get(p);
			
			if(!p || !pObj) {
				p = project.add("", "New Project"); 
			}
		}


		account.set({lastOpenProject : p});
		project.lastProjectClosed = false;

		if(project.useLocalDb) {
			if(!project.preloader) project.preloader = new fluid.projectPreloader();

			project.preloader.firstPreload(p, function() {
				//after project preloaded stuff
				//project.onPagesPrepared(p, callback);
			});
		}

		//load the project into localStorage if not present
		project.loadIfUnloaded(p, project.afterLoaded.bind(this, p));

	},

	drawThumbnail: function(p) {
		var $profileBox = $('#profile');

		$profileBox.find('.projectThumb').remove();
		var dataObject = {
			id: 'opened_'+p,
			name: project.get('name')
		};

		var tmplThumb = $("#tmplProjectThumb").tmpl(dataObject);
		tmplThumb.addClass(project.get('active') === false ? 'inactivePrj' : 'activePrj');
		var projectPreview = project.get('preview');

		if (!project.get('pages') || project.get('pages').length === 0) {
			tmplThumb.append('<div class="project-thumb">Project empty</div>');
		} else if (projectPreview && projectPreview.src) {
			tmplThumb.append('<img class="project-thumb" src="'+projectPreview.src+'">');
		}
		var thmubFrame = $("#tmplProjectSettingsFrame").tmpl();
		$(".selectedProjectName", thmubFrame).text(tmplThumb.attr("title"));
		$(".projectOptionsButtonSettings", thmubFrame).click(fluid.util.debounce(
			function() {
				projectSettings.lastSelectedId = project.get('id');
				project.sync();
				projectSettings.goToSettingsUpdate();
				userSettings.open(null, $("#projectSettingsPanelSettings"));
			},500)
		);
		thmubFrame.css({ opacity : 0.75, display: 'block'}).appendTo(tmplThumb);
		//projectSettings.lastSelectedId = projectSettings.getSelectedId(tmplThumb.attr("id"));
		tmplThumb.addClass("selectedPrj");
		$profileBox.prepend(tmplThumb);
		tmplThumb.click(function() {
			fluidMenu.hide();
		});
	},

	//project loaded into localstorage
	afterLoaded: function(p) {
		if( storage.get(account.get('id')).email.indexOf('@') === -1) {
			$('#profile .projectThumb').remove();
		} else {
			project.drawThumbnail(p);
		}

		widgetsCache = {};
		pagesCache = {};
		project.checkIntegrity(p);

		//set the viewport/canvas dimensions and scroll offset.
		var xpos = project.get("canvasPosX");
		var ypos = project.get("canvasPosY");
		var width = project.get("canvasWidth");
		var height = project.get("canvasHeight");

		var $canvas = $('#canvas');
		$canvas.parents('#viewport').get(0).scrollLeft = -xpos;
		$canvas.parents('#viewport').get(0).scrollTop = -ypos;

		canvas2.zoom({ newZoom: 0.25, currentZoom : 1, duration: 0, centerY: ypos, centerX: xpos}, function() {
			$canvas.data("lastOutX", xpos)
				.data("lastOutY", ypos)
				.css({
					width: parseInt(width/4, 10),
					height: parseInt(height/4, 10),
					border: '10px solid #ffffff'
				});
			$canvas.parents('#viewport').get(0).scrollLeft = -xpos;
			$canvas.parents('#viewport').get(0).scrollTop = -ypos;
			project.preparePages(p);
		});
	},

	preparePages: function(p) {
		link.newLinks = true;

//		widgetsCache = {};
//		pagesCache = {};
//
//		project.checkIntegrity(p);
//		project.startTime = new Date().getTime();

		if(project.uploadPreload) {
			project.projectLoadedTime = new Date().getTime();
			//console.log('waiting for preloader: ', new Date().getTime() - project.openStartTime);
			project.preloader.projectLoaded(function() {
				//after project preloaded stuff
				project.onPagesPrepared(p);
			});

		} else {
			var visiblePages = project.getPagesInViewport('init');

			for(var i=0; i<visiblePages.length; i++) {
				page.draw(visiblePages[i], 'init');
			}
			project.onPagesPrepared(p);
		}
	},



    onPagesPrepared: function(p) {
		//console.trace();
		//console.log('!! onPagesPrepared: ', new Date().getTime() - project.openStartTime );
		
        canvas2.updatePages(canvas2.updateLinks);

        projectSettings.getItemById(p).addClass("open"); // give it active status in the project list.
        document.title = project.get("name") + " :: Fluidui.com" ;// set the title of the page to the project name.

        var resetCanvas = false;

        $(".pageWidget").draggable('disable'); // zoom gets called to early on project change.
        //$canvas.draggable( "option", "containment", canvas2.setContainment() );
        $("#startMenu").delay(300).fadeIn(300); //.not(":visible")
        project.isInitialized = true;
		
		if (project.readOnly()) {
			fluid.command.create('hideButton').dispatchTo('fluid.controllers.timeline');

            if (account.canAddProjects()) {
                notification.add('alert', 'This project is inactive and read-only. Please <span class="inlineLink alertLinkToSettings close">activate the project</span> in order to edit it.', {scope: 'projectInactive', permanent: true});
            } else {
                notification.add('alert', account.alerts.projectLimitHit.onOpenInactive, {scope: 'projectInactive', permanent: true});
            }

            $("#canvasPages .pageWidget").draggable( "option", "disabled", true );

            fluidMenu.setCanvasFirstPage();
		} else {
            if (project.get("pages").length > 0) {
                fluidMenu.setCanvasFirstPage();
            } else {
                fluidMenu.setCanvasNoPages();
            }

            if (resetCanvas) {
                project.resetCanvas();
            }
            //hint.restart();
        }
        if(!project.previewRenderer) {
            project.previewRenderer = new fluid.wdgRenderer();
        }

        project.previewRenderer.renderProjectPreview(project.bundle(p), function(id, $canvas) {
            project.onPreviewReady(id, $canvas, 'projectopen');
        });
		
        if (account.get("loggedIn") == "yes")
        {
            $("#projectName").hide().html(project.get("name")).fadeIn(1000).delay(1000).fadeOut(500);
        }

        var pages = project.get("pages");
        if (!pages || pages.length == 0) fluidMenu.setCanvasNoPages(false);

        project.setModified(false);
		
        if ($.isFunction(project.afterOpenedCallback))
        {
			project.afterOpenedCallback.call(null);
			project.afterOpenedCallback = null;
        }

        //setTimeout(afterOpen2, 600);
        $("#canvasPages").fadeIn(300);
		$('#canvas').addClass('loaded');
		
        $("#" + project.get("homepage")).addClass("homePage");

        if(!project.readOnly()) {
            hint.restart();
        }
		
    },

	onPreviewReady: function(id, $canvas, invokedEvent) {
		$('#profile .projectThumb .loader-wrap').remove();

		//console.log('preview ready: ', arguments);
		var imgData = $canvas.get(0).toDataURL();

        var projObj = storage.get(id);

		//prevent saving the thumbnail if the project has been unloaded already
		if(projObj.unloaded) {
			return;
		}

        projObj.preview = {
            src : imgData
        };
        storage.set(id, projObj, false);

		//use updated preview in projectSettings panel
        projectSettings.updateThumbnail(id);

		//use updated preview in fluidMenu
		if( project.get('id') === id) {
			var projPages = project.get('pages');
			if(!projPages || projPages.length === 0) {
				$('#profile .project-thumb').remove();
				$('#profile .projectThumb').prepend('<div class="project-thumb">Project empty</div>');
			} else {
				$('#profile div.project-thumb').remove();

				var $imgPreview = $('#opened_'+id+'Thumb img.project-thumb');

				if($imgPreview.length) {
					$imgPreview.attr('src', imgData);
				} else {
					$('#profile .projectThumb').prepend('<img class="project-thumb" src="'+imgData+'">');
				}

			}

		}

        if( invokedEvent !== 'autopreviewgen') {
            project.renderMissingPreviews(invokedEvent !== 'projectopen' ? id : null );
        }
        if(invokedEvent === 'projectopen' ) {
            setTimeout( project.initAutoPreviewGen.bind(this, id), project.autoPreviewTimeout);
        }
	},

	initAutoPreviewGen: function(id) {
		//dont generate preview if user already opened another project
		if( account.get('lastOpenProject') !== id ) return;

		project.previewRenderer.renderProjectPreview(project.bundle(account.get('lastOpenProject')), function(id, $canvas) {
			project.onPreviewReady(id, $canvas, 'autopreviewgen');
		});

		setTimeout( project.initAutoPreviewGen.bind(this, id), project.autoPreviewTimeout);
	},

	renderMissingPreviews: function(lastPid) {
        var $missingEls = $('.projectThumb div.preview').not('.empty');
		var missingId;
		//console.log('missing previews els: ', $missingEls);
		if( $missingEls.length > 0 ) {
			missingId = projectSettings.getSelectedId($missingEls.eq(0).parents('.projectThumb').attr('id'));
            project.renderPreview(missingId);
		}
	},

    renderPreview : function(projectId, invokedEvent)
    {
        var eventToInvoke = invokedEvent || 'missingpreview';
		if( projectId === project.get('id') ) {
			$('<div class="loader-wrap"><img class="ajax-loader" src="img/ajax-loader.gif"/></div>').insertAfter('#profile .project-thumb');
		}
        project.loadIfUnloaded(projectId, function() {
            project.previewRenderer.renderProjectPreview(project.bundle(projectId), function(id, $canvas) {
                project.onPreviewReady(id, $canvas, eventToInvoke);
                if(!project.isOpen(id)) {
                    project.sync(id, function() {
                        project.unload(id);
                    });
                }
            });
        });
    },


	isOpen : function(id)
	{
		if (!id)
		{
			id = this.id;
		}
		return id == account.get("lastOpenProject");
	},

    addWithoutLimit : function(e)
    {
        project._freeSlotForProject();
        project.add(e, null, true);
    },

	add : function (e, name, bypassLimit)
	{
        var bypassLimit = bypassLimit == undefined ? false : true;
		if ((!account.canAddProjects()) && (!bypassLimit))
		{
			notification.removeAll('alert', 'projectLimit');
			notification.add('alert', account.alerts.projectLimitHit.onAddActive,
                {scope: 'projectLimit', 'stopBuggingCallBack': project.addWithoutLimit });
			return false;
		}
		
		var id;
		//var accType = account.get('accType');
		//console.log("Adding project, count is", activeProjectCount);
		
		// TODO: the following is a temporary fix
		//if (accType != 'Free' || !maxActiveProjects || activeProjectCount < maxActiveProjects)
		if(name == undefined)
		{
			name = "New Project";
		}

		var date = new Date().getTime();
		id = utils.guid("p");

		var dataObject = {	//id : id
						  name: name,
						  created: date,
						  updated: date,
						  canvasWidth : 24004,	// This is the width/height of the canvas at 100% (default zoom on project load).
						  canvasHeight: 16004,
						  canvasPosX : -2000*.5,		//canvas starts at 0,0 - should be 1/2 width - screen width or so.
						  canvasPosY : -2000*.5,
						  currentZoom : 0.25, // also defines the load zoom.
						  orientation: "Portrait",
						  pages: [],
						  pageWH: [320,568],
						  deviceModel: 'iPhone5',
						  //canvCount : 1,
						  lastTransition : "pop",
                          defaultTransition : "pop",
                          defaultGesture : "tap",
						  links: {linkOrigin:[], linkDest:[], linkCanvId:[], linkType:[], transType:[], triggerType:[]}};  // links is 4 arrays -linkOrigin linkDest linkCanvId linkType - saved and loaded to globals.

		//account.addProjectNumber(); // TODO: merge these 2, and the other place it occurs, into a single set.
		account.addProjectId(id);
		storage.set(id, dataObject); // creates the project.

		var trans = $(".project:not(.addProject, .inactiveProject)");
		trans.css({
			'-webkit-transform' : 'translate(-' + (trans.outerWidth(true) || 0) + 'px,0px)',
			'-moz-transform' : 'translate(-' + (trans.outerWidth(true) || 0) + 'px,0px)'
		}); // Class me!

		var p = project._template(dataObject, id);
		p.hide().fadeIn(800);

		trans.css({
			'-webkit-transition': 'all 0.20s ease-in-out',
			'-moz-transition': 'all 0.20s ease-in-out',
			'-webkit-transform' : 'translate(0px,0px)',
			'-moz-transform' : 'translate(0px,0px)'
		});
		setTimeout(function(){  $(".project").css({'-webkit-transition': 'none', '-moz-transition': 'none'}); }, 200);

		// handle other cleanup
		project.setNumber();
        projectSettings.applyFilter();
		//redraw(); // update the menus - legitimate

		//project.colorize();

		//fluidMenu.updateScrollbar();

		project.sync (id, false);

		return id; // finally, return the id of the project created.
	},
	
	addPage : function(id) // called by page to add the page to the list of pages or this object
	{ 
		var pages = project.get("pages") || [];
		//console.log("Setting new page in project", pages, id);
		pages.push(id);
		project.set({"pages" : pages});
	},
	
	del : function(id, callback)
	{
		function removeProject()
		{
			//console.log("Removing project.");
		
			function ajaxCallback() // only deletes after successful sync!
			{
				//console.log("Ajax callback to remove project (success).");
				$('#fluidDropdown #' + id).
					draggable('destroy').
					fadeOut(300, function() {
						var dragInactive = $(this).hasClass('inactiveProject');
						$(this).remove();
						
						if (dragInactive)
						{
							project.updateInactiveProjectList();
						}

						//project.colorize();
						//fluidMenu.updateScrollbar();
					});

				var projIds = account.get('projectIds');
				projIds.splice($.inArray(id, projIds), 1);
				account.set({"projectIds" : projIds});

				var delProgObj = project.unload(id);
				
				storage.remove(id);
				project.setNumber();
				//Project Settings Dashboard actions
				projectSettings.displayFrame();
				projectSettings.getItemById(id).remove();
				projectSettings.refreshListHeader();
				if (callback) {
					callback.call(null, delProgObj);
				}
			}

			ajax.remove(id, ajaxCallback);
		}
		
		//console.log("Deleting project on project.del", id);
		var isCurrProj = project.isOpen(id);
		
		if (isCurrProj)
		{
			notification.add('alert', 'Sorry, the currently open project cannot be deleted. Please open another project before deleting this one.', {scope: 'projectAction'});
			return false;
		}	
		
		var proj = storage.get(id);
		
		// TODO: not sure if we need to maintain both removed property of a project and mark it as removed in the DB;
		// might just leave the latter
		proj.removed = true;
		proj.updated = new Date().getTime();
		storage.set(id, proj);
		
		// a non open project. 
		if (project.isEmpty(id)) // empty - just delete it
		{
			//console.log("Calling remove project (its empty).");
			//console.log("Calling remove project (its empty).");
			removeProject();
		}
		else
		{
			//console.log("Syncing project, then removing");
			project.sync(id, removeProject);
		}

		notification.removeAll("alert", "projectAction");
		//notification.add('alert', account.alerts.projectAction.onDelete, {scope: 'projectAction'});
		notification.add('alert', "Your project has been deleted.  In case you want to restore, please visit the bin...", {scope: 'projectAction'});

		$("#trash").show().css({
			opacity: 1
		});
	},

	_deleteProjectPages : function(id)
	{
		var proj = storage.get(id);
		if ((proj) && (proj.pages != undefined) && !proj.unloaded)
		{            for (var idx = 0, len = proj.pages.length; idx < len; idx++)
			{
				var pid = proj.pages[idx];
				project._deletePageWidgets(pid);
				storage.remove(pid);
			}
		}
	},
	
	rename : function(e)
	{
		//console.log("Project blur sync", $(e.target).closest(".project").attr("id"));
		var id = userSettings.isOpen ? projectSettings.lastSelectedId : $(e.target).closest('.project').attr('id');
		var newName = $(e.target).val();
		project.setName({name: newName, id: id});
		project.sync(id, false);
		
		if(project.isOpen(id))
		{
			document.title = project.get("name") + " :: Fluidui.com" ;
		}
		$(".title", "#" + id).val(newName);
		$(".selectedProjectName").text(newName);
		projectSettings.getItemById(id).attr({ "data-name": newName.toLowerCase(), title: newName, alt: newName });

		return false;
	},	
		
	activeProjectCount : function()
	{
		var count = 0;
		var projIds = account.get('projectIds');
		for (var idx = 0, len = projIds.length; idx < len; idx++)
		{
			if (storage.get(projIds[idx]) && storage.get(projIds[idx]).active !== false)
			{
				count++;
			}
		}
		return count;
	},
	
	getLatestActiveProject : function()
	{
		var id;
		var projIds = account.get('projectIds');
		for (var idx = projIds.length - 1; idx >= 0; idx--)
		{
			if (storage.get(projIds[idx]).active !== false)
			{
				id = projIds[idx];
				break;
			}
		}
		return id;
	},
	
	readOnly : function()
	{
		return project.get('active') === false;
	},

	/*colorize : function()
	{
		var projects = $('#projectList .project');
		if (projects.size() > 0)
		{
			var colors = project.colors;
			var hStep = (colors.hEnd - colors.hStart) / (projects.size() - 1);
			var h = colors.hStart;

			projects.each(function(idx, projElem) {
				$('.tab, .background', projElem).css({
					background : 'hsl(' + Math.floor(h) + ',' + colors.s + ',' + colors.l + ')'
				});

				h += hStep;
			});
		}
	},*/

	setModified : function(modified)
	{
		if (!project.readOnly())
		{
            //console.log("The final thing...", modified);
			var currentState = modified === false ? false : true;
			project.isModified = currentState;
		}
		else
		{
			project.isModified = false;
		}
	},

    storageChangeProjectHandler : function(e, data)
    {
        //console.log("=======================Handling...", data);
        if ((!data) || (!data.timeUpdated)) { return; }

        var first = data.id.substr(0, 1);       //First letter of the object id
        if ((first == "x") || (first == "w") || (first == "p"))
        {
            if ((first == "p") && (data.id != account.get("lastOpenProject"))) { return; }

            //console.log("The project has been modified...", data.id, data.obj);
            project.setModified(true);
        }

    },

	unload : function(id, proj)
	{
		if (!proj)
		{
			proj = storage.get(id);
		}

		if(this.previewRenderer) this.previewRenderer.onProjectUnloaded(id);

		if (!proj.unloaded) {
			project._deleteProjectPages(id);
			for (var prop in proj)
			{
				if (proj.hasOwnProperty(prop) && $.inArray(prop, project.unloadedProps) == -1)
				{
					delete proj[prop];
				}
			}

			proj.unloaded = true;
			storage.set(id, proj);
		}

		return proj;
	},

	unloadOldest : function()
	{
		var oldestProjId, oldestProj, oldestTimestamp;
		var projects = account.get('projectIds');

		for (var idx = 0, len = projects.length; idx < len; idx++)
		{
			var projId = projects[idx];
			if (projId != account.get("lastOpenProject")) // don't unload current project
			{
				var proj = storage.get(projId);
				if (!proj.unloaded && (!oldestTimestamp || oldestTimestamp > proj.updated)) 
				{
					oldestTimestamp = proj.updated;
					oldestProjId = projId;
					oldestProj = proj;
				}
			}
		}

		if (oldestProj)
		{
			project.unload(oldestProjId, oldestProj);
		}
		else
		{
			throw "Could not find a project to unload";
		}
	},

	loadIfUnloaded : function(id, callback)
	{
		function finish()
		{
			if ($.isFunction(callback))
			{
				callback.call();
			}
		}

		var proj = storage.get(id);
		if (proj && proj.unloaded)
		{

			ajax.syncDown(id, function(respData, textStatus, jqXHR) {

				var syncData = JSON.parse(jqXHR.responseText).t;

                //escaping newline characters to ensure JSON.parse will not fail
                if(syncData.length) {
                    syncData = syncData[0].replace(/[\r\n]/g, '\\n');
                } else {
                    syncData = syncData.replace(/[\r\n]/g, '\\n');
                }

				var items = JSON.parse(syncData);
                if(items.unloaded) delete items.unloaded;
                //console.log('afterSyncDown: ', items);

				if (items.uploads)
				{
					delete items.uploads;
				}

				for(var itemId in items)
				{
					if (items.hasOwnProperty(itemId))
					{
						storage.set(itemId, items[itemId], false);
					}
				}

				finish();
			});
		}
		else
		{
			finish();
		}
	},

    resetCanvas : function()
    {
        var x = -1000, y = -1000;
        //console.trace();
        project.set({canvasPosY: y, canvasPosX: x});

        //$('#canvas').css({top: y + 'px', left: x + 'px'});
        $('#viewport').get(0).scrollLeft = x;
        $('#viewport').get(0).scrollTop = y;
    },

	/*resetCanvas : function()
	{
		var x = -1000, y = -1000;
		project.set({canvasPosY: y, canvasPosX: x});
		$('#canvas').css({top: y + 'px', left: x + 'px'});
	},*/

	updateOnSignup : function()
	{
		project.setNumber();
		project.previewRenderer.renderProjectPreview(project.bundle(account.get("lastOpenProject")), function(id, $canvas) {
			project.onPreviewReady(id, $canvas, 'projectopen');
		});
	},

    _freeSlotForProject : function()
    {
        //When the limit has been reached, deactivate an active project and add the new project
        var found = false;
        if (!account.canAddProjects()) {
            var projects = account.get('projectIds');

            for(var index in projects) {
                var projId = projects[index];
                var dataObject = storage.get(projId);

                if (dataObject) {
                    var objActive = dataObject.active !== undefined ? dataObject.active : true;

                    if (objActive) {
                        if (!project.isOpen(projId)) {
                            project.dropToInactive($("#" + projId));
                            found = true;
                            break;
                        }
                    }
                }
            }
        }

        if (!found) {
            project.dropToInactive($("#" + account.get("lastOpenProject")));
        }
    },

    getPagesInViewport: function(mode) {
        var pagesInViewport = [];
        var viewport = document.getElementById('viewport');
        var pages = $.extend([], project.get('pages'));
        var zoom = project.get('currentZoom');

        var viewportBox = {
            left: mode === 'init' ? -project.get("canvasPosX")/zoom : viewport.scrollLeft/zoom,
            top: mode === 'init' ? -project.get("canvasPosY")/zoom : viewport.scrollTop/zoom,
            width: window.innerWidth/zoom,
            height: window.innerHeight/zoom
        };
        viewportBox.right = viewportBox.left + viewportBox.width;
        viewportBox.bottom = viewportBox.top + viewportBox.height;

        //console.log('viewportbox: ', viewportBox);

        //console.log('pages: ', pages, $viewport, $canvas );
        var pageLeft, pageRight, pageTop, pageBottom;
        var pageId;
        for(var i=0; i<pages.length; i++) {
            pageId = pages[i];
            pages[i] = $.extend( {}, storage.get(pages[i]) );

            pageLeft = pages[i].x;
            pageRight = pages[i].x + pages[i].width;
            pageTop = pages[i].y;
            pageBottom = pages[i].y + pages[i].height;

            
            if(
                ( (pageLeft <= viewportBox.right) &&
                  (viewportBox.left <= pageRight) &&
                  (pageTop <= viewportBox.bottom) &&
                  (viewportBox.top <= pageBottom) )
              ) {

                pagesInViewport.push(pageId);
            }
        }
        return pagesInViewport;
    },

    getLinksInViewport: function(mode) {
        var pagesInViewport = project.getPagesInViewport(mode);

        var allLinks = project.get('links');
        var viewportLinks = {
            linkCanvId: [],
            linkDest: [],
            linkOrigin: [],
            linkType: [],
            transType: [],
            triggerType: []
        };

        //console.log('allLinks: ', allLinks, pagesInViewport);
        for(var i=0; i<allLinks.linkCanvId.length; i++) {
            if( pagesInViewport.indexOf(allLinks.linkDest[i]) !== -1 || pagesInViewport.indexOf(widgetsCache[allLinks.linkOrigin[i]].pageId) !== -1 ) {

                viewportLinks.linkCanvId.push(allLinks.linkCanvId[i]);
                viewportLinks.linkDest.push(allLinks.linkDest[i]);
                viewportLinks.linkOrigin.push(allLinks.linkOrigin[i]);
                viewportLinks.linkType.push(allLinks.linkType[i]);
                viewportLinks.transType.push(allLinks.transType[i]);
                viewportLinks.triggerType.push(allLinks.triggerType[i]);
            }
        }

        return viewportLinks;

    }
};



(function() {
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
        window.cancelAnimationFrame =
            window[vendors[x]+'CancelAnimationFrame'] || window[vendors[x]+'CancelRequestAnimationFrame'];
    }

    if (!window.requestAnimationFrame)
        window.requestAnimationFrame = function(callback, element) {
            var currTime = new Date().getTime();
            var timeToCall = Math.max(0, 16 - (currTime - lastTime));
            var id = window.setTimeout(function() { callback(currTime + timeToCall); },
                timeToCall);
            lastTime = currTime + timeToCall;
            return id;
        };

    if (!window.cancelAnimationFrame)
        window.cancelAnimationFrame = function(id) {
            clearTimeout(id);
        };
}());


var utils = 
{	
	selectText : function (e) // can take a this or an e
	{
		//if(e == "control+a")
		//console.log("Selecting text.");

		if(e == "control+a")
		{
			$this = $(".ui-selected").find("textarea");
		}
		else
		{
			$this = $(this);
		}
		
		//console.log("Selecting text", e, $this );
		
		$this.focus();
		$this.select();
		return false;   
	},

	getTLWH : function(element)
	{
		var elem = $(element);	
		
		if(elem.length == 0)
		{
			return {top: 0, left: 0, width: 0, height: 0};
		}
		
		var position = elem.offset();	// use css values to be sure maybe? FROM BODY
		
		//var position = {top: parseInt(elem.css("top")), left: parseInt(elem.css("left"))};
		var width = elem.outerWidth();
		var height = elem.outerHeight();
		
		return {top: position.top, left: position.left, width: width, height: height};
	}, 
		
	getCenterPoint : function(object)
	{	
		var objectTLWH = utils.getTLWH(object); //, 'outer', 100, 'absolute'
		var objectTop = Math.floor(objectTLWH.top + (objectTLWH.height/2));
		var objectLeft = Math.floor(objectTLWH.left + (objectTLWH.width/2));
		return {top: objectTop, left: objectLeft};
	},

	// TODO: this is only called in jquery.zoom. It accounts for #canvas between
	// object (.page) and #viewport. This needs to be a more generic solution that
	// handles any number of layers of differences. 
	// zoomInAndCenterOnPage()
	getTranslateDistanceToCenter : function(object, viewport)
	{
		// doesn't account for the offset of objects in between.

        var objectWidth = $(object).outerWidth();
        var objectHeight = $(object).outerHeight();
        var objectCssTop = parseFloat($(object).css('top'));	// check for auto?
        var objectCssLeft = parseFloat($(object).css('left'));	// check for auto?

        var viewportCenter = utils.getCenterPoint(viewport);	// presumes the viewport is at 100% zoom :(

        var viewportTLWH = utils.getTLWH(viewport);
        var diffX = objectWidth - viewportTLWH.width;
        var diffY = objectHeight - viewportTLWH.height;
        var maxDiff = Math.max(0, diffX, diffY);
        var fitsViewportX = maxDiff == diffX ? false : true;
        var fitsViewportY = maxDiff == diffY ? false : true;

		// for every offset between here object and viewport...
		/* Update: 20/4/11 Dave add in canvas handling */
		//console.log(parseFloat($("#canvas").css("top")),parseInt($("#canvas").css("left"))	);
//		var canvTop = parseFloat($("#canvas").css("top"));	// check for auto?
//		var canvLeft = parseFloat($("#canvas").css("left"));	// check for auto?

        var canvTop = -parseFloat($("#viewport").get(0).scrollTop);	// check for auto?
        var canvLeft = -parseFloat($("#viewport").get(0).scrollLeft);	// check for auto?

        var objectPosTop = fitsViewportY ? objectCssTop + objectHeight / 2 : objectCssTop;
        var objectPosLeft = fitsViewportX ? objectCssLeft + objectWidth / 2 : objectCssLeft;

        var translateAmountTop = viewportCenter.top - objectPosTop - canvTop;
        var translateAmountLeft = viewportCenter.left - objectPosLeft - canvLeft;

        //console.log('fitsViewportY: ', fitsViewportY, objectHeight, viewportTLWH.height, diffY);
        if(diffY>0) {
            var correction = 0.5*viewportTLWH.height - 95;
            translateAmountTop = translateAmountTop - correction;
        }

        //console.log("Top: " + viewportCenter.top + ". " + objectCssTop + ". " + objectHeight + ". " + canvTop + ". Result: " + translateAmountTop);

        return { top:  translateAmountTop, left: translateAmountLeft};
	},
	
	// get the area of a selector uss css positions.
	// used for alignment and setting the size of the rootwidget
	getBoundingAreaRelative : function(sel)
	{
		var obj = $(sel);
		//console.log("selecting",sel);
		if(obj.length == 0)
		{
			return {top:0, left:0, bottom:0, right:0};
		}
		
		var bounds = {top : null, left : null, right : null, bottom : null};
		
		$(obj).each(function()
		{	
			$t = $(this);
			// TODO: or get it from local storage object if faster?
            var tlwh = {top: parseFloat($t.css("top")), left: parseFloat($t.css("left")), width: parseFloat($t.css("width")), height: parseFloat($t.css("height")) };
            if ($t.hasClass("screen"))
            {
                var $p = $(".page", $t);
                tlwh = {top: parseFloat($t.css("top")), left: parseFloat($t.css("left")), width: parseFloat($p.css("width")), height: parseFloat($p.css("height")) };
            }
			//console.log("tlwh", tlwh);
			if( (bounds.left > tlwh.left) || bounds.left == null)
			{		
				bounds.left = tlwh.left;
			}
			if( (bounds.top > tlwh.top) || bounds.top == null)
			{	
				bounds.top = tlwh.top;
			} 
			if( (bounds.right < tlwh.left + tlwh.width) || bounds.right == null )
			{	
				bounds.right = tlwh.left + tlwh.width;
			}	
			if( (bounds.bottom < tlwh.top + tlwh.height) || bounds.bottom == null )
			{	
				bounds.bottom = tlwh.top + tlwh.height;
			}	
		});
		return bounds;
	},
	
	
	// this really doesnt do what it needs to - abosolute positioning only - see relative version of same function. 
	getBoundingArea : function(selector)
	{
		utils.boundingLeft = null; 
		utils.boundingTop = null; 
		utils.boundingRight = null; 
		utils.boundingBottom = null;
		var sel = $(selector);
		
		//console.log (sel);
		
		if(sel.length == 0)
		{
			//console.log("  No match found for selector in utils.getBoundingAreaOfSelector.", selector);
			
			return {top:0, left:0, bottom:0, right:0};
		}

		sel.each(function()
		{	
			var selectorPosition = utils.getTLWH(this);
			//console.log("Position:", selectorPosition);
			
			if( (utils.boundingLeft > selectorPosition.left) || utils.boundingLeft == null)
			{		
				utils.boundingLeft = selectorPosition.left;
			}
			if( (utils.boundingTop > selectorPosition.top) || utils.boundingTop == null)
			{	
				utils.boundingTop = selectorPosition.top;
			} 
			if( (utils.boundingRight < selectorPosition.left + selectorPosition.width) || utils.boundingRight == null )
			{	
				utils.boundingRight = selectorPosition.left + selectorPosition.width;
			}	
			if( (utils.boundingBottom < selectorPosition.top + selectorPosition.height) || utils.boundingBottom == null )
			{	
				utils.boundingBottom = selectorPosition.top + selectorPosition.height;
			}	
			//console.log(utils.boundingLeft);	
		});
		
		var ret = {top: utils.boundingTop,left:utils.boundingLeft, bottom:utils.boundingBottom, right:utils.boundingRight};
		//console.log("  Bounding box is " + ret.top +" " + ret.left + " " + ret.bottom + " " + ret.right + " ");	
		return ret;
	},
	
	// TODO: Check it doesnt already exist (on server too if possible)
	guid : function (prepend)
	{
		var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
		var string_length = 32;
		var randomstring = '';
	
		for (var i=0; i<string_length; i++) 
		{
			var rnum = Math.floor(Math.random() * chars.length);
			randomstring += chars.substring(rnum,rnum+1);
		}
		
		return prepend + "_" + randomstring;
	}, 
	
	prevent : function(e)
	{
	    e.stopPropagation();
	    e.preventDefault();
		return false;
	},
	
	arraysEqual : function(a1, a2)
	{
		var res = a1.length == a2.length;
		if(res)
		{
			for (var idx = 0, len = a1.length; idx < len; idx++)
			{
				res = a1[idx] === a2[idx];
				if (!res)
				{
					break;
				}
			}
		}
		
		return res;
	},
	
	
	hslToHex : function (hsl) 
	{
		function css3_hue2rgb(m1, m2, h) 
		{
			if (h < 0) h += 1;
			else if (h > 1) h -= 1;
			if (h * 6 < 1){ return m1 + (m2 - m1) * h * 6; }
			if (h * 2 < 1){ return m2; }
			if (h * 3 < 2){ return m1 + (m2 - m1) * (2 / 3 - h) * 6; }
			return m1;
		}
		var h = hsl.h/360, s = hsl.s/100, l = hsl.l/100;
		var m1, m2;

		if (l <= 0.5){m2 = l * (1 + s);}
		else{m2 = l + s - (l * s);}
		m1 = l * 2 - m2;

		var r = css3_hue2rgb(m1, m2, h + 1/3);
		var g = css3_hue2rgb(m1, m2, h);	
		var b = css3_hue2rgb(m1, m2, h - 1/3); 

		r = Math.round(r*255);
		g = Math.round(g*255);
		b = Math.round(b*255);
		
		r = parseInt(r).toString(16);
		g = parseInt(g).toString(16);
		b = parseInt(b).toString(16);
		
		if (r.length < 2) 
		{
			r = '0'+r;
		}
		if (g.length < 2) 
		{	
			g = '0'+g;
		}
		if (b.length < 2)
		{
			b = '0'+b;
		}
		
		return r + g + b;
	},	
	
	
	hex2rgba: function(hex, a)
	{
		if(!hex[0] == '#')
		{
			return false;
		}
		
		if( hex.indexOf('rgba(') === 0 )
		{
			return hex;
		}
		
		if( hex.indexOf('rgb(') === 0 )
		{
			var arrRgb;
			hex = hex.replace('rgb(', 'rgba(');
			arrRgb = hex.split(',');
			arrRgb[arrRgb.length-1] = parseInt( arrRgb[arrRgb.length-1] );
			arrRgb.push( '1)' );
			hex = arrRgb.join(',');
			
			return hex;
		}
		
		if(hex.length == '4')
		{
			hex = '#'+hex[1]+hex[1]+hex[2]+hex[2]+hex[3]+hex[3];
		}
		
		return 'rgba('+(parseInt(hex.substr(1,2), 16))+','+(parseInt(hex.substr(3,2), 16))+','+(parseInt( hex.substr(5,2), 16 ))+','+(a || 1)+')';
	},

	rgb2hex: function(rgb) {
		rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
		function hex(x) {
			return ("0" + parseInt(x).toString(16)).slice(-2);
		}
		return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
	},


	//hexToHSL : function(hex, originalColor) // no hash
	// converts hex, rgb or rgba to hsl.
	toHSL: function(input)
	{
		//console.log("inpuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuut",input);
		var input = (input) ? input : 'rgb(0, 0, 0)'; 
		input=input.replace(/ /g,"");

		if(input.match(/hsla/gi))
		{
			return {h: input.match(/[0-9]*/g)[5], s: input.match(/[0-9]*/g)[7], l: input.match(/[0-9]*/g)[10]};
		}
		if(input.match(/hsl/gi))
		{
			return {h: input.match(/[0-9]*/g)[4], s: input.match(/[0-9]*/g)[6], l: input.match(/[0-9]*/g)[9]};
		}	
		
		if(input.match(/#/gi))
		{
			if(input.length == 4)
			{
				input = '#'+input[1]+input[1]+input[2]+input[2]+input[3]+input[3];
			}
			else if(input.length != 7)
			{
				input = '#000000';
			}
			var r =  parseInt(input.substring(1,3), 16);
			var g =  parseInt(input.substring(3,5), 16);
			var b =  parseInt(input.substring(5,7), 16);
		}
		else if(input.match(/rgba/gi))
		{
			var r =  input.match(/[0-9]*/g)[5];
			var g =  input.match(/[0-9]*/g)[7];
			var b =  input.match(/[0-9]*/g)[9];
		}
		else if(input.match(/rgb/gi))
		{
			var r =  input.match(/[0-9]*/g)[4];
			var g =  input.match(/[0-9]*/g)[6];
			var b =  input.match(/[0-9]*/g)[8];
		}

		r /= 255, g /= 255, b /= 255;
		
		var maxColor = Math.max(r, g, b);
		var minColor = Math.min(r, g, b);
		
		var h = 0;
		var s = 0;
		var l = (maxColor + minColor) / 2;
		
		if (maxColor != minColor) // if 3 colors not the same, does this - color / not greyscale.
		{
			var chroma = maxColor - minColor;
			s = (l < 0.5) ? chroma / (maxColor + minColor) : chroma / (2 - maxColor - minColor);
			switch (maxColor) 
			{
				case r: h = (g - b) / chroma; break;
				case g: h = (b - r) / chroma + 2; break;
				case b: h = (r - g) / chroma + 4; break;
			}
		  
			h /= 6;
			if (h < 0)
			{		  
				h += 1;
			}
		}
		
		h = h * 360;
		l = l * 100;
		s = s * 100;
		return {h:h, s:s, l:l};	
	},
	
	
	
	
	replaceRgbaAlpha: function(rgba, a)
	{
		var isRgba = rgba.match(/rgba/i);
		if(isRgba)
		{
			//console.log('rgba: ', isRgba);
			ret = rgba.split(',');
			ret[ret.length-1] = a+')';
			ret = ret.join(',');
			return ret;
		}
		return rgba;
	},
	
	getRgbaAlpha: function(rgba){
		if(rgba[0] == '#' || rgba.indexOf('rgb(') != -1 ) return 1;
		var ret = rgba.split(',');
		ret = ret[ret.length-1];
		ret = parseFloat(ret);
		return ret;
	},
	
	getAlphaFromColor: function(color){
		if( color[0] == '#' ) return 1;
		else if( color.indexOf('rgba(') === 0  ){
			color = color.split(',');
			color = color[color.length - 1].replace(')', '');
			return color;
		} 
		return 1;
	},


    //DA:17-Mar-2012: Method that informs if the site is being visited with a mobile device
    //Supported devices:  Android, iPhone, iPad
    isMobileDevice: function()
    {
        var response = false;
        if(navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) ||
           navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/Android/i))
        {
            response = true;
        }
        return response;
    },

    //DA:29-Mar-2012: Method that informs if the site requires to hide the browser's bar
    //Supported/required devices:  Android
    hideBrowserBar: function()
    {
        var response = false;
        if (navigator.userAgent.match(/Android/i))
        {
            response = true;
        }
        return response;
    },

	isMouseOver : function(event, elem)
	{
		var offset = elem.offset();
		return event.pageX >= offset.left && event.pageX < (offset.left + elem.outerWidth()) &&
			   event.pageY >= offset.top && event.pageY < (offset.top + elem.outerHeight());
	},
	
	relativeMousePos : function(event, elem)
	{
		var offset = elem.offset();
		return {
			top : event.pageY - offset.top,
			left : event.pageX - offset.left
		};
	},
	
	animateRaf : function(render, duration, easing, finished)
	{
		if ($.isFunction(easing))
		{
			finished = easing;
			easing = undefined;
		}
		
		var startTime, endTime, hasPerfTimer, convToHiResClock = false;
		var raf = window.requestAnimationFrame || window.webkitRequestAnimationFrame || function(step) {
			window.setTimeout(function() {
				step(new Date().valueOf());
			}, 16.667);
		};
	
		function step(time)
		{
			// Chrome 24 now passes hi-resolution time since page load
			if (!convToHiResClock && time < 946684800000)
			{
				if (hasPerfTimer)
				{
					startTime = startTimeHiResClock;
					endTime = endTimeHiResClock;
					convToHiResClock = true;
				}
				else
				{
					time = new Date().valueOf();
				}
			}

			var progressMs = time - startTime;
			var progress = endTime != startTime ? progressMs / duration : 1;
			if (progress < 1)
			{
				if (easing)
				{
					progress = easing(progress, progressMs, 0, 1, duration);
				}
				
				render(progress);
				raf(step);
			}
			else
			{
				render(1);
				if (finished && $.isFunction(finished))
				{
					window.setTimeout(finished, 10);
				}
			}
		}
		
		if (duration === undefined)
		{
			duration = 300;
		}

		hasPerfTimer = window.hasOwnProperty('performance') && window.performance.hasOwnProperty('now');
		
		startTime = new Date().valueOf();
		startTimeHiResClock = hasPerfTimer ? window.performance.now() : startTime;
		endTime = startTime + duration;
		endTimeHiResClock = startTimeHiResClock + duration;
		
		if (easing)
		{
			easing = $.easing[easing];
		}
		
		raf(step);
	}, 
	
	toPercent : function(numerator, denominator, decimalPlaces) // "0" NaNNaNNaN:)
	{
		if (typeof numerator == 'string')
		{
			var pcVal = utils.parsePercentString(numerator);
			numerator = pcVal && !isNaN(pcVal) ? pcVal * denominator / 100.0 : parseFloat(numerator);
		}

		var v = numerator * 100 / denominator;
		var t = Math.pow(10, decimalPlaces);
		return (Math.round(v*t))/t;
	},

	parsePercentString : function(val)
	{
		var res = NaN;

		if (typeof val == 'string')
		{
			var match = val.match(/^\s*(\d+(?:\.\d*)?|\.\d+)\s*\%\s*$/);
			if (match)
			{
				res = parseFloat(match[1]);
			}
		}

		return res;
	},

	isPercentString : function(val)
	{
		var res = utils.parsePercentString(val);
		return Boolean(res) && !isNaN(res);
	},
	
	fromPercentString : function(val, total)
	{
		var res = utils.parsePercentString(val);
		
		if (res && !isNaN(res))
		{
			res *= total / 100.0;
		}

		return res;
	},

    getNavigationKeyDirection : function(keyCode)
    {
        var key = "";
        switch(keyCode)
        {
            case 37: key = "left"; break;
            case 38: key = "top"; break;
            case 39: key = "right"; break;
            case 40: key = "bottom"; break;
        }

        return key;
    },

    replaceTooltip: function(e)
    {
        /*
        var el = $(e.target);
        if (el.attr("title") == "") { return; }

        var title = el.attr("title");
        el.removeAttr("title alt").attr("data-tooltip", title);
        */
    },

	Vector: (function () {
		function Vector(x, y, z) {
		    // ensure that "new" is used
		    if (!(this instanceof Vector)) {
		        return new Vector(x, y, z);
		    }
		    
		    if (x instanceof Object) {
		        y = x.y;
		        z = x.z
		        x = x.x;
		    }
		    z = z || 0;
		    if (typeof x !== 'number' || typeof y !== 'number') {
		        x = y = z = 0;
		    }

		    this.x = x;
		    this.y = y;
		    this.z = z;
		    
		    Vector.created++;
		}

		Vector.created = 0;

		Vector.prototype = {
		    set: function (x, y, z) {
		        if (x instanceof Object) {
		            y = x.y;
		            x = x.x;
		            z = x.z
		        }
		        z = z || 0;
		        if (typeof x === 'number' && typeof y === 'number' && typeof z === 'number') {
		            this.x = x;
		            this.y = y;
		            this.z = z;
		        }
		        return this;
		    },

		    distanceTo: function (other) {
		        var x = this.x - other.x,
		            y = this.y - other.y,
		            z = this.z - other.z;

		        return Math.sqrt(x * x + y * y + z * z);
		    },

		    distanceSqTo: function (other) {
		        var x = this.x - other.x,
		            y = this.y - other.y,
		            z = this.z - other.z;

		        return x * x + y * y;
		    },

		    plus: function (other) {
		        return new Vector(
		                this.x + other.x,
		                this.y + other.y,
		                this.z + other.z);
		    },

		    minus: function (other) {
		        return new Vector(
		                this.x - other.x,
		                this.y - other.y,
		                this.z - other.z);
		    },

		    scale: function (scalar) {
		        return new Vector (
		                this.x * scalar,
		                this.y * scalar,
		                this.z * scalar);
		    },

		    dot: function (other) {
		        return this.x * other.x + this.y * other.y + this.z * other.z;
		    },

		    magnitude: function () {
		        return Math.sqrt(this.x*this.x + this.y*this.y + this.z*this.z);
		    },

		    angle: function (other) {
		        if (!other) {
		            other = Vector.I;
		        }
		        else {
		            return this.angle() - other.angle();
		        }

		        if (this.y < 0) {
		            return 2 * Math.PI - (new Vector(this.x, -this.y, this.y)).angle(other);
		        }

		        return Math.acos(this.dot(other) / (this.magnitude() * other.magnitude()));
		    },

		    rotateBy: function (angle) {
		        if (angle > Math.PI) {
		            return this.rotateBy(-(2 * Math.PI - angle));
		        }
		        else if (angle < -Math.PI) {
		             return this.rotateBy(2 * Math.PI + angle);
		        }

		        return new Vector(
		            this.x * Math.cos(angle) - this.y * Math.sin(angle),
		            this.x * Math.sin(angle) + this.y * Math.cos(angle));
		    },

		    rotateTo: function (angle) {
		        var dAngle = angle - this.angle();
		        return this.rotateBy(dAngle);
		    },

		    unitVector: function () {
		        return this.scale(1 / this.magnitude());
		    },
		    
		    // The methods below modify the vector
		    add: function (other) {
		        this.x += other.x;
		        this.y += other.y;
		        
		        return this;
		    },

		    sub: function (other) {
		        this.x -= other.x;
		        this.y -= other.y;
		        
		        return this;
		    },

		    mul: function (scalar) {
		        this.x *= scalar;
		        this.y *= scalar;
		        
		        return this;
		    },

		    rotBy: function (angle) {
		        this.x = this.x * Math.cos(angle) - this.y * Math.sin(angle);
		        this.y = this.x * Math.sin(angle) + this.y * Math.cos(angle);
		        
		        return this;
		    },

		    rotTo: function (angle) {
		        var dAngle = angle - this.angle();
		        return this.rotBy(dAngle);
		    },

		    copy: function () {
		        return new Vector(this.x, this.y);
		    },
		};

		Vector.I = Object.freeze(new Vector(1, 0, 0))
		Vector.J = Object.freeze(new Vector(0, 1, 0));
		Vector.K = Object.freeze(new Vector(0, 0, 1));

		return Vector;
		}()),

		drawVectors: function (c, points, rounding) {
			var radiusVectors  = [],
				lengths = [],
				radius  = rounding[0],
				radii   = [],
				len     = points.length;

			for (var prev = len - 1, i = 0; i < len; i++) {
				lengths[prev] = points[i].distanceTo(points[prev]);

				prev = i;
			}

			for (var i = 0, prev = len - 1; i < len; i++) {
				radii[i] = Math.min(radius, lengths[prev] / 2, lengths[i] / 2);
			}

			for (var prev = len - 1, i = 0; i < len; i++) {
				radiusVectors[prev] = points[i].minus(points[prev]).unitVector().scale(radii[prev]);

				prev = i;
			}

			var target = points[0].plus(radiusVectors[0]);
			c.moveTo(target.x, target.y);

			for (i = 0; i < len; i++) {
				var plus1 = i < len - 1? i + 1: 0;

				target = points[plus1].minus(radiusVectors[i]);
				c.lineTo(target.x, target.y);

				target = points[plus1].plus(radiusVectors[plus1]);
				c.quadraticCurveTo(points[plus1].x, points[plus1].y, target.x, target.y);
			}

		}
 };

jQuery.fn.removeWhitespace = function()
{
    var textNodes = this.contents().
		filter(function() {
			return this.nodeType == 3 && !/\S/.test(this.nodeValue);
		}).
		remove();
	
    return this;
};

var qrCode = {
	setURL : function(code, size) {
        qrCode._setCode(document.querySelector('#qrHolder img'), code, size);
	},

    setShareURL : function(code, size) {
        var elements = document.querySelectorAll('.qrContainer');

        fluid.util._.each(elements, function (element) {
            qrCode._setCode(element, code, size);
        })
    },

    _setCode : function(element, code, size) {
        if (element instanceof HTMLImageElement) {
            element.src = qr.dataUrl(code);
        }
        else {
            element.style.backgroundImage = 'url(' + qr.dataUrl(code, size || 200) + ')';
            element.style.backgroundPosition = 'center';
            element.style.backgroundRepeat = 'no-repeat';
        }
    }
};

//bind polyfill
if (!Function.prototype.bind) {
    Function.prototype.bind = function (oThis) {
        if (typeof this !== "function") {
            // closest thing possible to the ECMAScript 5 internal IsCallable function
            throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
        }

        var aArgs = Array.prototype.slice.call(arguments, 1),
            fToBind = this,
            fNOP = function () {},
            fBound = function () {
                return fToBind.apply(this instanceof fNOP && oThis
                    ? this
                    : oThis,
                    aArgs.concat(Array.prototype.slice.call(arguments)));
            };

        fNOP.prototype = this.prototype;
        fBound.prototype = new fNOP();

        return fBound;
    };
}


if(!window.fluid) {
    window.fluid = {};
};

fluid.wdgProvider = function() {
    //this property is private so no other external function can modify it
    var widgetsObj = window.widgets ? $.extend(true, {}, widgets) : null;

    return {
        getWidgets: function(addOriginId) {
            var widgets = $.extend(true, {}, widgetsObj.summary);
            if(addOriginId) {
                for(var key in widgets) {
                    if(widgets.hasOwnProperty(key)) {
                        widgets[key].originId = key;
                    }
                }
            }
            return widgets;
        },

        /*getRootWidgets: function(group, addOriginId) {
         var ret = {};

         for( var key in widgetsObj.summary) {
         if( widgetsObj.summary.hasOwnProperty(key)
         && widgetsObj.summary[key].g
         && (group==undefined || widgetsObj.summary[key].g.indexOf(group) != -1) ) {
         ret[key] = widgetsObj.summary[key];
         if(addOriginId) {
         ret[key].originId = key;
         }
         }
         }
         console.log(ret);
         return ret;
         },*/

        getRootWidgets: function(group, addOriginId) {
            var ret = [];

            for( var key in widgetsObj.summary) {
                if( widgetsObj.summary.hasOwnProperty(key)
                    && widgetsObj.summary[key].g
                    //&& (key == 'widget911')
                    && (group==undefined || widgetsObj.summary[key].g.indexOf(group) != -1) ) {
                    ret.push(widgetsObj.summary[key]);
                    if(addOriginId) {
                        ret[ret.length-1].originId = key;
                    }

                    /*if(widgetsObj.summary[key].seg && widgetsObj.summary[key].seg.length>1) {
                     console.log('!!!!! ', key, widgetsObj.summary[key]);
                     }*/
                }
            }
            return ret;
        },
        getWdgGroups: function() {
            return $.extend(true, {}, widgetsObj.g);
        },

        getChildWidgets: function(wdgObj, addOriginId) {
            var children = [];
            var childId;
            var child;

            for(var i=0; i<wdgObj.ad.length; i++) {
                childId = wdgObj.ad[i][0];
                child = $.extend(true, {}, widgetsObj.summary[childId]);
                if(addOriginId) {
                    child.originId = childId;
                }
                children.push( child );
            }

            return children;
        },

        getById: function(id) {
            return $.extend(true, {}, widgetsObj.summary[id]);
        },

        getChildById: function(id, parentWdg) {
            parentChildren = parentWdg && parentWdg.ad ? parentWdg.ad : null;

            if(parentChildren && parentChildren.length) {
                for(var i=0; i<parentChildren.length; i++) {
                    if(id == parentChildren[i][0]) {
                        return parentChildren[i];
                    }
                }
            }
            return false;
        }
    };
}();


fluid.widget = function() {

    return {

        handleCollection: function(collection, fn, params) {
            if(collection.length == undefined) {
                var retCollection = {};
                collection = $.extend(true, {}, collection);
                params.unshift({});

                for(var key in collection) {
                    if( collection.hasOwnProperty(key) ) {
                        params[0] = collection[key];
                        retCollection[key] = fn.apply(this, params);
                    }
                }
                return retCollection;
            } else {
                var retCollection = [];
                params.unshift({});

                for(var i=0; i<collection.length; i++) {
                    params[0] = collection[i];
                    retCollection.push(fn.apply(this, params));
                }
                return retCollection;
            }
        },
        setSizeLimit: function(wdgList, width, height) {
            return this.handleCollection(wdgList, function(wdgObj, width, height) {
                if( !wdgObj.wh ) {
                    wdgObj.wh = [width, height];
                } else {
                    if( typeof wdgObj.wh[0] == 'string' ) {
                        wdgObj.wh[0] = width;
                    }

                    if( typeof wdgObj.wh[1] == 'string' ) {
                        wdgObj.wh[1] = height;
                    }
                }

                return wdgObj;

            }, [width, height]);
        },

        setRootSizeLimit: function(wdgList, width, height) {
            return this.handleCollection(wdgList, function(wdgObj, width, height) {
                if(!wdgObj.g) {
                    return wdgObj;
                }

                if( !wdgObj.wh ) {
                    wdgObj.wh = [width, height];
                } else {
                    if( typeof wdgObj.wh[0] == 'string' ) {
                        wdgObj.wh[0] = width;
                    }

                    if( typeof wdgObj.wh[1] == 'string' ) {
                        wdgObj.wh[1] = height;
                    }
                }

                return wdgObj;

            }, [width, height]);
        },

        hasChildWidgets: function(wdgObj) {
            return wdgObj.ad && wdgObj.ad.length ? true : false;
        },

        hasSegments: function(wdgObj) {
            return wdgObj.sc ? true : false;
        },

        isTextWidget: function(wdgObj) {
            if(wdgObj.tc) return true;
            else return false;
        },

        isShapeWidget: function(wdgObj) {
            if(wdgObj.b || wdgObj.bg || wdgObj.bgc || wdgObj.bgd || wdgObj.i) return true;
            else return false;
        },

        isUploadWidget: function(wdgObj) {
            if(wdgObj.upload === 'y' ) return true;
            else return false;
        }


    };
}();

fluid.wdgRenderer = function(canvasWidth, canvasHeight) {
    this.canvasSize = [canvasWidth || 320, canvasHeight || 480];
    //this.canvasSize = [640, 1136];
    this.useCanvas = true;
    this.renderingQueue = {};
    this.imagesToLoad = {};
    this.uploadsToLoad = {};
    this.imagesLoaded = {};
    this.canvases = {};
    this.cropping = {
        x: 12004,
        y: 9804,
        x2: 0,
        y2: 0
    };

    this.renderBlur = true;

    this.useOneCanvas = true;

//    this.useOneCanvas = false;
//    this.renderingMode = 'singlepage';

    //only used with phantomJS
    this.setCropping = function(pageObj) {
        if( pageObj.x < this.cropping.x ) this.cropping.x = pageObj.x;
        if( pageObj.y < this.cropping.y ) this.cropping.y = pageObj.y;

        if( pageObj.x + pageObj.width > this.cropping.x2 ) this.cropping.x2 = pageObj.x + pageObj.width;
        if( pageObj.y + pageObj.height > this.cropping.y2 ) this.cropping.y2 = pageObj.y + pageObj.height;
    };

    this.generateCanvas = function(id) {
//        this.canvas = $('<canvas id="'+'pag-'+id+'">').attr({
//            width: this.canvasSize[0],
//            height: this.canvasSize[1]
//        });
        this.canvas = $('<canvas>').attr({
            width: this.canvasSize[0],
            height: this.canvasSize[1]
        });
        if(id) this.canvas.attr({
            id: 'pag-'+id
        });
        this.canvases[id] = this.canvas;
        //console.log('generated canvas: ', id, this.canvases)
        this.ctx = this.canvas.get(0).getContext('2d');
    };

    this.percentToPixel = function(box, subWdg, parentWdg) {
        //var reg = /^[0-9]+(.[0-9]+)*\%$/g;
        var whValue;

        //if(reg.test(subWdg.wh[0])) {
        if(subWdg.wh[0].indexOf && subWdg.wh[0].indexOf('%') !== -1) {
            whValue = parseInt(subWdg.wh[0], 10)/100;
            whValue = whValue * parentWdg.box[2];
            box[2] = whValue;
        }
        //if(subWdg.originId == 'widget890112') console.log('!!!!: ', subWdg.wh[1], subWdg.wh[1].indexOf('%'));
        //if(reg.test(subWdg.wh[1])) {
        if(subWdg.wh[1].indexOf && subWdg.wh[1].indexOf('%') !== -1) {
            whValue = parseInt(subWdg.wh[1], 10)/100;
            whValue = whValue * parentWdg.box[3];
            box[3] = whValue;
        }

        return box;
    };

    this.getPixelDimensions = function(box, subWdg, parentWdg) {
        if(subWdg.wh && typeof subWdg.wh[0] == 'number' ) {
            box[2] = subWdg.wh[0];
        }

        if(subWdg.wh && typeof subWdg.wh[1] == 'number' ) {
            box[3] = subWdg.wh[1];
        }

        return box;
    };

    this.parseBoxValue = function(val, boxVal) {
        if(typeof(val) === 'number') return val;
        else return ( parseFloat(val)/100 ) * boxVal;
    };

    this.calculateBox = function(subWdg, parentWdg, childConfig) {
        //debugger;
        //if(subWdg.originId == 'widget890112') debugger;

        //default box for root widgets
        if(!parentWdg){
            parentWdg = {box: [0,0,this.canvasSize[0], this.canvasSize[1]]};
        }
        var box = [0, 0];
        var offset;



        if(subWdg.tlwh) {
            box = [
                this.parseBoxValue(subWdg.tlwh[1], parentWdg.box[2]),   //left
                this.parseBoxValue(subWdg.tlwh[0], parentWdg.box[3]),   //top
                this.parseBoxValue(subWdg.tlwh[2], parentWdg.box[2]),   //width
                this.parseBoxValue(subWdg.tlwh[3], parentWdg.box[3])    //height
            ];
            //console.log('rendering pageWidget: ', subWdg.tlwh, parentWdg.box, box);
            return box;
        }



        //if(wdgObj.originId == 'widget155901') debugger;
        //console.log('calculating box: ', subWdg, parentWdg);

        //calculating width/height
        //no wh specified for subwidget, applying parent's wh
        if(!subWdg.wh) {
//            box[2] = parentWdg.wh[0];
//            box[3] = parentWdg.wh[1];
            box[2] = parentWdg.box[2];
            box[3] = parentWdg.box[3];
        } else {
            box = this.getPixelDimensions(box, subWdg, parentWdg);
            box = this.percentToPixel(box, subWdg, parentWdg);
        }

        //calculating left/top
        //console.log('childConfig: ', childConfig, subWdg, parentWdg.box);
        //if(subWdg.originId == 'widget9114') debugger;
        if(childConfig) {
            //debugger;
            //left alignment
            if(!childConfig[3] || childConfig[3][1] == 'l') {
                if(typeof childConfig[1] == 'number') box[0] = childConfig[1];
                else if(typeof childConfig[1] == 'string') {
                    //box[0] = (parseInt(childConfig[1], 10)/100) * parentWdg.wh[0];
                    box[0] = (parseInt(childConfig[1], 10)/100) * parentWdg.box[2];

                }
                //center alignment
            } else if(childConfig[3][1] == 'c') {
                var hOffset;
                if(typeof childConfig[1] == 'number' ) hOffset = childConfig[1];
                else hOffset = (parseInt(childConfig[1], 10)/100) * parentWdg.box[2];
                box[0] = (parentWdg.box[2]-box[2])/2 + hOffset;
                //right alignment
            } else {
                //if(typeof childConfig[1] == 'number') box[0] = parentWdg.wh[0]-box[2]-childConfig[1];
                if(typeof childConfig[1] == 'number') box[0] = parentWdg.box[2]-box[2]-childConfig[1];
                else if(typeof childConfig[1] == 'string') {
                    offset = (parseInt(childConfig[1], 10)/100) * parentWdg.box[3];
                    box[0] = parentWdg.box[2]-box[2]-offset;
                }
            }

            //top alignment
            if(!childConfig[3] || childConfig[3][0] == 't') {
                if(typeof childConfig[2] == 'number') box[1] = childConfig[2];
                else if(typeof childConfig[2] == 'string') {
                    box[1] = (parseInt(childConfig[2], 10)/100) * parentWdg.wh[1];
                }
                //center alignment
            } else if(childConfig[3][1] == 'c') {
                var vOffset;
                if(typeof childConfig[2] == 'number' ) vOffset = childConfig[2];
                else vOffset = (parseInt(childConfig[2], 10)/100) * parentWdg.box[3];
                box[1] = (parentWdg.box[3]-box[3])/2 + vOffset;

                //bottom alignment
            } else {
                if(typeof childConfig[2] == 'number') box[1] = parentWdg.box[3] - box[3] - childConfig[2];
                else if(typeof childConfig[2] == 'string') {
                    offset = (parseInt(childConfig[2], 10)/100) * parentWdg.wh[1];
                    box[1] = parentWdg.wh[1]-box[3]-offset;
                }
            }

        }
        box[0] = box[0] + parentWdg.box[0];
        box[1] = box[1] + parentWdg.box[1];
        //console.log('positions: ', box, subWdg);

        return box;

    };

    this.renderUpload = function(wdgObj, canvas, loadedImg) {
        $canvas = canvas || this.canvas;

        function imageLoad(canvas, img) // have img
        {
            //console.log('image loaded: ', this, arguments);
            // old image fix for library images.
            if(!wdgObj.box[2] || !wdgObj.box[3])
            {
                wdgObj.box[2] = img.width;
                wdgObj.box[3] = img.height;

            }

            var ctx = canvas.get(0).getContext('2d');
            ctx.drawImage(img, wdgObj.box[0], wdgObj.box[1], wdgObj.box[2], wdgObj.box[3]);

            img.onload = null;
            img.onerror = null;
        }

        function errorLoading(canvas, img, error) {
            //console.log('image failed to load...', this, arguments);
            //TODO: Draw text according to the available space
            canvas.addClass("failureImage");

            var ctx = canvas.get(0).getContext('2d');
            ctx.font = "32pt Arial";
            ctx.fillText("Image", 35, 50);
            ctx.fillText("not found", 10, 115);
            //console.log("Unable to draw image.");
        }

        function errorLoadingImage()
        {
            errorLoading();
            widget._convertCanvasToImg($(ctx.canvas), widgEl.find("img"), tmplVars);
        }

        function getImageData()
        {
            var response = wdgObj.data || false;
            //console.log('response: ', response, wdgObj);
            if(response && response.substr(0, 5) != 'data:') {
                response = ajax.apiObjectUrl('img', wdgObj.data); // download the image.
            } else if(wdgObj.id) {
                response = ajax.apiObjectUrl('img', wdgObj.id);
            }
            return response || errorLoading();
        }


        if(loadedImg) {
            //console.log(loadedImg);
            imageLoad($canvas, loadedImg);
            return this.canvas;
        }

        var url = getImageData();
        if(this.useCanvas) { // When canvas is required, load the image and draw it in the canvas
            //console.log('binding to: ', this, this.canvas, img);
            var img = new Image();
            img.onload = imageLoad.bind(this, $canvas, img);
            img.onerror = errorLoading.bind(this, $canvas, img);
            img.src = url;
        } else {
            var $img = widgEl.find("img");
            $img.error(errorLoadingImage);
            $img.attr('src', url);
        }

        return this.canvas;
    };

    //this is only for specific case when text line includes multiple whitespaces
    //such text should make the word followed by whitespaces wrap if its length with whitespaces exeeds line width
    this.adjustWords = function(words) {
        var newWords = [];

        for(var i=0; i<words.length; i++) {
            if(words[i] !== '') newWords.push(words[i]);
            else if(browserDetect.browser === 'Firefox') newWords[newWords.length-1] += ' ';
        }

        return newWords;
    };

    this.wrapText = function(ctx, text, box, lineHeight, align, fontSize) {
        if(box[3] < 0) return 0;
        //var ctx = this.ctx;
        var words = text.split(' ');
        var line = '';
        var nextLine = '';
        var lineCount = 0;
        var testLine, testWidth;
        var lineWidth;
		var wordSeparator = ' ';
        var y = box[1];
        if( isNaN(lineHeight) ) {
            lineHeight = 13;
        }

        words = this.adjustWords(words);

		//if(text.match(/[\u3400-\u9FBF]/)) {
		//if(text.match(/[\u3000-\u303f\u3040-\u309f\u30a0-\u30ff\uff00-\uff9f\u4e00-\u9faf\u3400-\u4dbf]/)) {

		if(text.match(/[\u3131-\uCB4C]/)) {
			wordSeparator = '';
			words = text.split('');
		}

        for(var n = 0; n < words.length; n++) {
            testLine = line + words[n] + wordSeparator;
            testWidth = ctx.measureText(testLine).width;
            //console.log('bbbb: ', testWidth > box[2] && n < words.length-1 );
            //lineWidth = ctx.measureText(line).width;
            //console.log('bbbb: ', testLine, testWidth, words[n]);

            if( browserDetect.browser !== 'Firefox' ) testWidth = testWidth + Math.round(-0.285714286 * parseFloat(fontSize) +0.075 );

            if(testWidth > box[2]  && words.length !== 1 ) {
                nextLine = words[n] + wordSeparator;

                //webkit browsers tend to wrap the words containg "-" sign
                if(browserDetect.browser !== 'Firefox' && words[n].indexOf('-') !== -1) {
                    var dashBreakLine = line + words[n].substring(0, words[n].indexOf('-')+1);
                    if( ctx.measureText(dashBreakLine).width <= box[2]) {
                        line = dashBreakLine;
                        nextLine = words[n].substring(words[n].indexOf('-')+1) + wordSeparator;
                    }

                    //console.log('break: ', line, words[n], dashBreakLine, nextLine );
                }

                //console.log('line: ', line);
                if(y + lineHeight * 0.5 > box[1] + box[3]) return lineCount;
                lineWidth = ctx.measureText(line).width;
                if( browserDetect.browser !== 'Firefox' ) lineWidth = lineWidth + Math.round(-0.285714286 * parseFloat(fontSize) +0.075 );

                //single word line too large for the box - next line of text will be rendered with a single whitespace
                // as a prefix - this mimics default webkit browser behaviour
                if(lineWidth > box[2] && line.indexOf(' ') === line.length-1 && browserDetect.browser !== 'Firefox'){
                    //console.log('line too big!!: ', line, line.indexOf(' '),  words[n], words[n].length);
                    nextLine = wordSeparator + nextLine;
                }

                if(align && align[1] === 'c') {
                    ctx.fillText(line, box[0]+(box[2]/2)-(lineWidth/2), y);
                } else if(align && align[1] === 'r') {
                    ctx.fillText(line, box[0]+box[2]-lineWidth, y);
                } else {
                    ctx.fillText(line, box[0], y);
                }
                line = nextLine;
                y += lineHeight;
//                console.log('y: ', line+' ', y,  box[1] + box[3]);

                lineCount++;
            }
            else {
                line = testLine;
            }
        }
        if(y + lineHeight * 0.5 > box[1] + box[3]) return lineCount;
        //console.log('line: ', line);

        lineWidth = ctx.measureText(line).width;
        lineWidth = lineWidth + Math.round(-0.285714286 * parseFloat(fontSize) +0.075 )

        if(align && align[1] === 'c') {
            ctx.fillText(line, box[0]+(box[2]/2)-(lineWidth/2), y);
        } else if(align && align[1] === 'r') {
            ctx.fillText(line, box[0]+box[2]-lineWidth, y);
        } else {
            ctx.fillText(line, box[0], y);
        }
        return lineCount;
    };

    this.renderText = function(wdgObj, $canvas) {
        var style = wdgObj.ts.replace(/"/g, '');
        //console.log('text box: ', wdgObj.box);
        if(!this.useOneCanvas) {
            if(this.renderingMode === 'singlepage') {
                return $('<div class="widgetText" style="'+style+';width: 100%;height:100%;">'+wdgObj.tc+'</div>');
            }else {
                //console.log(wdgObj.tc, wdgObj.box[0], wdgObj.box[1]);
                return $('<div class="widgetText" style="'+style+';width:'+(wdgObj.box[2]+3)+'px;height:'+wdgObj.box[3]+'px; top:'+wdgObj.box[1]+'px; left:'+wdgObj.box[0]+'px;">'+wdgObj.tc+'</div>');
            }
        } else {
            var semicolonIdx = 0;
            var content = wdgObj.tc.replace(/&nbsp/g,' ');
            var contentArr = content.split('\n');
            var lineHeight;
            var $canvas = $canvas || this.canvas;
            //console.log('text draw: ', $canvas.get(0) );
            var ctx = $canvas.get(0).getContext('2d');
            var font = style.match(/font:[a-zA-Z0-9\s:\/]*;/);
            var fontSize = style.match(/[0-9]+px/);
            if(fontSize) {
                fontSize = parseInt(fontSize[0], 10);
            }
            if(font){
                font = font[0];
                font = font.replace('font:', '');
                font = font.replace(';', '');
            } else {
                var fontStyle = style.substring( style.indexOf('font-style')+11, style.indexOf(';', style.indexOf('font-style'))).trim();
                var fontVariant = style.substring( style.indexOf('font-variant')+13, style.indexOf(';', style.indexOf('font-variant'))).trim();
                var fontWeight = style.substring( style.indexOf('font-weight')+12, style.indexOf(';', style.indexOf('font-weight'))).trim();
                fontSize = style.substring( style.indexOf('font-size')+10, style.indexOf(';', style.indexOf('font-size'))).trim();
                var fontFamily = style.substring( style.indexOf('font-family')+12, style.indexOf(';', style.indexOf('font-family'))).trim();
                lineHeight = style.substring( style.indexOf('line-height')+12, style.indexOf(';', style.indexOf('line-height'))).trim();

                font = fontStyle+' '+fontVariant+' '+fontWeight+' '+fontSize+' '+fontFamily;
            }

            //console.log('fontSize: ', fontSize);
            //console.log('style: ', style);


            var color = style.substring( style.indexOf('color')+6, style.indexOf(';', style.indexOf('color'))).trim();
            if(color.indexOf('rgb(') !== -1) {
                color = utils.rgb2hex(color);
            }
            var textAlign = style.indexOf(';', style.indexOf('text-align')) !== -1 ?
                    style.substring( style.indexOf('text-align')+11, style.indexOf(';', style.indexOf('text-align'))).trim() :
                    style.substring( style.indexOf('text-align')+11).trim();
            var textDecoration = '';
            if(style.indexOf('text-decoration') !== -1) {
                textDecoration = style.substring( style.indexOf('text-decoration')+16, style.indexOf(';', style.indexOf('text-decoration'))).trim();
            }

            var paddingTop = 0;
            if(style.indexOf('padding-top') !== -1) {
                semicolonIdx = style.indexOf(';', style.indexOf('padding-top'));
                if(semicolonIdx !== -1) paddingTop = parseInt( style.substring( style.indexOf('padding-top')+12, semicolonIdx).trim(), 10);
                else paddingTop = parseInt( style.substring( style.indexOf('padding-top')+12).trim(), 10);

            }
            var marginTop = 0;
            if(style.indexOf('margin-top') !== -1) {
                semicolonIdx = style.indexOf(';', style.indexOf('margin-top'));
                if(semicolonIdx !== -1) marginTop = parseInt( style.substring( style.indexOf('margin-top')+11, style.indexOf(';', style.indexOf('margin-top'))).trim(), 10);
                else marginTop = parseInt( style.substring( style.indexOf('margin-top')+11).trim(), 10);
            }

            //console.log('font: ', font);
            ctx.fillStyle = color;
            ctx.font = font;
            ctx.textBaseline = 'top';


            //console.log('lineHeight: ', lineHeight,', fontSize: ', fontSize);
            //console.log('!! ', fontSize, -0.07 * parseFloat(fontSize) + 2.54, Math.round( -0.07 * parseFloat(fontSize) + 2.54 ));
            var positionFix = 0;
            var fontToLinePositionFix = 0;

            if( lineHeight && parseFloat(lineHeight) ) {

                positionFix = Math.round( -0.07 * parseFloat(fontSize) + 2.66 );
                //positionFix = Math.round( -0.0655 * parseFloat(fontSize) + 2.42 );
                fontToLinePositionFix = Math.round( 0.5 * (parseFloat(lineHeight) - parseFloat(fontSize)) - 2.75 );

                lineHeight = parseFloat(lineHeight);
            } else if( font.indexOf('/') !== -1 && parseFloat( font.substring(font.indexOf('/')+1) )) {
                positionFix = Math.round( -0.07 * parseFloat(fontSize) + 2.66 );
                //positionFix = Math.round( -0.0655 * parseFloat(fontSize) + 2.42 );

                lineHeight = parseFloat( font.substring(font.indexOf('/')+1) );
            } else {

                //1.14 is most common
                lineHeight = Math.round(1.14 * parseFloat(fontSize));
            }

            if(browserDetect.browser === 'Firefox') {
                //positionFix = positionFix + Math.round(0.148148148 * parseFloat(fontSize) + 0.2 );
                positionFix = positionFix + Math.round(0.148148148 * parseFloat(fontSize) + 0.5 );
            }

            var wrappedLines = 0;


            var textBox = [wdgObj.box[0], wdgObj.box[1]+positionFix+fontToLinePositionFix+paddingTop+marginTop, wdgObj.box[2], wdgObj.box[3] ];

            //console.log('box: ', wdgObj.box[1], textBox[1], textBox, ', align: ', textAlign);
            var align = wdgObj.ca || 'lt';
            if( textAlign === 'center' ) align = align[0] + 'c';
            else if( textAlign === 'right' ) align = align[0] + 'r';
            else if( textAlign === 'left' ) align = align[0] + 'l';
            
            //console.log('aaa: ', style, wdgObj.ca );
            //console.log('rendering text: ', content, contentArr );
            if(contentArr.length == 1) {
                this.wrapText(ctx, content, textBox, lineHeight, align, fontSize);
            //multiline text with line break sign
            } else {
                //console.log('content: ', content);
                for(var i=0; i<contentArr.length; i++) {
                        //console.log('box: ', [ textBox[0], textBox[1] + (i+wrappedLines)*lineHeight, textBox[2], textBox[3] - (i+wrappedLines)*lineHeight ]);
                        wrappedLines = wrappedLines + this.wrapText(
                            ctx,
                            contentArr[i],
                            [ textBox[0], textBox[1] + (i+wrappedLines)*lineHeight, textBox[2], textBox[3] - (i+wrappedLines)*lineHeight ],
                            lineHeight,
                            align,
                            fontSize);
                }
            }



            return $canvas;
        }

    };

    // context, storageObj, mode, width/height.
    //this.paintCanvas = function(widgEl, c, wdgObj){
    this.paintCanvas = function(wdgObj, $canvas){
		var renderer = this;

        //console.log('paint canvas: ', wdgObj);
        if(!this.useOneCanvas) {
            $canvas = $('<canvas>').attr({
                width: this.renderingMode === 'singlepage' ? wdgObj.box[2] : this.canvasSize[0],
                height: this.renderingMode === 'singlepage' ? wdgObj.box[3] : this.canvasSize[1]
            });
        }else if(!$canvas) {
            $canvas = this.canvas;
        }
        var c = $canvas.get(0).getContext("2d");
        //console.log('paintCanvas: ', wdgObj, $canvas, c );

        var renderer = this;

        var draw = {
            blur : function () {

                if (wdgObj.blur) {
                    if (renderer.renderBlur) {
                        var img = document.createElement('img'),
							blurResult = widget.renderBlurLayerImmediate.call(
								renderer,
								wdgObj.id
							),
							wdgBox = jQuery.extend([], wdgObj.box),
							pageId, pageBox;

						if(!blurResult)	return false;

						if(wdgBox[0] < 0) wdgBox[0] = 0;
						if(wdgBox[1] < 0) wdgBox[1] = 0;
						if(wdgBox[2] > blurResult.width) wdgBox[2] = blurResult.width;
						if(wdgBox[3] > blurResult.height) wdgBox[3] = blurResult.height;

						//case when widgets is exceeding the page
						if(widgetsCache && widgetsCache[wdgObj.id]) {
							pageId = widgetsCache[wdgObj.id].pageId;
							pageBox = pagesCache[pageId].box;

							if(wdgBox[0] + wdgBox[2] > pageBox[2]) {
								wdgBox[2] = pageBox[2] - wdgBox[0];
							}

							if(wdgBox[1] + wdgBox[3] > pageBox[3]) {
								wdgBox[3] = pageBox[3] - wdgBox[1];
							}
						}

						c.drawImage(
							blurResult,
							wdgBox[0], wdgBox[1],
							wdgBox[2], wdgBox[3],
							wdgBox[0], wdgBox[1],
							wdgBox[2], wdgBox[3] );
                    }
                }
            },

            background : function()// top left is relative to the canvas, for things like shadows etc.
            {
                c.save();

                function drawStriped()
                {
                    var colors = (wdgObj.bgc) ? wdgObj.bgc : ['#CAD1D7', '#C4CBD3'];

                    var distances = [5, 2];
                    var orientation = "v";
                    if(wdgObj.bgd)
                    {
                        orientation = wdgObj.bgd[0];
                        distances = [wdgObj.bgd[1], wdgObj.bgd[2]];
                    }

                    c.fillStyle = colors[1];
                    c.fill();
                    c.fillStyle = colors[0];

                    if(orientation == "v")
                    {
                        for(var i = distances[0] ; i< width; )
                        {
                            c.fillRect (i, 0, distances[1], height);
                            i += distances[0];
                        }
                    }
                    else
                    {
                        for(var i = distances[0] ; i< height; )
                        {
                            c.fillRect (0, i, width, distances[1]);
                            i += distances[0];
                        }
                    }
                }

                if(!width) width = 0; // fix for if wh gets corrupted!
                if(!height) height = 0; // fix for if wh gets corrupted!

                if(wdgObj.bg == 'c')	// plain colour.
                {
                    c.fillStyle = wdgObj.bgc[0];
                    c.fill();
                }
                else if(wdgObj.bg == 's')	// striped
                {
                    drawStriped();
                }
                else if(wdgObj.bg == 'l')		// Linear Gradient top to bottom
                {
                    //g = c.createLinearGradient(0, 0, 0, height );
                    var x1 = renderer.useOneCanvas ? wdgObj.box[0] : 0;
                    var y1 = renderer.useOneCanvas ? wdgObj.box[1] : 0;

                    var y2 = renderer.useOneCanvas ? wdgObj.box[1]+wdgObj.box[3] : wdgObj.box[3];


                    g = c.createLinearGradient(x1, y1, x1, y2);

                    draw._gradient(g, c, wdgObj);
                }
                else if(wdgObj.bg == 'lrl')		// Linear right left.
                {
                    g = c.createLinearGradient(wdgObj.box[0], wdgObj.box[1], wdgObj.box[0] + wdgObj.box[2], wdgObj.box[1] );
                    draw._gradient(g, c, wdgObj);
                }
                else if(wdgObj.bg == 'ld')		// Linear Gradient top left to bottom right
                {
                    g = c.createLinearGradient(wdgObj.box[0], wdgObj.box[1], wdgObj.box[0] + wdgObj.box[2], wdgObj.box[1] + wdgObj.box[3] );
                    draw._gradient(g, c, wdgObj);
                }
                else if(wdgObj.bg == 'ld2')		// Linear Gradient top right to bottom left
                {
                    g = c.createLinearGradient(wdgObj.box[0] + wdgObj.box[2], wdgObj.box[1], wdgObj.box[0], wdgObj.box[1] + wdgObj.box[3] );
                    draw._gradient(g, c, wdgObj);
                }
                else if(wdgObj.bg == 'r')		// Radial gradient.
                {
                    var halfHeight = wdgObj.box[3]/2;
                    var middleX = wdgObj.box[0] + wdgObj.box[2]/2;
                    var middleY = wdgObj.box[1] + halfHeight;

                    g = c.createRadialGradient(middleX, middleY, 0.0, middleX, middleY, halfHeight);
                    draw._gradient(g, c, wdgObj);
                }

                c.restore();
            },

            border : function(c, wdgObj, width, height)
            {
                var top = 0, left = 0;
                c.lineWidth = (typeof adjustedBorderWidth) === 'number'
                    ? adjustedBorderWidth
                    : borderWidth;
                c.strokeStyle = wdgObj.b[1];	    // rounding is b2.
                c.stroke();
                c.save()
                //console.log(c, wdgObj, width, height, wdgObj.b);
            },// draw a path of a certain type.
            path : function(c, type, rounding, top, left, width, height, borderWidth, tmplVars) // TODO: Just pass the object, getting mad...
            {
                c.beginPath();

				var borderHalfWidth = Math.floor(borderWidth/2);
                // subtract any border
                var t = top + borderHalfWidth;
                var l = left + borderHalfWidth;
                var b = top + height - borderHalfWidth;
                var r = left + width - borderHalfWidth;
				var ltrbWidth = r-l;
				var ltrbHeight = b-t;

				var shapesWithNoRounding = ['cloud', 'thumbsD', 'thumbsU'];


                //subract any shadow
                if(tmplVars.sh && tmplVars.sh[3] && tmplVars.sh[2]) // reduce the widget size by the size of the blur. TODO: in the right direction.
                {
                    t+= Math.floor(tmplVars.sh[3] - tmplVars.sh[2]/2);
                    l+= Math.floor(tmplVars.sh[3] - tmplVars.sh[2]/2);
                    b-= Math.floor(tmplVars.sh[3] + tmplVars.sh[2]/2);
                    r-= Math.floor(tmplVars.sh[3] + tmplVars.sh[2]/2);
                }
                
                if ($.isArray(rounding)) // make sure all 4 values are set
                {
                    for (var idx = 0; idx < 4; idx++)
                    {
                        rounding[idx] = rounding[idx] || 0;
                    }
                }
                else
                {
                    rounding = [rounding, rounding, rounding, rounding]; // rounding rounding rounding
                }
                
                if(type == "sq")
                {
                    // Limit the raduis to half of the shortest dimension
                    var min = Math.min((r - l) / 2, (b - t) / 2);
                    
                    rounding[0] = Math.min(rounding[0], min);
                    rounding[1] = Math.min(rounding[1], min);
                    rounding[2] = Math.min(rounding[2], min);
                    rounding[3] = Math.min(rounding[3], min);
                
                    c.moveTo(l+rounding[0], t),
                    c.lineTo(r-rounding[1], t),
                    c.quadraticCurveTo(r, t, r, t+rounding[1]),
                    c.lineTo(r, b-rounding[2]),
                    c.quadraticCurveTo(r, b, r-rounding[2], b),
                    c.lineTo(l+rounding[3], b),
                    c.quadraticCurveTo(l, b, l, b-rounding[3]),
                    c.lineTo(l, t+rounding[0]),
                    c.quadraticCurveTo(l, t, l+rounding[0], t)
    
                    //console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
                    
                }
				if(type == "arrU")
				{
					// proportionality constant for the VERTICAL arrow
					var arrowProportion = (r-l)+(5/4);
					var midX = (l+r)/2;
					var width = r-l;

					c.moveTo(midX, t+borderWidth);
					c.lineTo(r-(borderWidth/2), t+arrowProportion);
					c.lineTo(midX+width*0.15, t+arrowProportion);
					c.lineTo(midX+width*0.15, b);
					c.lineTo(midX-width*0.15, b);
					c.lineTo(midX-width*0.15, t+arrowProportion);
					c.lineTo(l+(borderWidth/2), t+arrowProportion);
					c.lineTo(midX, t+borderWidth);

					//console.log(c, type, rounding, top, left, width, height, borderWidth, wdgObj, [t,l,b,r]);
				}
				if(type == "arrD")
				{
					var arrowProportion = (r-l)+(5/4);
					var midX = (l+r)/2;
					var width = r-l;

					c.moveTo(midX, b-borderWidth);
					c.lineTo(r-(borderWidth/2), b-arrowProportion);
					c.lineTo(midX+width*0.15, b-arrowProportion);
					c.lineTo(midX+width*0.15, t);
					c.lineTo(midX-width*0.15, t);
					c.lineTo(midX-width*0.15, b-arrowProportion);
					c.lineTo(l+(borderWidth/2), b-arrowProportion);
					c.lineTo((l+r)/2, b);

					//console.log(c, type, rounding, top, left, width, height, borderWidth, wdgObj, [t,l,b,r]);
				}
				if(type == "arrR")
				{
					// drawing shape starts at the tip of the arrowhead and moves in a clockwise direction
					var arrowProportion = (b-t)+(5/4);
					var midY = (t+b)/2;
					var height = b-t;

					c.moveTo(r-borderWidth, (t+b)/2);
					c.lineTo(r-arrowProportion, b-(borderWidth/2));
					c.lineTo(r-arrowProportion, midY+height*0.15);
					c.lineTo(l, midY+height*0.15);
					c.lineTo(l, midY-height*0.15);
					c.lineTo(r-arrowProportion, midY-height*0.15);
					c.lineTo(r-arrowProportion, t+(borderWidth/2));
					c.lineTo(r-borderWidth, (t+b)/2);

					//console.log(c, type, rounding, top, left, width, height, borderWidth, wdgObj, [t,l,b,r]);
				}
				if(type == "arrL")
				{
					// drawing shape starts at the tip of the arrowhead and moves in a clockwise direction
					var arrowProportion = (b-t)+(5/4);
					var midY = (t+b)/2;
					var height = b-t;

					c.moveTo(l+borderWidth, (t+b)/2);
					c.lineTo(l+arrowProportion, b-(borderWidth/2));
					c.lineTo(l+arrowProportion, midY+height*0.15);
					c.lineTo(r, midY+height*0.15);
					c.lineTo(r, midY-height*0.15);
					c.lineTo(l+arrowProportion, midY-height*0.15);
					c.lineTo(l+arrowProportion, t+(borderWidth/2));
					c.lineTo(l+borderWidth, (t+b)/2);

					//console.log(c, type, rounding, top, left, width, height, borderWidth, wdgObj, [t,l,b,r]);
				}
				if(type == "image")
				{

					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t-Math.floor(borderWidth/2));
					// diagonal line
					c.moveTo(l, t);
					c.lineTo(r, b);

					c.moveTo(r, t);
					c.lineTo(l, b);

					//console.log(c, type, rounding, top, left, width, height, borderWidth, wdgObj, [t,l,b,r]);
				}
				else if(type == "tri") // does not support rounding.
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, t);
				}
				else if(type == "tri") // does not support rounding.
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, t);
				}
				else if(type == "trR") // does not support rounding.
				{

					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "ttrL") // does not support rounding.
				{
					c.moveTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(r, t);
				}
				else if(type == "ttrR") // does not support rounding.
				{
					c.moveTo(l, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "triU")
				{
					c.moveTo((l+r)/2, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo((l+r)/2, t);
				}
				else if(type == "triD")
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo((l+r)/2, b);
					c.lineTo(l, t);
				}
				else if(type == "triR")
				{
					c.moveTo(l, t);
					c.lineTo(r, (t+b)/2);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "triL")
				{
					c.moveTo(r, t);
					c.lineTo(l, (t+b)/2);
					c.lineTo(r, b);
					c.lineTo(r, t);
				}
				else if(type == "ribU") // ribbon
				{
					c.moveTo(l, t);
					c.lineTo((l+r)/2, t+(b-t)*0.25);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "ribD") // ribbon
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(r, b);
					c.lineTo((l+r)/2, t+0.75*(b-t));
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "flagR") // flag
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(l+(4/5)*ltrbWidth, (t+b)/2);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
				}
				else if(type == "flagL") // flag
				{
					c.moveTo(l, t);
					c.lineTo(l+(1/5)*ltrbWidth, (t+b)/2);
					c.lineTo(l, b);
					c.lineTo(r, b);
					c.lineTo(r, t);
					c.lineTo(l, t);
				}
				else if(type == "houseU") // house/envelope shape
				{
					c.moveTo((l+r)/2, t);
					c.lineTo(r, t+(3/7)*ltrbHeight);
					c.lineTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t+(3/7)*ltrbHeight);
					c.lineTo((l+r)/2, t);
				}
				else if(type == "houseD")
				{
					c.moveTo((l+r)/2, b);
					c.lineTo(r, t+(4/7)*ltrbHeight);
					c.lineTo(r, t);
					c.lineTo(l, t);
					c.lineTo(l, t+(4/7)*ltrbHeight);
					c.lineTo((l+r)/2, b);
				}
				else if(type == "oct")
				{
					c.moveTo(l+(21/72)*ltrbWidth, t);
					c.lineTo(l+(51/72)*ltrbWidth, t);
					c.lineTo(r, t+(21/72)*ltrbHeight);
					c.lineTo(r, t+(51/72)*ltrbHeight);
					c.lineTo(l+(51/72)*ltrbWidth, b);
					c.lineTo(l+(21/72)*ltrbWidth, b);
					c.lineTo(l, t+(51/72)*ltrbHeight);
					c.lineTo(l, t+(21/72)*ltrbHeight);
					c.lineTo(l+(21/72)*ltrbWidth, t);
				}
				else if(type == "star")
				{
					var midX = (l+r)/2;
					var width = r-l;
					var height = b-t;

					c.moveTo(midX, t);
					c.lineTo(l+(33/54)*width, t+(39/102)*height);
					c.lineTo(r, t+(39/102)*width);
					c.lineTo(l+(75/108)*width, t+(63/102)*height);
					c.lineTo(l+(87/108)*width, b);
					c.lineTo(midX, t+(39/51)*height);
					c.lineTo(l+(21/108)*width, b);
					c.lineTo(l+(33/108)*width, t+(63/102)*height);
					c.lineTo(l, t+(39/102)*height);
					c.lineTo(l+ (21/54)*width, t+(39/102)*height);
					c.lineTo(midX, t);
				}
				else if(type == "pgL")
				{
					c.moveTo(l, b);
					c.lineTo(r, b);
					c.lineTo(r, t);
					c.lineTo(l+(r-l)/3, t);
					c.lineTo(l, t+(b-t)/4);
					c.lineTo(l,b);
				}
				else if(type == "pgR")
				{
					c.moveTo(r, b);
					c.lineTo(l, b);
					c.lineTo(l, t);
					c.lineTo(l+(r-l)*0.66, t);
					c.lineTo(r, t+(b-t)*0.25);
					c.lineTo(r,b);
				}
				else if(type == "pointrL")
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(l+(5/7)*ltrbWidth, t+(3/7)*ltrbHeight);
					c.lineTo(l+(5/7)*ltrbWidth, b);
					c.lineTo(l, t);
				}
				else if(type == "pointrR")
				{
					c.moveTo(l, t);
					c.lineTo(r, t);
					c.lineTo(l+(2/7)*ltrbWidth, b);
					c.lineTo(l+(2/7)*ltrbWidth, t+(3/7)*ltrbHeight);
					c.lineTo(l, t);
				}
                else if(type == "ldL") 
                {
                    c.moveTo(l, t);
                    c.lineTo(l+2, t);
                    c.lineTo(r, b);
                    c.lineTo(r-2, b);
                    c.lineTo(l, t);
                }
                else if(type == "ldR") 
                {
                    c.moveTo(r, t);
                    c.lineTo(r-2, t);
                    c.lineTo(l, b);
                    c.lineTo(l+2, b);
                    c.lineTo(r, t);
                }
				else if(type == "dropD")
				{
					c.moveTo((l+r)/2, t);
					c.lineTo(l+ltrbWidth/6, (t+b)/2);
					c.bezierCurveTo(l-(ltrbWidth*(1.5/6)), b+(ltrbHeight/6.2),  r+(ltrbWidth*(1.5/6)), b+(ltrbHeight/6.2),  l+ltrbWidth*(5/6), (t+b)/2);
					c.lineTo((l+r)/2, t);
				}

				else if(type == "dropU")
				{
					c.moveTo((l+r)/2, b);
					c.lineTo(l+ltrbWidth/6, (t+b)/2);
					c.bezierCurveTo(l-(ltrbWidth*(1.5/6)), t-(ltrbHeight/6.2),  r+(ltrbWidth*(1.5/6)), t-(ltrbHeight/6.2),  l+ltrbWidth*(5/6), (t+b)/2);
					c.lineTo((l+r)/2, b);

				}
				else if(type == "oval")
				{
					c.moveTo(l, (b+t)/2);
					c.bezierCurveTo(l+ltrbWidth*(1/4), t-(ltrbHeight/7),  l+ltrbWidth*(3/4), t-(ltrbHeight/7),  r, (b+t)/2);
					c.bezierCurveTo(l+ltrbWidth*(3/4), b+(ltrbHeight/7), l+ltrbWidth*(1/4), b+(ltrbHeight/7),  l, (b+t)/2);

				}
                else if(type == "cloud") 
                {
					c.moveTo(l+ltrbWidth*(1.5/9), b);
					c.bezierCurveTo(l, b,  l, t+ltrbHeight*(7/11),  l+ltrbWidth*(1.6/9), t+ltrbHeight*(7/11));
					c.bezierCurveTo(l+ltrbWidth/9, t+ltrbHeight/3, l+ltrbWidth/3, t+ltrbHeight/6.3,  l+ltrbWidth*(4/9), t+ltrbHeight/3.2);
					c.bezierCurveTo(l+ltrbWidth*(4.5/9), t, l+ltrbWidth*(7.4/9), t,  l+ltrbWidth*(7.3/9), (b+t)/2);
					c.bezierCurveTo(r, (b+t)/2, r, b,  l+ltrbWidth*(7.7/9), b);
					c.lineTo(l+ltrbWidth*(1.5/9), b);
                    
                }
                else if(type == "person") 
                {
                    c.moveTo(l, b);       
                    c.bezierCurveTo((l+r)/16, (t+b)*(11/14),  (l+r)*(3/16), (t+b)*(10/14),  (l+r)*(6/16), (b+t)*(9/14));
                    c.bezierCurveTo((l+r)*(2.5/16), (t+b)*(4/7), (l+r)*(2.5/16), t,  (l+r)/2, t);
                    c.bezierCurveTo((l+r)*(13.5/16), t, (l+r)*(13.5/16), (t+b)*(4/7),  (l+r)*(10/16), (b+t)*(9/14));
                    c.bezierCurveTo((l+r)*(13/16), (t+b)*(10/14),  (l+r)*(15/16), (t+b)*(11/14),  r, b);
                    c.lineTo(l, b);
                    
                }
                else if(type == "thumbsU") 
                {
					c.moveTo(l, t+ltrbHeight*(16/17));
					c.lineTo(l, t+ltrbHeight*(15/34));
					c.bezierCurveTo(l+ltrbWidth*(2/15), t+ltrbHeight*(7/17),  l+ltrbWidth*(9/30), t+ltrbHeight*(4/17),  l+ltrbWidth/3, t+ltrbHeight*(3/34));
					c.bezierCurveTo(l+ltrbWidth*(5.2/15), t, l+ltrbWidth*(9/15), t,  l+ltrbWidth*(8.5/15), t+ltrbHeight*(2/17));
					c.lineTo(l+ltrbWidth*(7/15), t+ltrbHeight*(11/34));
					c.bezierCurveTo(l+ltrbWidth*(9/15), t+ltrbHeight*(13/34), l+ltrbWidth*(11/15), t+ltrbHeight*(13/34),  l+ltrbWidth*(12/15), t+ltrbHeight*(13/34));
					c.bezierCurveTo(r, t+ltrbHeight*(13/34),  r, t+ltrbHeight*(19/34), l+ltrbWidth*(12/15), t+ltrbHeight*(19/34) ); // finger
					c.bezierCurveTo(l+ltrbWidth*(14/15), t+ltrbHeight*(19/34),  l+ltrbWidth*(27/30), t+ltrbHeight*(12/17), l+ltrbWidth*(23/30), t+ltrbHeight*(12/17)); // finger1
					c.bezierCurveTo(l+ltrbWidth*(13/15), t+ltrbHeight*(12/17),  l+ltrbWidth*(25/30), t+ltrbHeight*(29/34), l+ltrbWidth*(11/15), t+ltrbHeight*(29/34)); // finger2
					c.bezierCurveTo(l+ltrbWidth*(25/30), t+ltrbHeight*(29/34),  l+ltrbWidth*(12/15), b, l+ltrbWidth*(8.5/15), b); // finger3
					c.bezierCurveTo((l+r)/2, b,  l+ltrbWidth/5, b, l, t+ltrbHeight*(16/17)); // close the shape
                }
                else if(type == "thumbsD") 
                {
					c.moveTo(l, t+ltrbHeight/17);
					c.lineTo(l, t+ltrbHeight*(19/34));
					c.bezierCurveTo(l+ltrbWidth*(2/15), t+ltrbHeight*(10/17),  l+ltrbWidth*(9/30), t+ltrbHeight*(13/17),  l+ltrbWidth/3, t+ltrbHeight*(31/34));
					c.bezierCurveTo(l+ltrbWidth*(5.2/15), b, l+ltrbWidth*(9/15), b,  l+ltrbWidth*(8.5/15), t+ltrbHeight*(15/17));
					c.lineTo(l+ltrbWidth*(7/15), t+ltrbHeight*(23/34));
					c.bezierCurveTo(l+ltrbWidth*(9/15), t+ltrbHeight*(21/34), l+ltrbWidth*(11/15), t+ltrbHeight*(21/34),  l+ltrbWidth*(12/15), t+ltrbHeight*(21/34));
					c.bezierCurveTo(r, t+ltrbHeight*(21/34),  r, t+ltrbHeight*(15/34), l+ltrbWidth*(12/15), t+ltrbHeight*(15/34) ); // finger
					c.bezierCurveTo(l+ltrbWidth*(14/15), t+ltrbHeight*(15/34),  l+ltrbWidth*(27/30), t+ltrbHeight*(5/17), l+ltrbWidth*(23/30), t+ltrbHeight*(5/17)); // finger1
					c.bezierCurveTo(l+ltrbWidth*(13/15), t+ltrbHeight*(5/17),  l+ltrbWidth*(25/30), t+ltrbHeight*(5/34), l+ltrbWidth*(11/15), t+ltrbHeight*(5/34)); // finger2
					c.bezierCurveTo(l+ltrbWidth*(25/30), t+ltrbHeight*(5/34),  l+ltrbWidth*(12/15), t, l+ltrbWidth*(8.5/15), t); // finger3
					c.bezierCurveTo(l+ltrbWidth/2, t,  l+ltrbWidth/5, t, l, t+ltrbHeight/17); // close the shape
                }
                else if(type == "arcL") 
                {
                    var width = r-l; //this arc is split into two semicircles
                    var height = b-t;
                    var radius = (height >= (width * 2)) ? width : height / 2;
            
                    c.moveTo(l+radius, t);
                    c.arcTo(l, t, l, t+radius, radius);
                    c.arcTo(l, t+(2*radius), l+radius,t+(2*radius), radius);
                    c.lineTo(l+radius,t);
                }
                else if(type == "arcR")
                {
                    var width = r-l; //this arc is split into two semicircles
                    var height = b-t;
                    var radius = (height >= (width * 2)) ? width : height / 2;
                    
                    c.moveTo(l, t);
                    c.arcTo(l+radius, t, l+radius, t+radius, radius);
                    c.arcTo(l+radius, t+(2*radius), l,t+(2*radius), radius);
                    c.lineTo(l, t);
                }
                else if(type == "arcU")
                {
                    var width = r-l; //this arc is split into two semicircles
                    var height = b-t;
                    var radius = (width >= (height * 2)) ? height : width / 2;
                    
                    c.moveTo(l, t+radius);
                    c.arcTo(l, t, l+radius, t, radius);
                    c.arcTo(l+(2*radius), t, l+(2*radius),t+(2*radius), radius);
                    c.lineTo(l, t+radius);
                }
                else if(type == "arcD")
                {
                    var width = r-l; //this arc is split into two semicircles
                    var height = b-t;
                    var radius = (width >= (height * 2)) ? height : width / 2;
                    
                    c.moveTo(l, t);
                    c.arcTo(l, t+radius, l+radius, t+radius, radius);
                    c.arcTo(l+(2*radius), t+radius, l+(2*radius),t, radius);
                    c.lineTo(l, t);
                }
				else if(type == "folder")
				{
					var width = r-l;
					var height = b-t;

					c.moveTo(l+(3/8)*width, t+(2/15)*height);
					c.lineTo(r-rounding[1], t+(2/15)*height);
					c.quadraticCurveTo(r, t+(2/15)*height, r, (t+(2/15)*height)+rounding[1]);
					c.lineTo(r, b-rounding[2]);
					c.quadraticCurveTo(r, b, r-rounding[2], b);
					c.lineTo(l+rounding[3], b);
					c.quadraticCurveTo(l, b, l, b-rounding[3]);
					c.lineTo(l, t+rounding[0]);
					c.quadraticCurveTo(l, t, l+rounding[0], t);
					c.lineTo(l+(5/16)*width, t);
					c.lineTo(l+(3/8)*width, t+(2/15)*height);
				}
                if(type == "speechRight")
                {
                    c.moveTo(r-17, b);
                    c.lineTo(r-96, b-13);
                    c.lineTo(l, b-13);
                    c.lineTo(l, t);
                    c.lineTo(r, t);
                    c.lineTo(r, b-13);
                    c.lineTo(r-38, b-13);
                    c.lineTo(r-17, b);
            
                    //console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
                    
                }
                if(type == "speechLeft")
                {
                    c.moveTo(l+17, b);
                    c.lineTo(l+96, b-13);
                    c.lineTo(r, b-13);
                    c.lineTo(r, t);
                    c.lineTo(l, t);
                    c.lineTo(l, b-13);
                    c.lineTo(l+38, b-13);
                    c.lineTo(l+17, b);
            
                    //console.log(c, type, rounding, top, left, width, height, borderWidth, tmplVars, [t,l,b,r]);
                    
                }
                else if(type == "bubr")
                {
					right = left+width-1;
					bottom = top+height-2;
					tailSize = 7; // centralise

					if(wdgObj.b) // TODO: c/p in bubbL - merge
					{
						top = top + wdgObj.b[0]/2;
						left = left + wdgObj.b[0]/2;
						right = right - wdgObj.b[0]/2;
						bottom = bottom - wdgObj.b[0]/2;
					}
                    
                    c.moveTo(right-tailSize, bottom-7); // right side before curve, give 10 pixels for the tail.
                    c.lineTo(right-tailSize, top+rounding[1]);
                    c.quadraticCurveTo(right-tailSize, top, right-rounding[1]-tailSize, top);
                    c.lineTo(left+rounding[0], top);
                    c.quadraticCurveTo(left, top, left, top+rounding[0]);
                    c.lineTo(left, bottom-rounding[3]);
                    c.quadraticCurveTo(left, bottom, left+rounding[3], bottom);
                    c.lineTo(right-19, bottom);
                    c.quadraticCurveTo(right-15,       bottom-1, right-14,     bottom-2); // bottom lead in to tail.
                    c.quadraticCurveTo(right-7,     bottom+1, right-1,      bottom-2); // bottom of tail
                    c.quadraticCurveTo(right-tailSize, bottom-3, right-tailSize, bottom-7); // top of tail.
                }
                else if(type == "bubl")
                {
					right = left+width-1; // doesnt account for borders!
					bottom = top+height-2; // doesnt account for borders!
					tailSize = 7; // centralise

					if(wdgObj.b)
					{
						top = top + wdgObj.b[0]/2;
						left = left + wdgObj.b[0]/2;
						right = right - wdgObj.b[0]/2;
						bottom = bottom - wdgObj.b[0]/2;
					}
                    
                    c.moveTo(right, bottom-rounding[2]); // bottom right line,
                    c.lineTo(right, top+rounding[1]);   // right side line.
                    c.quadraticCurveTo(right, top, right-rounding[1], top);
                    c.lineTo(left+rounding[0]+tailSize, top); // top line
                    c.quadraticCurveTo(left+tailSize, top, left+tailSize, top+rounding[0]);
                    c.lineTo(left+tailSize, bottom-6); // left side line
                    c.quadraticCurveTo(left+4,  bottom-1, left+1,  bottom-2); // top of tail.
                    c.quadraticCurveTo(left+2,  bottom+2, left+13, bottom-2); // bottom of tail
                    c.quadraticCurveTo(left+15, bottom,   left+19, bottom);   // bottom lead in to tail.
                    c.lineTo(right-rounding[2], bottom);
                    c.quadraticCurveTo(right, bottom, right, bottom-rounding[2]); // this is bottom left gets replaced.
                }
                else if (type == "arrowL" || type == "arrowR" || type == "arrowU" || type == "arrowD")
                {
                    var aCurve = 2.0; 
                    if(tmplVars.aCurve)
                    {
                        aCurve = tmplVars.aCurve;
                    }
                    
                    var aSize = 12; 
                    if(tmplVars.aSize)
                    {
                        aSize = tmplVars.aSize;
                    }
                    
                    if(type == "arrowL")
                    {
						c.moveTo(l+aSize, t);       //top left.
						c.lineTo(r-rounding[1], t); //top right
						c.quadraticCurveTo(r, t,  r, t+rounding[1]);
						c.lineTo(r, b-rounding[2]); // right line
						c.quadraticCurveTo(r, b, r-rounding[2], b);
						c.lineTo(l+aSize, b);       //bottom left.
						c.bezierCurveTo(l+aSize-aCurve, b, l, ((b+t)/2)+aCurve, l, (b+t)/2);
						//c.bezierCurveTo(l, ((b+t)/2)-aCurve, aSize-aCurve, t, l+aSize, t);
						c.bezierCurveTo(l, ((b+t)/2)-aCurve, aSize-aCurve+l, t, l+aSize, t);

//                        c.moveTo(l+aSize, t);       //top left.
//                        c.lineTo(r-rounding[1], t); //top right
//                        c.quadraticCurveTo(r, t,  r, t+rounding[1]);
//                        c.lineTo(r, b-rounding[2]); // right line
//                        c.quadraticCurveTo(r, b, r-rounding[2], b);
//                        c.lineTo(l+aSize, b);       //bottom left.
//                        c.bezierCurveTo(l+aSize-aCurve, b, l, ((b+t)/2)+aCurve, l, (b+t)/2);
//                        c.bezierCurveTo(l, ((b+t)/2)-aCurve, aSize-aCurve, t, l+aSize, t);
                    }
                    else if(type == "arrowR")
                    {
                        c.moveTo(l+rounding[0], t); //top left.
                        c.lineTo(r-aSize, t);       //top right
                        c.bezierCurveTo(r-aSize+aCurve,t,   r,((t+b)/2)-aCurve, r, (t+b)/2);
                        c.bezierCurveTo(r,((t+b)/2)+aCurve, r-aSize+aCurve,b,   r-aSize, b);
                        c.lineTo(l+rounding[3], b);
                        c.quadraticCurveTo(l, b, l, b-rounding[3]);
                        c.lineTo(l, t+rounding[0]);
                        c.quadraticCurveTo(l, t, l+rounding[0], t);
                    }
                    else if(type == "arrowD")
                    {
                        var aw = (tmplVars.aW) ? tmplVars.aW : aw;              
                        var center = (l+r)/2;
                        var aWidth = aw/2;
                        
                        c.moveTo(l+rounding[0], t); //top left.
                        c.lineTo(r-rounding[1], t); //top right
                        c.quadraticCurveTo(r, t, r, t+rounding[1]);
                        c.lineTo(r, b-aSize-rounding[2]);
                        c.quadraticCurveTo(r, b-aSize, r-rounding[2], b-aSize);
                        
                        c.lineTo(center+aWidth, b-aSize); // this is the bottom line 1
                        c.lineTo(center, b);  // arrow right
                        c.lineTo(center-aWidth, b-aSize);  // arrow left
                        c.lineTo(l+rounding[3], b-aSize); // this is the bottom line 2
                            
                        c.quadraticCurveTo(l, b-aSize, l, b-aSize-rounding[3]);
                        c.lineTo(l, t+rounding[0]);
                        c.quadraticCurveTo(l,t, l+rounding[0], t);
                    }   
                    else if(type == "arrowU")
                    {
                        var aw = (tmplVars.aW) ? tmplVars.aW : 20;              
                        var center = (l+r)/2;
                        var aWidth = aw/2;
                        
                        c.moveTo(l+rounding[0], t+aSize); //top left.
                        c.lineTo(center-aWidth, t+aSize); // top left line
                        c.lineTo(center, t);  // arrow right
                        c.lineTo(center+aWidth, t+aSize);  // arrow left
                        c.lineTo(r-rounding[1], t+aSize); //top right
                            
                        c.quadraticCurveTo(r, t+aSize, r, t+aSize+rounding[1]); // top right corner
                        c.lineTo(r, b-rounding[2]);
                        c.quadraticCurveTo(r, b, r-rounding[2], b);// bottom right corner
                        c.lineTo(l+rounding[2], b); // bottom line 
                        
                        c.quadraticCurveTo(l, b, l, b-rounding[3]); // bottom left 
                        c.lineTo(l, t+aSize+rounding[0]);
                        c.quadraticCurveTo(l,t+aSize, l+rounding[3], t+aSize); // top left
                    }
                }
				else if(type == "c")
				{
                    var x = width / 2,
                        y = height / 2,
                        shortestSide = Math.min(x, y),
                        stroke = Math.min(borderWidth|0, shortestSide),
                        radius = shortestSide - stroke / 2;

                    adjustedBorderWidth = stroke;

                    c.arc(left + x, top + y, radius, 0, Math.PI * 2, true);
				}
                c.closePath();
            },

            // draws a gradient on the current path.
            _gradient : function (g, c, wdgObj)
            {
                var colors = ["#ffffff","#000000"];
                var stops = [0.00, 1.00];
                if(wdgObj.bgc && wdgObj.bgd)
                {
                    colors = wdgObj.bgc;
                    stops = wdgObj.bgd;
                }

                for(var i = 0; i < colors.length && i < stops.length; i++)
                {
                    try
                    {
                        g.addColorStop(stops[i], colors[i]);
                    }
                    catch(e)
                    {
                        //console.log("unable to add color stop to .", stops[i], colors[i], wdgObj.bgc, wdgObj.bgd);
                    }
                }
                c.fillStyle = g;
                c.fill();
            },

            _glaze : function (c, wdgObj)
            {
                //console.log('glaze: ', wdgObj);
                var rounding = 5,
                    top = renderer.useOneCanvas ? 2.0 + wdgObj.box[1] : 2,
                    left = renderer.useOneCanvas ? 10 + wdgObj.box[0] : 10,
                    width=wdgObj.box[2]-27,
                    height=10,
                    borderWidth=0,
                    tailSize = 7; //TAILSIZE SAME AS ABOVE - ALSO EDIT. (or jsut fix properly)

                if(wdgObj.s == 'bubl') // TODO HACK: this just offsets by the
                {
                    left += tailSize;
                }

                draw.path(c, "sq", rounding, top, left, width, height, borderWidth, wdgObj);

                var g = c.createLinearGradient(0, top+height, 0, top);
                g.addColorStop(0.00, "rgba(231, 231, 231, 0.2)");
                g.addColorStop(0.59, "rgba(240, 240, 240, 0.25)");
                g.addColorStop(1.00, "rgba(249, 249, 249, 0.3)");
                c.fillStyle = g;
                c.fill();
                c.restore();
            },

			_shadow : function (c, wdgObj)
			{
				c.shadowColor = wdgObj.sh[0];
				c.shadowOffsetX = wdgObj.sh[1];
				c.shadowOffsetY = wdgObj.sh[2];
				c.shadowBlur = wdgObj.sh[3];
			},

			_effect : function (c, wdgObj)
			{
				var effects = wdgObj.fx;
				for(var i=0; i<effects.length; i++) {
					var singleEffect = effects[i];
					if(singleEffect[0] == 'dots') {
						var size = singleEffect[1];
						var hSpacing = singleEffect[2];
						var vSpacing = singleEffect[3];
						c.fillStyle = singleEffect[4];

						var widgWidth = wdgObj.box[2];
						var widgHeight = wdgObj.box[3];

						var tileWidth = size + hSpacing;
						var tileHeight = size + vSpacing;
						var horizontalTileNumber = parseInt(widgWidth / tileWidth) + 1;
						var verticalTileNumber = parseInt(widgHeight / tileHeight) + 1;
						var offset = 0;

						for(var j=0; j < verticalTileNumber; j++) {
							offset = (offset) ? 0 : size;
							for(var k=0; k < horizontalTileNumber; k++){
								c.beginPath();
								c.arc((k * tileWidth) + offset, (j * tileHeight), size/2, 0, 2*Math.PI);
								c.closePath();
								c.fill();
							}

						}
					}
				}
			},

            //_setImage : function(widgEl, c, wdgObj)
            _setImage : function(c, wdgObj)
            {
                try
                {
                    //if (wdgObj.useCanvas)
                    //{
//                        var wh = {width: wdgObj.absTLWH[2], height: wdgObj.absTLWH[3]};
//                        var destCanv = widgEl.find("canvas").attr(wh); // .attr(wh)
//                        var destCtx = destCanv[0].getContext('2d');
                    c.drawImage(c.canvas, 0, 0);
//                    }
//                    else
//                    {
//                        var $img = widgEl.find("img"); // image is 100%100%
//                        widget._convertCanvasToImg($(c.canvas), $img, wdgObj);
//                    }
                }
                catch(e) // this can fail if widget gets corrupted and wont allow previewing - quick live fix by dave replicated here.
                {
                    //console.log(e)
                }
            }
        };

        var left = this.renderingMode === 'singlepage' ? 0 : wdgObj.box[0];
        var top = this.renderingMode === 'singlepage' ? 0 : wdgObj.box[1];

        var width = wdgObj.box[2]; //? wdgObj.wh[0] : parentWdg.wh[0];
        var height = wdgObj.box[3]; //? wdgObj.wh[1] : parentWdg.wh[1];
        //console.log('!!!: ', left, top, width, height);

        var borderWidth = 0;
        var borderRadius = 0;
        var border = wdgObj.b;

        var adjustedBorderWidth = null;

        if(border)
        {
            borderWidth = border[0];
            borderRadius = border.length > 3 ? border.slice(2) : border[2];
        }

        var shape = wdgObj.s ? wdgObj.s : "sq";	// allow different shapes // in time this could be an array or a predefined

        c.save();

        // blur if it's got it
        draw.blur();

        //console.log('path: ', shape, borderRadius, top, left, width, height, borderWidth, wdgObj);
        draw.path(c, shape, borderRadius, top, left, width, height, borderWidth, wdgObj); // This is the path for the Background and border.

        if(wdgObj.sh) // to be extended massively (and made work).
        {
            draw._shadow(c, wdgObj);
        }

        if(wdgObj.bg)	// background
        {
            //console.log('bg: ', wdgObj);
            draw.background(c, wdgObj);
        }

        c.restore();

        if(border && borderWidth > 0)	// border can be 0 in situations where we just want the rounding.
        {
            draw.border(c, wdgObj, width, height);
        }
        //c.save();
        if(wdgObj.glaze && wdgObj.glaze == 'y')// this could be made more generic with an embedded widget!
        {
            draw._glaze(c, wdgObj);
        }

		if(wdgObj.fx && wdgObj.fx.length > 0)// this could be made more generic with an embedded widget!
		{
			draw._effect(c, wdgObj);
		}

        if(wdgObj.i) {
            for(var i = 0; i< wdgObj.i.length; i++) // for each image
            {
                var icon = wdgObj.i[i];
                var img = new Image();	// TODO: Cache this image.


                function imageLoaded() {
                    var positionX = icon[5];
                    if(typeof(positionX)=='string' && positionX.search("%") != -1) // its a % across.
                    {
                        positionX = (width * parseInt(positionX) / 100) - icon[3]/2; // - icon[3]/2; // midway point minus half the width of the widget.
                    }
                    else if(positionX < 0) // its negative - align from right;
                    {
                        positionX = parseInt(width) + icon[5] - icon[3]; // its negative.
                    }

                    var positionY = icon[6];
                    if(typeof(positionY)=='string' && positionY.search("%") != -1) // its a % across.
                    {
                        positionY = (height * parseInt(positionY) / 100) - icon[4]/2; // - icon[3]/2; // midway point minus half the width of the widget.
                    }
                    else if(positionY < 0) // its negative - align from right;
                    {
                        positionY = parseInt(height) + icon[6] - icon[4]; // its negative.
                    }

                    if(renderer.imagesLoaded[icon[0]]) {
                        c.drawImage(renderer.imagesLoaded[icon[0]],
                            icon[1], icon[2] ,
                            icon[3], icon[4],
                            positionX + left, positionY + top,
                            icon[3], icon[4]);
                    } else {
                        img.onload = function() {
                            try
                            {
                                //console.log('onload: ',  img, icon[1], icon[2], icon[3], icon[4], // source and destination width/height are the same
                                //        positionX + left, positionY + top, icon[3], icon[4]);
                                c.drawImage(img,
                                    icon[1], icon[2] ,
                                    icon[3], icon[4], // source and destination width/height are the same
                                    positionX + left, positionY + top,
                                    icon[3], icon[4]);
                                //draw._setImage(c, wdgObj);

                                if (c.canvas.hasOwnProperty('onchange')) // not nice, but works. addEventListener and dispatchEvent don't work for some reason.
                                {
                                    c.canvas.onchange();
                                }
                            }
                            catch(e)
                            {
                                //console.log("Image draw fail", c, img, icon, positionX + left, positionY+ top, e, wdgObj); // probably exported version.
                            }
                        }
                        img.src = icon[0];
                    }

                }
                //img.src = icon[0];
                $(img).ready(imageLoaded);
            }
        } else {
            //console.log('else: ', c, wdgObj);
            //draw._setImage(widgEl, c, wdgObj);
        }

        if(!this.useCanvas) {
            $canvas = this.canvasToImg($canvas);
        }

        return $canvas;
    };

    this.canvasToImg = function($canvas) {
        var base64data = $canvas.get(0).toDataURL('image/png');
        return $('<img src="'+base64data+'">');
    };

    this.renderOne = function(wdgObj, wdgParent, childConfig) {
        var wdgRendition = {
            $rendition: {},
            childWidgets: []
        };
        //console.log('rendering one: ', wdgObj, wdgParent);

        //don't calculate widget box if rendering widget segment
        if(!wdgObj.box) wdgObj.box = this.calculateBox(wdgObj, wdgParent, childConfig);
        //else debugger;

        if(fluid.widget.isShapeWidget(wdgObj)) {
            //console.log('wdg: ', wdgObj);
            wdgRendition.$shapeRendition = this.paintCanvas(wdgObj);
        }

        if(fluid.widget.isUploadWidget(wdgObj)) {
            //wdgRendition.$shapeRendition = this.renderUpload(wdgObj);
        }

        //console.log('box calculated: ', wdgObj, wdgParent );
        if(fluid.widget.isTextWidget(wdgObj)) {
            wdgRendition.$textRendition = this.renderText(wdgObj);
        }

        if( fluid.widget.hasChildWidgets(wdgObj) ) {
            var children = fluid.wdgProvider.getChildWidgets(wdgObj, true);
            for(var j=0; j<children.length; j++) {
                wdgRendition.childWidgets.push(this.renderOne(children[j], wdgObj, wdgObj.ad[j]));
            }
        }

        if( fluid.widget.hasSegments(wdgObj) ) {
            //console.log('wdg: ', wdgObj, ' has segments: ', widgets.summary[wdgObj.seg[0]]);
            //console.log('wdg: ', wdgObj, ' has segments: ', wdgObj.segments);
            //if(wdgObj.lockTo === 'w_iJmmqnpC3dobRTKl6sp6vM6qslxhAbcJ') console.log('!!!!SEGMENTS!!!!!', wdgObj);
            wdgRendition.segments = this.renderSegments(wdgObj);

        }

        if(!wdgRendition.childWidgets.length) {
            delete wdgRendition.childWidgets;
        }

        return wdgRendition;
    };

    this.renderSegments = function(wdgObj) {
        //console.log('rendering segments: ', wdgObj);
        //console.log('!!segments: ', wdgObj, widgets.summary[wdgObj.seg[0]]);
        //var segmentWidth = wdgObj.box ? wdgObj.box[2] : wdgObj.tlwh[2];
        var segments = [];
        var renditionArr = [];
        for(var i=0; i<wdgObj.sc; i++) {
            if( wdgObj.segments && wdgObj.segments.length ) {
                segments.push({
                    wdgObj: storage.get(wdgObj.segments[i].id),
                    box: []
                });
            } else {
                segments.push({
                    wdgObj: fluid.wdgProvider.getById(wdgObj.seg[i % wdgObj.seg.length]),
                    box: []
                });
            }

        }

        //console.log('segments: ', segments);
        //calculating width/height
        for(i=0; i<segments.length; i++) {
            //console.log('!!!segments: ', segments[i].wdgObj);
            //generic widgets only have wh property
            if(segments[i].wdgObj.wh) {
                segments[i].wdgObj.tlwh = [0,0,segments[i].wdgObj.wh[0], segments[i].wdgObj.wh[1]];
            }

            //if(segments[i].wdgObj.segment === 'w_LoV1CauweJxVt86qqlmLYj2hvpoWrqv2') debugger;

            //width
            if(segments[i].wdgObj.tlwh && typeof(segments[i].wdgObj.tlwh[2]) === 'number') {
                segments[i].box[2] = segments[i].wdgObj.tlwh[2];
            } else if(segments[i].wdgObj.tlwh) {
                if( segments[i].wdgObj.tlwh && segments[i].wdgObj.tlwh[2] === 'a') {
                    segments[i].box[2] = wdgObj.box[2]/wdgObj.sc;
                    //console.log('a found: ', segments[i].box[2] )
                } else if(segments[i].wdgObj.tlwh[2].indexOf('%') !== -1) {
                    segments[i].box[2] = (parseFloat(segments[i].wdgObj.tlwh[2])/100)*wdgObj.box[2];
                    //console.log('% found: ', segments[i].wdgObj.tlwh[2].indexOf('%'));
                }
                //segments[i].wdgObj.wh &&
                //console.log('% found: ', segments[i].wdgObj.tlwh[2].search('%') )

            }
            //height
            if(segments[i].wdgObj.tlwh && typeof(segments[i].wdgObj.tlwh[3]) === 'number') {
                segments[i].box[3] = segments[i].wdgObj.tlwh[3];
            } else if(segments[i].wdgObj.tlwh) {
                if( segments[i].wdgObj.tlwh && segments[i].wdgObj.tlwh[3] === 'a') {
                    segments[i].box[3] = wdgObj.box[3]/wdgObj.sc;
                    //console.log('a found: ', segments[i].box[3] )
                } else if(segments[i].wdgObj.tlwh[3].indexOf('%') !== -1) {
                    segments[i].box[3] = (parseFloat(segments[i].wdgObj.tlwh[3])/100) * wdgObj.box[3];
                    //console.log('% found: ', segments[i].wdgObj.tlwh[3].indexOf('%'));
                }
                //segments[i].wdgObj.wh &&
                //console.log('% found: ', segments[i].wdgObj.tlwh[2].search('%') )
            }
        }

        // top/left calculation

        //horizontal layout
        if(wdgObj.sl == 'h') {

            //horizontal layout, top-left align
            if(wdgObj.sa == 'tl' || !wdgObj.sa) {
                for(i=0; i<segments.length; i++) {
                    segments[i].box[0] = (i * ( wdgObj.box[2]/wdgObj.sc ));
                    segments[i].box[1] = 0 + wdgObj.sp[1];
                }
                //console.log('layout for: ', wdgObj);
                //horizontal layout, evenly distributed
            } else if(wdgObj.sa == 'd') {
                for(i=0; i<segments.length; i++) {
                    segments[i].box[0] = (i * ( wdgObj.box[2]/wdgObj.sc )) + Math.max(wdgObj.box[2]/wdgObj.sc - segments[i].box[2], 0)/2;
                    segments[i].box[1] = (wdgObj.box ? wdgObj.box[1] : 0) + wdgObj.sp[1];
                }
                //console.log('layout for: ', wdgObj);
            }

            //vertical layout
        } else {
            for(i=0; i<segments.length; i++) {
                segments[i].box[0] = wdgObj.box ? wdgObj.box[0] : 0;
                segments[i].box[1] = (wdgObj.box ? wdgObj.box[1] : 0)+(i * segments[i].box[3]);
            }
        }

        for(i=0; i<segments.length; i++) {
            if(i===0 && segments[i].wdgObj.bts ) segments[i].wdgObj.b = segments[i].wdgObj.bts;
            else if(i===segments.length -1 && segments[i].wdgObj.bbs ) segments[i].wdgObj.b = segments[i].wdgObj.bbs;
            else if(segments[i].wdgObj.bms && wdgObj.sl === 'v') segments[i].wdgObj.b = segments[i].wdgObj.bms;

            if(i===0 && segments[i].wdgObj.bls ) segments[i].wdgObj.b = segments[i].wdgObj.bls;
            else if(i===segments.length-1 && segments[i].wdgObj.brs ) segments[i].wdgObj.b = segments[i].wdgObj.brs;
            else if(segments[i].wdgObj.bms && wdgObj.sl === 'h') segments[i].wdgObj.b = segments[i].wdgObj.bms;

            segments[i].wdgObj.box = segments[i].box;
            //console.log('!!!!!!!!', segments[i].wdgObj);
            renditionArr.push( this.renderOne(segments[i].wdgObj) );
        }

        //console.log('segments: ', wdgObj, segments);
        //console.log('!rendition: ', renditionArr);
        return renditionArr;

    };

    this.renderRecursive = function(wdgObj, wdgParent) {
        var wdgRendition = {};


        if(wdgObj.length) {
            var renditionArr = [];
            for(var i=0; i<wdgObj.length; i++) {
                this.generateCanvas(wdgObj[i].originId);
                //console.log('renderRecursive: ', wdgObj[i].originId);
                wdgRendition = this.renderOne(wdgObj[i], wdgParent);
                renditionArr.push(wdgRendition);

            }
        } else {
            this.generateCanvas(wdgObj.originId);
            //console.log('renderRecursive: ', wdgObj.originId);
            wdgRendition = this.renderOne(wdgObj, wdgParent);
        }

        return renditionArr || wdgRendition;
    };

    this.onPageRenderFinish = function(pageId) {
        //console.log('!!!RENDERER!!!!page rendered: ', pageId, this.canvases[pageId]);
        if(this.afterPageRendered) {
//            var imgData = this.canvases[pageId].get(0).toDataURL('image/jpeg', 0.5);
            var imgData = this.canvases[pageId].get(0).toDataURL('image/png');
            this.afterPageRendered(pageId, imgData, 1, false);
        }
    };

    this.onRenderFinish = function() {
        //console.log('finished rendering...', this.afterPageRendered);
        if (typeof window.callPhantom === 'function') {
            $('#canvas').css({top: (-this.cropping.y+15)+'px', left: (-this.cropping.x+15)+'px' });
            window.callPhantom({ event: 'finishedrendering', cropping: this.cropping });
        } else if(!this.afterPageRendered) {
            var arrData = [];
			var projectId = project.get('id');
            $('canvas.page-preview').each(function(){
                var pageId = $(this).parents('.screen').attr('id');
                var data = $(this).get(0).toDataURL('image/jpeg', 0.5);
                //var data = $(this).get(0).toDataURL('image/png');

                if(project.useLocalDb) {
                    arrData.push({id: pageId, data: data, project: projectId});
                }

                requestAnimationFrame(function(){
                    var image = $('<img class="page-preview" src="'+data+'">');
                    image.insertAfter($(this));
                    setTimeout(function() {
                        $(this).remove();
                    }.bind(this), 500);
                }.bind(this));

            });

            if(project.useLocalDb) {
                dbStorage.set('rastPages', arrData);
            }

            //console.log('whole rendering finished: ', new Date().getTime() - project.startTime);

        }

    };

    this.countRemainingLoads = function(pageId) {
        var remaining = 0;

        if(pageId) {
            for(var prop in this.imagesToLoad[pageId]){
                remaining++;
            }
            for(var prop in this.uploadsToLoad[pageId]){
                remaining++;
            }

            return remaining;
        } else {

            for(var pageId in this.imagesToLoad){
                if( this.imagesToLoad.hasOwnProperty(pageId) ) {
                    for(var imgId in this.imagesToLoad[pageId]) {
                        if( this.imagesToLoad[pageId]. hasOwnProperty(imgId) ) {
                            remaining++;
                        }
                    }
                }
            }

            for(var pageId in this.uploadsToLoad){
                if( this.uploadsToLoad.hasOwnProperty(pageId) ) {
                    for(var imgId in this.uploadsToLoad[pageId]) {
                        if( this.uploadsToLoad[pageId]. hasOwnProperty(imgId) ) {
                            remaining++;
                        }
                    }
                }
            }

            return remaining;
        }


    };

    this.onImgLoadErr = function(pageId, src, evt) {
        //console.log('image failed to load: ', this, arguments, evt.target);
        if( evt.target.src.indexOf('data/img') !== -1 ) {

			//removing the widget (upload image) that failed to load and that is not within account uploads
			if( account.hasUpload(src) === false && account.syncedUploads) {
				page.removeWidget(pageId, this.uploadsToLoad[pageId][src]);
				storage.remove(this.uploadsToLoad[pageId][src]);
			}

            if( this.imagesToLoad[pageId][src] ) {
                delete this.imagesToLoad[pageId][src];

            }
            if( this.uploadsToLoad[pageId][src] ) {
                delete this.uploadsToLoad[pageId][src];
            }

            var remaining = this.countRemainingLoads(pageId);

            if( remaining === 0 ) {
                //console.log('rendering queue...', this.renderingQueue[pageId]);
                for(var i=0; i<this.renderingQueue[pageId].length; i++) {
                    var wdgObj = this.renderingQueue[pageId][i];

                    if(fluid.widget.isShapeWidget(wdgObj)) {
                        this.paintCanvas(wdgObj, this.canvases[pageId]);
                    }

                    if(fluid.widget.isUploadWidget(wdgObj)) {
                        this.renderUpload(wdgObj, this.canvases[pageId], this.imagesLoaded[wdgObj.data]);
                    }

                    if(fluid.widget.isTextWidget(wdgObj)) {
                        this.renderText(wdgObj, this.canvases[pageId]);
                    }
                }

                if( this.countRemainingLoads() === 0 ) this.onRenderFinish();

            }

            return;
        }
		var newImg = new Image();
		newImg.onload = this.onImgLoad.bind(this, pageId, src);
		newImg.onerror = this.onImgLoadErr.bind(this, pageId, src);
		newImg.src = 'data/img/'+src;
    };

    this.onImgLoad = function(pageId, src, evt) {
        //console.log('image loaded: ', this, arguments);
        //console.log('image loaded: ', evt.target.src);
        //console.log('image loaded: ', this, pageId, src, evt);
        this.imagesLoaded[src] = evt.target;
        //console.log('image loaded: ', src, this.imagesLoaded[src]);
        if( this.imagesToLoad[pageId][src] ) {
            delete this.imagesToLoad[pageId][src];

        }
        if( this.uploadsToLoad[pageId][src] ) {
            delete this.uploadsToLoad[pageId][src];
        }

        var remaining = this.countRemainingLoads(pageId);
        if( remaining === 0 ) {
            //console.log('rendering queue...', this.renderingQueue[pageId]);
            for(var i=0; i<this.renderingQueue[pageId].length; i++) {
                var wdgObj = this.renderingQueue[pageId][i];

                if(fluid.widget.isShapeWidget(wdgObj)) {
                    this.paintCanvas(wdgObj, this.canvases[pageId]);
                }

                if(fluid.widget.isUploadWidget(wdgObj)) {
                    this.renderUpload(wdgObj, this.canvases[pageId], this.imagesLoaded[wdgObj.data]);
                }

                if(fluid.widget.isTextWidget(wdgObj)) {
                    this.renderText(wdgObj, this.canvases[pageId]);
                }
            }

            this.onPageRenderFinish(pageId);
            if( this.countRemainingLoads() === 0 ) this.onRenderFinish();

        }

		//if the upload is not in the uploadCache need to encode it and save it to localDB
		if( src.indexOf('i_') === 0 && window.uploadsCache && !window.uploadsCache[src] ) {
			//console.log('loaded the image: ', this);
			if(!project.uploadCanvas) project.uploadCanvas = document.createElement('canvas');
			project.uploadCanvas.width = this.naturalWidth;
			project.uploadCanvas.height = this.naturalHeight;
			project.uploadCanvasCtx = project.uploadCanvas.getContext('2d');
			project.uploadCanvasCtx.drawImage(evt.target, 0, 0);
			window.uploadsCache[src] = project.uploadCanvas.toDataURL('image/png');
			dbStorage.set('uploads', {id: src, data: window.uploadsCache[src]}/*, function() {
				console.log('upload saved...');
			}*/);
		}

    };

    this.pageRenderOne = function(wdgObj) {
        var wdgRendition = {
            $rendition: {}
        };

        if( !this.skipImages ) {
            if(!this.imagesToLoad[this.pageId]) this.imagesToLoad[this.pageId] = {};
            if(!this.uploadsToLoad[this.pageId]) this.uploadsToLoad[this.pageId] = {};

            var needImgPreload = false;
            if( wdgObj.i && !this.imagesToLoad[this.pageId][wdgObj.i[0][0]] ) {
                needImgPreload = true;
            }

            //if(wdgObj.upload) console.log('upload: ', wdgObj);
            if( wdgObj.upload === 'y' && !this.uploadsToLoad[this.pageId][wdgObj.data] ) {
                needImgPreload = true;
            }

            //if(wdgObj.upload === 'y' || wdgObj.i || this.renderingQueue[this.pageId].length > 0 ) {
            if( needImgPreload || this.renderingQueue[this.pageId].length > 0 ) {
                //console.log('queueing: ', wdgObj, this.pageId);
                if( wdgObj.i && !this.imagesToLoad[this.pageId][wdgObj.i[0][0]] ) {
                    var img = new Image();
                    //this.imagesToLoad[this.pageId][wdgObj.i[0][0]] = true;
                    this.imagesToLoad[this.pageId][wdgObj.i[0][0]] = true;
                    img.onload = this.onImgLoad.bind(this, this.pageId, wdgObj.i[0][0]);
                    img.crossOrigin = 'Anonymous';
                    img.src = wdgObj.i[0][0];
                } else if( wdgObj.upload === 'y' && !this.uploadsToLoad[this.pageId][wdgObj.data]) {
//                    if(project.uploadPreload) {
//                        this.renderUpload(wdgObj, this.canvases[this.pageId], uploadsCache[wdgObj.data]);
						//if(!uploadsCache[wdgObj.data]) uploadsCache[wdgObj.data] = new Image();
						//console.log('!!!!!!!!!!!! ', uploadsCache[wdgObj.data]);
						//this.onImgLoad.call(this, this.pageId, wdgObj.data, {target: uploadsCache[wdgObj.data]});
//                    } else {
						var uploadObj = storage.get(wdgObj.data);
                        var img = new Image();
                        this.uploadsToLoad[this.pageId][wdgObj.data] = wdgObj.id;
                        img.onload = this.onImgLoad.bind(this, this.pageId, wdgObj.data);
                        img.onerror = this.onImgLoadErr.bind(this, this.pageId, wdgObj.data);
                        //console.log('fetching from: ', 'data/img/'+wdgObj.data);
                        //img.src = 'data/img/'+wdgObj.data;
						if(window.uploadsCache && window.uploadsCache[wdgObj.data]) {
							//console.log('upload from cache...');
							img.src = uploadsCache[wdgObj.data];
						} else if(!uploadObj || !uploadObj.storage || uploadObj.storage === 'cloud') {
							img.crossOrigin = 'Anonymous';
							img.src = imgCloudUrl+wdgObj.data+'.png';
						} else {
							img.src = 'data/img/'+wdgObj.data;
						}

                        //console.log('fetching from: ', imgCloudUrl+wdgObj.data+'.png');
//                    }

                }

				this.renderingQueue[this.pageId].push(wdgObj);
                wdgRendition.$shapeRendition = this.canvas;
                return wdgRendition;
            }
        }


        if(fluid.widget.isShapeWidget(wdgObj) || wdgObj.segments) {
            //console.log('wdg: ', wdgObj);
            wdgRendition.$shapeRendition = this.paintCanvas(wdgObj);
        }

        if( !this.skipImages && fluid.widget.isUploadWidget(wdgObj) ) {
            wdgRendition.$shapeRendition = this.renderUpload(wdgObj);
        }

        if(fluid.widget.isTextWidget(wdgObj)) {
            wdgRendition.$textRendition = this.renderText(wdgObj);
        }

        return wdgRendition;
    };

    this.foo = function(wdgObj, container) {
        var box = [];
        //debugger;

        //width
        var width = wdgObj.tlwh[2] == null ? 0 : wdgObj.tlwh[2];
        if(width && typeof(width)==='number') {
            box[2] = width;
        } else if(width && width.indexOf('%') !== -1) {
            box[2] = ( parseFloat(width)/100 ) * container.box[2];
        } else {
            box[2] = container.box[2];
        }

        //height
        var height = wdgObj.tlwh[3] == null ? 0 : wdgObj.tlwh[3];
        if(height && typeof(height)==='number') {
            box[3] = height;
        } else if(height && height.indexOf('%') !== -1) {
            box[3] = ( parseFloat(height)/100 ) * container.box[3];
        } else {
            box[3] = container.box[3];
        }



        //top
        var top = wdgObj.tlwh[0] == null ? 0 : wdgObj.tlwh[0];
        if(!wdgObj.ca || wdgObj.ca[0] == 't') {
            if(typeof(top)==='number') {
                box[1] = top + container.box[1];
            } else if(top.indexOf('%') !== -1) {
                box[1] = ( ( parseFloat(top)/100 ) * container.box[3] ) + container.box[1];
            } else {
                box[1] = parseInt(top,10) + container.box[1];
            }
        } else if(wdgObj.ca[0] == 'c') {
            if(typeof(top)==='number') {
                box[1] = top + container.box[1] + container.box[3]/2 - box[3]/2;
            } else if(top.indexOf('%') !== -1) {
                box[1] = ( ( parseFloat(top)/100 ) * container.box[3] ) + container.box[1] + container.box[3]/2 - box[3]/2;
            } else {
                box[1] = parseInt(top,10) + container.box[1] + container.box[3]/2 - box[3]/2;
            }
        } else if(wdgObj.ca[0] == 'b') {
            if(typeof(top)==='number') {
                box[1] = container.box[1] + container.box[3] - top - box[3];
            } else if(top.indexOf('%') !== -1) {
                box[1] = container.box[1] + container.box[3] - ( ( parseFloat(top)/100 ) * container.box[3] ) - box[3];
            } else {
                box[1] = container.box[1] + container.box[3] - parseInt(top,10);
            }
        }

        //left
        var left = wdgObj.tlwh[1] == null ? 0 : wdgObj.tlwh[1];
        if(!wdgObj.ca || wdgObj.ca[1] == 'l') {
            if(typeof(left)==='number' || left.indexOf('%') === -1)
                box[0] = left + container.box[0];
            else if(left.indexOf('%') !== -1)
                box[0] = ( ( parseFloat(left)/100 ) * container.box[2] ) + container.box[0];
            else box[0] = parseInt(left,10) + container.box[0];
        } else if(wdgObj.ca[1] == 'c') {
            if(typeof(left)==='number')
                box[0] = left + container.box[0] + container.box[2]/2 - box[2]/2;
            else if(left.indexOf('%') !== -1)
                box[0] = ( ( parseFloat(left)/100 ) * container.box[2] ) + container.box[0] + container.box[2]/2 - box[2]/2;
            else box[0] = parseInt(left,10) + container.box[0] + container.box[2]/2;
        } else if(wdgObj.ca[1] == 'r') {
            if(typeof(left)==='number')
                box[0] = container.box[0] + container.box[2] - left - box[2];
            else if(left.indexOf('%') !== -1)
                box[0] = container.box[0] + container.box[2] - ( ( parseFloat(left)/100 ) * container.box[2] ) - box[2];
            else box[0] = container.box[0] + container.box[0] - parseInt(left,10);
        }

		box[0] = ~~box[0];
		box[1] = ~~box[1];
		box[2] = ~~box[2];
		box[3] = ~~box[3];

        //console.log('positions foo: ', container.box, wdgObj.tlwh, wdgObj.ca, box);
        return box;
    };

    this.calculatePageBox = function(pageObj, id) {
        var box;
        var containerBox;
        var containerId = ( pageObj.widgets[id] && pageObj.widgets[id].of ) ? pageObj.widgets[id].of : null;

        //console.log('wdgObj: ', pageObj, pageObj.widgets[id] );
        if(!pageObj.widgets[id] || !pageObj.widgets[id].tlwh) {
            return [0, 0, this.canvasSize[0], this.canvasSize[1]];
        }
        //if(id === 'w_QDmjLhljltIEw5p1uhp6YORgHahuocW4') debugger;
        //if root widget
        if(!containerId) {
            //console.log('calculating for: ', id, pageObj.widgets[id], {box: [0, 0, this.canvasSize[0], this.canvasSize[1]]});
            containerBox = {box: [0, 0, this.canvasSize[0], this.canvasSize[1]]};
            box = this.foo(pageObj.widgets[id], containerBox);

            //if container's box was calculated already
        } else if(pageObj.widgets[containerId] && pageObj.widgets[containerId].box) {
            box = this.foo(pageObj.widgets[id], pageObj.widgets[containerId]);
            //if container's box was not calculated, recurential call needed
        } else {
            box = this.calculatePageBox(pageObj, containerId);
        }

        //box[0] = box[0]
        //console.log('got box: ', pageObj.widgets[id], box);

        return box;
    };

    this.exceedsPage = function(wdgObj, pageObj) {
        if (wdgObj.box == undefined) return false;
        if(wdgObj.box[0] < 0 || wdgObj.box[1] < 0) return true;
        if(wdgObj.box[0] + wdgObj.box[2] > pageObj.width ) return true;
        if(wdgObj.box[1] + wdgObj.box[3] > pageObj.height ) return true;
        return false;
    };

    //this.renderPage = function(wdgList) {
    this.renderPage = function(pageObj) {
        if(this.finishTimeout) {
            clearTimeout(this.finishTimeout);
            delete this.finishTimeout;
        }

        var wdgRendition = {};
        var renditionArr = [];
        var exceedingArr = [];

        for(var prop in pageObj.widgets) {
            //if( !pageObj.widgets[prop].segment) {
                //console.log('calculating box: ', pageObj.widgets[prop], prop);
                pageObj.widgets[prop].id = prop;
                pageObj.widgets[prop].box = this.calculatePageBox(pageObj, prop);

				//console.log('exceed cond: ', this.useOneCanvas, !pageObj.widgets[prop].tc, this.exceedsPage(pageObj.widgets[prop], pageObj));
                if(this.useOneCanvas /*&& !pageObj.widgets[prop].tc*/ && this.exceedsPage(pageObj.widgets[prop], pageObj) ) {
                    exceedingArr.push(prop);
                }
                //if(prop === 'w_nUPK7UFz6ANmmibzKPE7ws49AtI97Mac') console.log('aaaa: ', pageObj.widgets[prop].box, this.exceedsPage(pageObj.widgets[prop], pageObj));
            //}
        }

        //removing the widgets that exceed page box from standard rendition process
        //render them separately
        if(this.useOneCanvas && widget._draw) {
            /*for(var i=0; i<exceedingArr.length; i++) {
                delete pageObj.widgets[exceedingArr[i]];
            }*/
            widget.load(pageObj.id, exceedingArr);
        }

        //console.log('pageWidgets: ', pageObj.widgets);
        //console.log('page: ', pageObj.x);
        this.setCropping(pageObj);
//        console.log('pageObj: ', pageObj);

        this.generateCanvas(pageObj.id);
        this.pageId = pageObj.id;
        this.renderingQueue[pageObj.id] = [];

        //console.log('rendering wdg: ', pageObj.widgets);

        var drawnBg = false;
        //render backgrounds first
        for(var prop in pageObj.widgets) {
            if( pageObj.widgets[prop].st && pageObj.widgets[prop].st === 'b' ) {
                wdgRendition = this.pageRenderOne(pageObj.widgets[prop]);
                wdgRendition.id = prop;
                wdgRendition.lockTo = pageObj.widgets[prop].lockTo;
                wdgRendition.box = pageObj.widgets[prop].box;
                renditionArr.push(wdgRendition);
                drawnBg = true;
            }
        }
        //render dummy white background if none added
        if(!drawnBg) {
            wdgRendition = this.pageRenderOne({
                st: 'b',
                ca: 'tl',
                bg: 'c',
                bgc: ['#ffffff'],
                box: [0, 0, this.canvasSize[0], this.canvasSize[1]],
                wg: [1],
                id: 'dummy-bg-'+(new Date().getTime())
            });
            renditionArr.push(wdgRendition);
        }

        for(var prop in pageObj.widgets) {
            //if(prop === 'w_DmFfi6SdXH2ynyPN8ff67veFGTGtm121') console.log('!!!!!!!', pageObj.widgets[prop]);
            //if(prop === 'w_nUPK7UFz6ANmmibzKPE7ws49AtI97Mac') console.log('!!!!!!!', pageObj.widgets[prop]);
            //console.log('rendering: ', prop, pageObj.widgets[prop]);
            //dont render backgrounds for a second time
            if( !pageObj.widgets[prop].st || pageObj.widgets[prop].st !== 'b' ) {
                    //console.log('rendering: ', prop, pageObj.widgets[prop], pageObj.widgets[prop].segment, !pageObj.widgets[prop].segment);
                    wdgRendition = this.pageRenderOne(pageObj.widgets[prop]);
                    wdgRendition.id = prop;
                    wdgRendition.lockTo = pageObj.widgets[prop].lockTo;
                    wdgRendition.box = pageObj.widgets[prop].box;

                    renditionArr.push(wdgRendition);
            }
		}
		/*if(project.uploadPreload) {
			for(var i=0; i<this.renderingQueue[pageObj.id].length; i++) {
				var wdgObj = this.renderingQueue[pageObj.id][i];

				if(fluid.widget.isShapeWidget(wdgObj)) {
					this.paintCanvas(wdgObj, this.canvases[pageObj.id]);
				}

				if(fluid.widget.isUploadWidget(wdgObj)) {
					this.renderUpload(wdgObj, this.canvases[pageObj.id], this.imagesLoaded[wdgObj.data]);
				}

				if(fluid.widget.isTextWidget(wdgObj)) {
					this.renderText(wdgObj, this.canvases[pageObj.id]);
				}
			}

		}*/

        if( this.countRemainingLoads(pageObj.id) === 0 ) {
            this.onPageRenderFinish(pageObj.id);
        }

        if( this.countRemainingLoads() === 0 ) {
            this.finishTimeout = setTimeout( this.onRenderFinish.bind(this) , 200);
        }


        return renditionArr;
    };

    // Takes a page Id
    // returns an object similar to storage.get(pageId) but with widgets = { w_0: {box: [], ...}, ...}
    this.preparePage = function (pageId) {
        // copy the storage object
        var pageObj = $.extend({ id: pageId }, storage.tempStorage[pageId]);

        // get the widget objects
        pageObj.widgets = pageObj.widgets.reduce(function (all, w) {
            all[w] = $.extend({}, storage.get(w));

            all[w].id = w;

            return all;
        }, {});

        // calculate the widget boxes
        for (var w in pageObj.widgets) {
            pageObj.widgets[w].box = this.calculatePageBox(pageObj, w);
        }

        return pageObj;
    }

    this.renderWidgetsBelow = function (widgetId, pageObj, hackImages) {
        pageObj = pageObj || this.preparePage(this.pageId);

        var i = 0,
            widgetList = storage.get(pageObj.id).widgets,
            len = widgetList.length,
            context = this.ctx;

        for (; i < len; i++) {
            if (widgetList[i] === widgetId) {
                break;
            }

            var w = pageObj.widgets[widgetList[i]];

            if (!w.dm) {
                if ((fluid.widget.isUploadWidget(w) || w.i) && hackImages) {
                    var widgetElement = document.getElementById(widgetList[i]),
                        imgElement = widgetElement? (widgetElement.querySelector('img') || widgetElement.querySelector('canvas')): null;

                    if (imgElement) {
                        context.drawImage(imgElement, w.box[0], w.box[1], w.box[2], w.box[3]);
                    }
                }
                else {
                    this.pageRenderOne(w);
                }
            }
        }

		if( this.countRemainingLoads(pageObj.id) === 0 ) {
			this.onPageRenderFinish(pageObj.id);
		}

		if( this.countRemainingLoads() === 0 ) {
			this.finishTimeout = setTimeout( this.onRenderFinish.bind(this) , 200);
		}
    }

	this.onProjectUnloaded = function(id) {
		if(!this.canceledPreview) this.canceledPreview = [];
		this.canceledPreview.push(id);
	};

    this.renderProjectPreview = function(projBundle, callback) {
        projBundle = $.extend({}, projBundle);

		//already generating the requested project
		if(this.currentProjectId && projBundle[this.currentProjectId]) {
			return;
		}

        this.previewSize = {
//            width: 800,
//            height: 400
            width: 205,
            height: 160
        };

        //using two canvases at a time - one for single page rendition (png/data generator), the second one is the real preview
        var $tmpCanvas = $('<canvas></canvas>');
        var tmpCtx = $tmpCanvas.get(0).getContext('2d');
        this.canvas = $tmpCanvas;
        var $canvas = $('<canvas class="project-preview" width="'+this.previewSize.width+'" height="'+this.previewSize.height+'"></canvas>').css({position: 'relative'});
        var ctx = $canvas.get(0).getContext('2d');

        var projectObj;
        var projectId;
        var pagesObj = {};
        var widgetsObj = {};
        //console.log('projBundle: ', projBundle);

        for(var prop in projBundle) {
            if(projBundle.hasOwnProperty(prop)) {
                if(prop.indexOf('w_') === 0 || (prop.indexOf('w') === 0 && prop.length == 33)) {
                    widgetsObj[prop] = $.extend({},projBundle[prop]);
                } else if(prop.indexOf('x_') === 0 || (prop.indexOf('x') === 0 && prop.length == 33) ) {
                    pagesObj[prop] = $.extend({},projBundle[prop]);
                } else if(prop.indexOf('p_') === 0 || (prop.indexOf('p') === 0 && prop.length == 33) ) {
                    projectObj = $.extend({},projBundle[prop]);
                    projectId = prop;
                }
            }
        }

        this.lastProjectId = projectId;

		this.currentProjectId = projectId;
		//console.log('!preview: ', projectId);


		var pages = projectObj.pages;

        if(!pages) {
            callback.call(this, projectId, $canvas);
			this.currentProjectId = null;
            return;
        }
        //console.log('project: ', projectObj, 'bundle: ', projBundle);
        var pageObj;
        var cropping = {
            x: projectObj.canvasWidth,
            y: projectObj.canvasHeight,
            x2: 0,
            y2: 0
        };

        //find a rectangle bounding all pages
        for(var i=0; i<pages.length; i++) {
            pageObj = pagesObj[pages[i]];
            if(!pageObj) continue;
            if(pageObj.x < cropping.x) cropping.x = pageObj.x;
            if(pageObj.y < cropping.y) cropping.y = pageObj.y;
            if(pageObj.x + pageObj.width > cropping.x2) cropping.x2 = pageObj.x + pageObj.width;
            if(pageObj.y + pageObj.height > cropping.y2) cropping.y2 = pageObj.y + pageObj.height;
        }
        //keeping same aspect ratio as a project canvas
        var expandedSide;
        var cropHeight = cropping.y2 - cropping.y;
        var cropWidth = cropping.x2 - cropping.x;
        //debugger;
        if(cropWidth < cropHeight) {
            expandedSide = cropHeight * projectObj.canvasWidth/projectObj.canvasHeight;
            cropping.x = cropping.x - (expandedSide - cropWidth) / 2;
            cropping.x2 = cropping.x2 + (expandedSide - cropWidth) / 2;
        } else {
            expandedSide = (cropWidth * projectObj.canvasHeight ) / projectObj.canvasWidth ;
            cropping.y = cropping.y - (expandedSide - cropHeight) / 2;
            cropping.y2 = cropping.y2 + (expandedSide - cropHeight) / 2;
        }

        var scale = {
            x: this.previewSize.width / (cropping.x2 - cropping.x),
            y: this.previewSize.height / (cropping.y2 - cropping.y)
        };
        //console.log('size: ', scale, storage.get(proj) );

        this.skipImages = true;

        //calculate and store coordinates of pages and widgets
        var extPages = [];
        for(var i=0; i<pages.length; i++) {
            if (!pagesObj[pages[i]]) {
                continue;
            }

            var pageObj = $.extend( {}, pagesObj[pages[i]] );
            extPages.push(pageObj);
            if(pageObj.widgets && pageObj.widgets.length > 0) {
                var pageWidgets = {};
                for(var j=0; j< pageObj.widgets.length; j++) {
                    pageWidgets[pageObj.widgets[j]] = widgetsObj[pageObj.widgets[j]];
                }
            }
            pageObj.widgets = pageObj.widgets.length > 0 ? pageWidgets : [];
            pageObj.id = pages[i];

            this.canvasSize = [pageObj.width || 320, pageObj.height || 480];

            if(!this.widgetsCache) this.widgetsCache = {};
            if(!this.pagesCache) this.pagesCache = {};
            for(var prop in pageObj.widgets) {
                if(pageObj.widgets.hasOwnProperty(prop) && pageObj.widgets[prop]) {
                    pageObj.widgets[prop].id = prop;
                    pageObj.widgets[prop].box = this.calculatePageBox(pageObj, prop);
                    this.widgetsCache[prop] = pageObj.id;
                }
            }
            this.pagesCache[pageObj.id] = pageObj;

            //console.log('pageObj: ', pageObj.id, pageObj);
        }

        //links draw
        var links = $.extend({}, projectObj.links); //project.get("links");

        var originId;
        var originCoords;
        var destCoords;
        for(var i=0; i<links.linkDest.length; i++) {
            if(!this.pagesCache[links.linkDest[i]]) continue;
            originId = this.widgetsCache[links.linkOrigin[i]];
            if( originId === undefined ) continue;
            //console.log('pagesCache: ', this.widgetsCache, originId, links.linkOrigin[i]);
            originCoords = {
                x: this.pagesCache[originId].x + this.pagesCache[originId].width * 0.5,
                y: this.pagesCache[originId].y + this.pagesCache[originId].height * 0.5
            };
            originCoords.x = (originCoords.x - cropping.x) * scale.x;
            originCoords.y = (originCoords.y - cropping.y) * scale.y;

            destCoords = {
                x: this.pagesCache[links.linkDest[i]].x + this.pagesCache[links.linkDest[i]].width * 0.5,
                y: this.pagesCache[links.linkDest[i]].y + this.pagesCache[links.linkDest[i]].height * 0.5
            };
            destCoords.x = (destCoords.x - cropping.x) * scale.x;
            destCoords.y = (destCoords.y - cropping.y) * scale.y;

            ctx.beginPath();
            ctx.strokeStyle = '#009ecc';
            ctx.moveTo(originCoords.x, originCoords.y);
            ctx.lineTo(destCoords.x, destCoords.y);
            ctx.stroke();
        }

        function finishPreview(i) {
            pageObj = extPages[i];
            $tmpCanvas.attr({
                width: pageObj.width,
                height: pageObj.height
            });
            //tmpCtx.clearRect(0, 0, pageObj.width, pageObj.height);
			tmpCtx.fillStyle = '#ffffff';
			tmpCtx.fillRect(0, 0, pageObj.width, pageObj.height);

            //console.log('page: ', pageObj);

            this.canvasSize = [pageObj.width || 320, pageObj.height || 480];

            for(var prop in pageObj.widgets) {
                if(pageObj.widgets.hasOwnProperty(prop) && pageObj.widgets[prop]) {
                    pageObj.widgets[prop].id = prop;
                    pageObj.widgets[prop].box = this.calculatePageBox(pageObj, prop);
                }
            }

            ctx.fillStyle = '#ffffff';
            ctx.fillRect((pageObj.x - cropping.x) * scale.x, (pageObj.y - cropping.y) * scale.y, pageObj.width * scale.x, pageObj.height * scale.y);

			if(!pagesCache[extPages[i].id] || !pagesCache[extPages[i].id].img) {
				//background first
				for(var prop in pageObj.widgets) {
					if(pageObj.widgets.hasOwnProperty(prop) && pageObj.widgets[prop] ) {
						if( pageObj.widgets[prop].st && pageObj.widgets[prop].st === 'b' ) {
							//console.log('rendering bg: ', pageObj.widgets[prop]);
							this.pageRenderOne(pageObj.widgets[prop]);
						}
					}
				}

				for(var prop in pageObj.widgets) {
					if(pageObj.widgets.hasOwnProperty(prop) && pageObj.widgets[prop] ) {
						if( !pageObj.widgets[prop].st || pageObj.widgets[prop].st !== 'b' ) {
							this.pageRenderOne(pageObj.widgets[prop]);
						}
					}
				}
			}


            var img = new Image();
			if(!pagesCache[extPages[i].id] || !pagesCache[extPages[i].id].img) {
				//console.log('page rendered from scratch... ', !pagesCache[extPages[i].id], !pagesCache[extPages[i].id].img);
				img.src = $tmpCanvas.get(0).toDataURL('image/jpeg');
			} else {
				img.src = pagesCache[extPages[i].id].img;
				//console.log('page rendered from cache...', !pagesCache[extPages[i].id], !pagesCache[extPages[i].id].img);
			}

            img.onload = (function(img, x, y, width, height, pageId) {
                ctx.drawImage(img, x, y, width, height );

				//check if the project hasn't been unloaded already - if so, stop the whole rendition
				if(this.canceledPreview && this.canceledPreview.indexOf(projectId) !== -1) {
					var idx = this.canceledPreview.indexOf(projectId);
					this.canceledPreview[idx] = null;
				//looping for next page with a timeout to mimic a background operation
				} else if(i<extPages.length-1) {
                    setTimeout(finishPreview.bind(this, i+1), 100);
				//finished generating preview - call callback function
                } else {
                    callback.call(this, projectId, $canvas);
					this.currentProjectId = null;
                }

            }).bind(
                this,
                img,
                (pageObj.x - cropping.x) * scale.x,
                (pageObj.y - cropping.y) * scale.y,
                pageObj.width * scale.x,
                pageObj.height * scale.y,
                pageObj.id
            );


        };

        if(extPages.length > 0) setTimeout(finishPreview.bind(this, 0), 200);
        else {
			callback.call(this, projectId, $canvas);
			this.currentProjectId = null;
		}

        return $canvas;
    };

    this.flattenRenditions = function(renditions) {
        if(renditions.length) {
            var flattenArr = [];
            for(var i=0; i<renditions.length; i++) {
                flattenArr.push(this.flattenRendition(renditions[i]));
            }
            return flattenArr;
        } else {
            return [this.flattenRendition(renditions)];
        }
    };

    this.flattenRendition = function(rendition) {
        var retRenditions = [];
        var children = rendition.childWidgets;
        var segments = rendition.segments;

        retRenditions.push(rendition.$rendition);

        if(children && children.length) {
            for(var i=0; i<children.length; i++) {
                retRenditions = retRenditions.concat(this.flattenRendition(children[i]));
            }
        }

        if(segments && segments.length) {
            for(i=0; i<segments.length; i++) {
                retRenditions = retRenditions.concat(this.flattenRendition(segments[i]));
            }
        }

        return retRenditions;
    };
};

widget.getBlurBox = function(widgetId) {
	var box, widgetBox, pageBox;

	if(widgetsCache[widgetId]) {
		pageBox = pagesCache[widgetsCache[widgetId].pageId].box;
	} else {
		var activePage = storage.get($(".active").attr("id"));
		if(!activePage) {
			pageBox = [0,0, 1, 1];
		} else {
			pageBox = [0,0, activePage.width, activePage.height];
		}
	}

	if(widgetsCache[widgetId]) widgetBox = widgetsCache[widgetId].box;
	else if(widgetId.indexOf('helper-') === 0 ) {
		widgetBox = [0, 0, pageBox[2], pageBox[3]];
	} else widgetBox = [0,0,1,1];

	box = widgetBox;

	//if left/top widget coords are negative, shrink and shift the blur box
	for(var i=0; i<2; i++) {
		if(widgetBox[i]<0) {
			box[i] = 0;
			box[i+2] = box[i+2] + box[i];
		}
	}

	//if right/bottom widget edge exceed page, shrink the blur box
	for(var i=2; i<=3; i++) {
		if(widgetBox[i-2] + widgetBox[i] > pageBox[i]) {
			box[i] = pageBox[i] - box[i-2];
		}
	}

	return box;
};


// Takes widgetId [, pageId [, callback]]
// returns a dataURL that is the blurred render of all widgets below the given widget
widget.renderBlurLayer = function (widgetId, pageId, callback, onerror) {
	pageId = pageId || widgetsCache[widgetId].pageId;

	var pageObj      = storage.get(pageId),
		tempRenderer = new fluid.wdgRenderer(pageObj.width, pageObj.height),
		blurCanvas   = document.createElement('canvas'),
		blurContext  = blurCanvas.getContext('2d'),
		helperId     = (helperId = widgetId.match(/^helper-(.+)/)) && helperId[1],
		blurBox,
		blurRadius   = (helperId
			? widgets.summary[helperId].blur
			: widget.get(widgetId).blur);

	pageObj = tempRenderer.preparePage(pageId);

	blurCanvas.width  = pageObj.width;
	blurCanvas.height = pageObj.height;

	tempRenderer.afterPageRendered = function (pageId, imgData) {
		blurContext.drawImage(tempRenderer.canvas[0], 0, 0)
		utils.blur.canvasRGB(blurCanvas, 0, 0, tempRenderer.canvasSize[0], tempRenderer.canvasSize[1], blurRadius);

		if (callback) {
			try {
				return callback(blurCanvas.toDataURL(0, 0));
			}
			catch (error) {
				return onerror? onerror(error): error;
			}
		}
	};

	// do no render blurs of widgets right now
	tempRenderer.renderBlur = false;

	tempRenderer.useOneCanvas           = true;
	tempRenderer.pageId                 = pageId;
	tempRenderer.renderingQueue[pageId] = [];
	tempRenderer.generateCanvas(pageId);

	tempRenderer.ctx.fillStyle = 'white';
	tempRenderer.ctx.fillRect(0, 0, tempRenderer.canvasSize[0], tempRenderer.canvasSize[1]);

	tempRenderer.renderWidgetsBelow(widgetId, pageObj, !callback);

	blurContext.drawImage(tempRenderer.canvas[0], 0, 0);

	blurBox = widget.getBlurBox(widgetId);
	if(blurBox[2]<0 || blurBox[3]<0) return null;

	utils.blur.canvasRGB(blurCanvas, blurBox[0], blurBox[1], blurBox[2], blurBox[3], blurRadius);
	return blurCanvas.toDataURL();
}




// Takes widgetId [, pageId [, callback]]
// returns a dataURL that is the blurred render of all widgets below the given widget
widget.renderBlurLayerImmediate = function (widgetId, pageId) {
	pageId = pageId || widgetsCache[widgetId].pageId;

	var pageObj      = storage.get(pageId),
		blurCanvas   = document.createElement('canvas'),
		blurBox,
		helperId     = (helperId = widgetId.match(/^helper-(.+)/)) && helperId[1],
		blurRadius   = (helperId
			? widgets.summary[helperId].blur
			: widget.get(widgetId).blur);

	blurCanvas.width  = pageObj.width;
	blurCanvas.height = pageObj.height;

	blurBox = widget.getBlurBox(widgetId);
	if(blurBox[2]<0 || blurBox[3]<0) return null;

	if(this.canvases[pageId]) {
		utils.blur.canvasRGB(blurCanvas, blurBox[0], blurBox[1], blurBox[2], blurBox[3], blurRadius, this.canvases[pageId].get(0) );
	} else {
		utils.blur.canvasRGB(blurCanvas, blurBox[0], blurBox[1], blurBox[2], blurBox[3], blurRadius);
	}

	return blurCanvas;

}


widget.setBlurBG = function (widgetElement) {
    widgetElement.style.backgroundImage = 'url(' + widget.blurLayers[widgetElement.id] + ')';
    widgetElement.style.backgroundPosition = -parseInt(widgetElement.style.left, 10) + 'px ' + -parseInt(widgetElement.style.top, 10) + 'px';
    widgetElement.style.backgroundRepeat = 'no-repeat';
}

// the blurred images of all widgets below each translucent widget
widget.blurLayers = {};


var share =
{
    lastProjectId: null,
    url : null,
    url2 : null,
    downloadURL : null,
    printURL : null,

    init : function(projectId)
    {
        share.lastProjectId = projectId;
        share.setElements(projectId);
        $("input[data-default]", ".ac-container-sharing").click();
    },

    setElements : function(projectId)
    {
        //Create all required URLs
        var projectObj = storage.get(projectId);
        var splitted = (document.location.href).split("?");
        var projectRef = projectId + "." + projectObj.updated;

        share.url = splitted[0] + "project/" + projectRef;
        share.url2 = splitted[0] + "preview/" + projectRef;
        share.downloadURL = splitted[0] + "export/" + projectRef;
        share.printURL = splitted[0] + "?p=" + projectId + "&print=y&print_inter=y";

        //Set links to elements
        var twitterMessage = 'Mobile mockup created with FluidUI.com from @FluidUI_Team ' + share.url2;
        qrCode.setShareURL(share.url, 200);
        $(".previewExternal").attr("href", share.url2);
        $(".previewLinkLong").html(share.url2);
        $(".shareSendMail").find("[name=p]").val(projectRef);
        $('.shareFacebook').
            attr('href', 'http://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(share.url2));
        $('.shareTwitter').
            attr('href', 'http://twitter.com/home?status=' + encodeURIComponent(twitterMessage));


    },

    actionCopyLinkOrCode : function(e)
    {
        $(e.target).select();
        //TODO: Copy the text to the clipboard
    },

    actionAlertCopyLink : function(e)
    {
        notification.add("alert", "Link Copied");
        tracker.record("copiedPreviewLink", 5, "", e);

		fluid.main.fire('shareLinkCopy');
    },


    actionMailSent : function(result)
    {
        //console.log("Result:", result);
        $(".shareSend").addClass("accept").removeClass("inactive").val("Email Mockup");
        $(".shareSend").siblings("span").hide().fadeIn(250).delay(1600).fadeOut(1200);
        share.mailClear();
    },

    actionPreviewExternal : function()
    {
        window.open(share.url2, "previewExternal");
    },

    actionParseSnapshot : function(respData, textStatus, jqXHR) // ajax response
    {
        try {
            var answer = JSON.parse(jqXHR.responseText);
        } catch(e) {
            notification.add( "alert" , "Error starting export" );
            return false;
        }

		if(answer.a === 'PAGES') $msgBox = $('#previewShareContainer .shareLinkExportImg').next('.msg');
		else $msgBox = $('#previewShareContainer .shareLinkExportImgFull').next('.msg');

        if( answer.r == 's') {
			if(answer.queue === 0) {
				$msgBox.html('exporting...');
				$msgBox.addClass('pulsing');
				notification.add( "alert" , "Export in progress. Please stick with us, this can take up to a minute." );
			} else {
				$msgBox.html('queued ('+answer.queue+')...');
				$msgBox.addClass('pulsing');
				notification.add( "alert" , "Project queued for export. Please wait." );
			}

			share.startExportPolling(answer.snapshotId);

        } else {
			$msgBox.html('error...');
			$msgBox.removeClass('pulsing');

            notification.add( "alert" , "Error starting export" );
        }
    },

	startExportPolling: function(id) {
		if(!share.exportPollTimeout) {
			share.exportPollTimeout = 7000;
			share.exportPollMaxRetries = 50;
		}

		share.exportPollTried = 0;
		setTimeout(share.pollExport.bind(share, id), share.exportPollTimeout);
	},

	pollExport: function(id) {
		$.ajax({
			url: "./index.php",
			type: "POST",
			data: {
				t: 'getExportStatus',
				snapshotId: id
			},
			success: function(result, textStatus, jqXHR) {
				var resultData = JSON.parse(result);
				var $msgBox;

				//abort any action if the project user opened any other project or logged out
				if( resultData.projectId !== project.get('id') ) {
					return;
				}

				if(resultData.stype === 'PAGES') $msgBox = $('#previewShareContainer .shareLinkExportImg').next('.msg');
				else $msgBox = $('#previewShareContainer .shareLinkExportImgFull').next('.msg');

				if(resultData.status === 'FAILED') {
					share.exportPollTried = 0;
					$msgBox.html('failed...');
					$msgBox.removeClass('pulsing');
				} else if(resultData.status === 'FINISHED') {
					notification.add( "alert" , 'Export done successfully. Click <a class="export-link" rel="'+resultData.snapshotId+'">here</a> to download' );

					share.exportPollTried = 0;
					$msgBox.html('<a class="export-link" rel="'+resultData.snapshotId+'">Download ('+resultData.processDate+')</a>');
					$msgBox.removeClass('pulsing');
				} else if(resultData.status === 'STARTED' || (resultData.status === 'NEW' && resultData.queue === 0 )) {
					$msgBox.html('exporting...');
					$msgBox.addClass('pulsing');
					share.exportPollTried++;
					if(share.exportPollTried < share.exportPollMaxRetries) {
						setTimeout(share.pollExport.bind(share, id), share.exportPollTimeout);
					}
				} else if(resultData.status === 'NEW') {
					$msgBox.html('queued ('+resultData.queue+')...');
					$msgBox.addClass('pulsing');
					share.exportPollTried++;
					if(share.exportPollTried < share.exportPollMaxRetries) {
						setTimeout(share.pollExport.bind(share, id), share.exportPollTimeout);
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				share.exportPollTried = 0;
				$msgBox.html('error...');
				//console.log('error fetching export status');
			}
		});
	},

	downloadExport: function() {
		var snapshotId = $(this).attr('rel');
		window.open(document.location.origin + document.location.pathname + 'snapshot/'+snapshotId , "_snapshot");
	},

    actionLogSharedProject: function(e)
    {
        var target = $(e.target).attr('data-for');
        ajax.syncUp({target: target}, 'shareLog', share.lastProjectId); // TODO: not sure about syncUp usage here
    },

    actionLink : function(e)
    {
        var match = e.target.classList.toString()
                        // order is important as shareLinkExportImgFull can match shareLinkExportImg
                        .match(/shareLinkDownload|shareLinkExportImgFull|everUsedExport|shareLinkExportImg|shareLinkPrint/);

        if (!match) {
            return;
        } else {
            target = match[0];
        }

        if( fluid.main.fire('share.beforeAction', target) )
        {
            var el = $(e.target);
            if (el.hasClass("shareLinkDownload"))
            {
                window.open(share.downloadURL, "_export");
				fluid.main.fire('projectExport');
            }
            else if (el.hasClass("shareLinkExportImg"))
            {
                ajax.snapshot( share.lastProjectId, "PAGES" , share.actionParseSnapshot );
				fluid.main.fire('projectExport');
            }
            else if (el.hasClass("shareLinkExportImgFull"))
            {
                ajax.snapshot( share.lastProjectId, "PROJECT" , share.actionParseSnapshot );
				fluid.main.fire('projectExport');
            }
            else if (el.hasClass("shareLinkPrint"))
            {
                window.g_window_print = window.open(share.printURL, "_print");
            }
        }
    },

    mailClear : function()
    {
        var el = $(".shareSendMailReceipients");
        var sentemail = el.val();
        if(sentemail != "")
        {
            notification.add('alert', "A link to your mockup has been sent to " + sentemail);
            el.val("");
        }
    }

}


var fluidEvent =
{

    lastEvent : '',
    lastTrigger :  new Date().getTime(),

    triggerEditor : function (eventName, data, forceTrigger)
    {
        fluidEvent._trigger($("#canvas"), eventName, data, forceTrigger);
    },


    bindEditor : function (eventName, callback)
    {
        fluidEvent._bind($("#canvas"), eventName, callback);
    },

    triggerPreview : function (eventName, data, forceTrigger)
    {
        fluidEvent._trigger($("#home"), eventName, data, forceTrigger);
    },


/*  2013-05-14 BD: Most probably obsolete function, please remove as soon as version tested
    bindPreview : function (eventName, callback)
    {
        fluidEvent._bind($("#home"), eventName, callback);
    },*/


    _trigger : function (holder, eventName, data, forceTrigger)
    {
        var trigger = false;
        var now = new Date().getTime();
        var required = forceTrigger || false;

        //If the event is different or wasn't triggered in the last 500 ms, trigger
        if ((fluidEvent.lastEvent != eventName) || (now - fluidEvent.lastTrigger> 500 ) || required)
        {
            trigger = true;
        }

        if (trigger)
        {
            holder.trigger(eventName, data);
            fluidEvent.lastEvent = eventName;
            fluidEvent.lastTrigger = now;
            //console.log("Event Triggered", eventName, data, holder);
        }
    },

	
    _bind : function (holder, eventName, callback)
    {
        holder.live(eventName, callback);
    }



};
