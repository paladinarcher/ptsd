            <link href="css/signinsheet.css" rel="stylesheet">
            <form class="form-signin" action="index.php?cmd=doLogin" method="POST">
                <input type="hidden" name="mod" value="Plugins\User" />
                <!-- <input type="hidden" name="cmd" value="doLogin" /> -->
                <h2 class="form-signin-heading">Please sign in</h2>
                {if isset($errormsg)}
                <div class="alert alert-danger" role="alert"><strong>{$errortitle}</strong> {$errormsg}</div>
                {/if}
                <label for="inputEmail" class="sr-only">Email address</label>
                <input type="email" id="inputEmail" class="form-control" placeholder="Email address" name="args[email]" required autofocus>
                <label for="inputPassword" class="sr-only">Password</label>
                <input type="password" id="inputPassword" class="form-control" name="args[password]" placeholder="Password" required>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" value="remember-me" name="args[rememberme]"> Remember me
                  </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
            </form>