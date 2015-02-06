CKEDITOR.editorConfig = function( config ) {
    config.language = 'en';
    config.uiColor = '#AADC6E';
    /* Filebrowser routes */
    // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
    config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
    config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

    // The location of a script that handles file uploads in the Flash dialog.
    config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
    config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
    config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads in the Image dialog.
    config.filebrowserImageUploadUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads.
    config.filebrowserUploadUrl = "/ckeditor/attachment_files";
    config.extraPlugins                    = 'justify,table';

    // Rails CSRF token
    config.filebrowserParams = function(){
      var csrf_token, csrf_param, meta,
          metas = document.getElementsByTagName('meta'),
          params = new Object();

      for ( var i = 0 ; i < metas.length ; i++ ){
        meta = metas[i];

        switch(meta.name) {
          case "csrf-token":
            csrf_token = meta.content;
            break;
          case "csrf-param":
            csrf_param = meta.content;
            break;
          default:
            continue;
        }
      }

      if (csrf_param !== undefined && csrf_token !== undefined) {
        params[csrf_param] = csrf_token;
      }

      return params;
    };

    config.addQueryString = function( url, params ){
      var queryString = [];

      if ( !params ) {
        return url;
      } else {
        for ( var i in params )
          queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
      }

      return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
    };
    
    config.allowedContent = {
        $1: {
            // Use the ability to specify elements as an object.
            elements: CKEDITOR.dtd,
            attributes: true,
            styles: true,
            classes: true
        }
    };
    config.disallowedContent = 'script; span; *[on*]; *{*}';
};