    <link href="css/mainpage.css" rel="stylesheet">
    <!-- Fixed navbar -->
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="?">PTSD</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="?">Home</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container" role="main">
        <br />
      <div class="page-header">
        <h1>{$title}{if isset($subTitle)} <small>{$subTitle}</small>{/if}</h1>
        {if isset($biLine)}<h3 class='biLine'><small>{$biLine}</small></h3>{/if}
      </div>

      {include file=$subpage}

    </div> <!-- /container -->
    