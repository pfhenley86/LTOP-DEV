if(!window.fluid){window.fluid={}}fluid.projectPreloader=function(){this.firstPreload=function(b,d){this.projectId=b;this._pagePreloadDone=false;this._projectLoaded=false;this.pagesPrefetched=[];this.firstPreloadSuccess;window.uploadsCache={};var c=storage.get(b);if(c&&!c.unloaded){if(project.get("pages").length===0){this._pagePreloadDone=true;return}this.projectSource="localstorage";var a=project.getPagesInViewport("init");dbStorage.onReady(function(){this.dbGetPages(a,1)}.bind(this))}else{this.projectSource="localDB";this.projectBundle="loading";this.dbGetProject(b)}};this.secondPreload=function(){var c=project.get("pages");var b=[];for(var e=0;e<c.length;e++){if(!pagesCache[c[e]].img){b.push(c[e])}}if(b.length!==0){this.dbGetPages(b,2)}var d=project.bundle(this.projectId).uploads;var a=[];for(var f in d){if(d.hasOwnProperty(f)){a.push(f)}}this.dbGetUploads(a)};this.projectLoaded=function(b){this.afterPagesDone=b;this._projectLoaded=true;if(this._pagePreloadDone){if(this.projectSource==="localDB"&&this.pagesValid()){this.firstPreloadSuccess=true;for(var a=0;a<this.pagesPrefetched.length;a++){pagesCache[this.pagesPrefetched[a].id].img=this.pagesPrefetched[a].data}this.afterPagesDone();this.secondPreload()}else{if(this.projectSource==="localstorage"){this.afterPagesDone();this.secondPreload()}else{this.afterPagesDone()}}}};this.dbGetPages=function(a,b,c){dbStorage.get("rastPages",a,function(f,e){for(var d=0;d<e.fetched.length;d++){if(c){this.pagesPrefetched.push(e.resultsObj[e.fetched[d]])}else{pagesCache[e.fetched[d]].img=e.resultsObj[e.fetched[d]].data}}if(b===1){this._pagePreloadDone=true;if(this._projectLoaded){if(this.projectSource=="localDB"&&this.pagesValid()){this.firstPreloadSuccess=true;for(var d=0;d<this.pagesPrefetched.length;d++){pagesCache[this.pagesPrefetched[d].id].img=this.pagesPrefetched[d].data}this.afterPagesDone();this.secondPreload()}else{if(this.projectSource==="localstorage"){this.afterPagesDone();this.secondPreload()}else{this.afterPagesDone()}}}}else{if(b===2){}}}.bind(this,a))};this.dbGetProject=function(a){dbStorage.get("projects",a,function(b){if(b.resultsArr[0]&&b.resultsArr[0].data[a].visiblePages!==undefined){this.projectBundle=b.resultsArr[0].data;this.dbGetPages(b.resultsArr[0].data[a].visiblePages,1,true)}else{this.projectBundle="notFound";this._pagePreloadDone=true}}.bind(this))};this.dbGetUploads=function(a){dbStorage.get("uploads",a,function(c){for(var b=0;b<c.fetched.length;b++){uploadsCache[c.fetched[b]]=c.resultsObj[c.fetched[b]].data}}.bind(this))};this.pagesValid=function(){if(this.projectBundle&&this.projectBundle!=="notFound"){var a=project.bundle(this.projectId);var b=this.projectBundle;for(var c in a){if(a.hasOwnProperty(c)&&!b[c]&&c!=="uploads"){return false}}for(c in b){if(b.hasOwnProperty(c)&&!a[c]&&c!=="uploads"){return false}}return true}else{return false}}};