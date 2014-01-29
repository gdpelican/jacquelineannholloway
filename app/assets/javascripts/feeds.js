
function loadFeeds() {
    google.load('feeds', '1', {"callback" : function() {
        var feed = new google.feeds.Feed('http://jacquelineannholloway.wordpress.com/feed');
        feed.load(function(result) {
            if (!result.error) {
                var container = document.getElementById('blog');

                for (var i = 0; i < result.feed.entries.length; i++) {
                  var entryContainer = document.createElement('div');
                  var titleContainer = document.createElement('div');
                  var title = document.createElement('div');
                  var timestamp = document.createElement('div');
                  var content = document.createElement('div');
                  var toggle = document.createElement('div');
                  var post = result.feed.entries[i];

                  container.appendChild(entryContainer).className = 'blog-entry blog-closed border primary';

                  toggle.innerHTML = 'Close';
                  entryContainer.appendChild(titleContainer).className = 'blog-header blog-toggle';
                  entryContainer.appendChild(content).className = 'blog-content';
                  entryContainer.appendChild(toggle).className = 'blog-footer blog-toggle';

                  titleContainer.appendChild(title).className = 'blog-title';
                  titleContainer.appendChild(timestamp).className = 'blog-timestamp';

                  title.innerHTML = post.title;
                  timestamp.innerHTML = 'Posted on ' + Date.parse(post.publishedDate).toString('dd MMM yyyy, h:mtt');
                  content.innerHTML = post.content;
                }  

                $('.blog-toggle').click(function() {
                    $(this).parent().toggleClass('blog-closed').toggleClass('blog-open');
                    $(this).siblings('.blog-content').slideToggle('slow');
                });
                
            }
        });  
    }});
}

$(document).ready(function() {
    
    function initLoader() {
      var script = document.createElement("script");
      script.src = "https://www.google.com/jsapi?callback=loadFeeds";
      script.type = "text/javascript";
      document.getElementsByTagName("head")[0].appendChild(script);
    }
    
    if($('#blog').length > 0) 
        initLoader();
    
});