class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        //"500"(view:"/error")
        "500"(controller: 'errors', action: 'error500')
        "403"(controller: 'errors', action: 'error500')
        "401"(controller: 'errors', action: 'error500')
        "404"(controller: 'errors', action: 'error404')
        
        
        
        //Landing page URLs
        "/"(controller:"home",action:"homedispatcher")
        "/home"(controller:"home",action:"homedispatcher")
        
        //pmh for some reason this is not working for me in grails 2.4.4..
        "/activitycenter1"(view: "generic")  {
            title = "Activity Center"
            bodyclass = "recentactivity"
            navigation = "/cdrlite;home;Home"
            divs = "recentactivity"
            h1studysession = true
        }
        
        //pmh 08/24/15 activity events related..
        "/activitycenter"(controller:"home",action:"generic")
        
        "/rest/processingevent/"(controller:"rest",action:"processingEventRestActions")
        
        
        
	}
}
