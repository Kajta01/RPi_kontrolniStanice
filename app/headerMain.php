
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Collapsible sidebar using Bootstrap 4</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="headerStyle.css">

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>



</head>

<body>

    <div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar" class="sticky-top">
            <div class="sticky-top" >
                <div class="sidebar-header">
                    <h3>Bootstrap Sidebar</h3>
                    <strong>BS</strong>
                </div>



                <div class="custom-menu">
                    <button type="button" id="sidebarCollapse" class="navbar-btn">
                        <i class="fa fa-bars"></i>
                    </button>
                </div>

                <ul class="list-unstyled components">
                    <li class="active">
                        <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                            <i class="fas fa-home"></i>
                            Home
                        </a>
                        <ul class="collapse list-unstyled" id="homeSubmenu">
                            <li>
                                <a href="#">Home 1</a>
                            </li>
                            <li>
                                <a href="#">Home 2</a>
                            </li>
                            <li>
                                <a href="#">Home 3</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-briefcase"></i>
                            About
                        </a>
                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                            <i class="fas fa-copy"></i>
                            Pages
                        </a>
                        <ul class="collapse list-unstyled" id="pageSubmenu">
                            <li>
                                <a href="#">Page 1</a>
                            </li>
                            <li>
                                <a href="#">Page 2</a>
                            </li>
                            <li>
                                <a href="#">Page 3</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-image"></i>
                            Portfolio
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-question"></i>
                            FAQ
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-paper-plane"></i>
                            Contact
                        </a>
                    </li>
                </ul>

                <ul class="list-unstyled CTAs">
                    <li>
                        <a href="https://bootstrapious.com/tutorial/files/sidebar.zip" class="download">Download source</a>
                    </li>
                    <li>
                        <a href="https://bootstrapious.com/p/bootstrap-sidebar" class="article">Back to article</a>
                    </li>
                </ul>
            </div>
        </nav>


        <!-- Page Content  -->
        <div id="content">

            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Integer vulputate sem a nibh rutrum consequat. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Donec quis nibh at felis congue commodo. Fusce wisi. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Pellentesque ipsum. Et harum quidem rerum facilis est et expedita distinctio. Integer pellentesque quam vel velit. Integer vulputate sem a nibh rutrum consequat. Nam quis nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent dapibus. Mauris dictum facilisis augue. Integer tempor.

            Duis condimentum augue id magna semper rutrum. Pellentesque pretium lectus id turpis. Proin in tellus sit amet nibh dignissim sagittis. Curabitur vitae diam non enim vestibulum interdum. Curabitur bibendum justo non orci. Etiam egestas wisi a erat. Etiam bibendum elit eget erat. Ut tempus purus at lorem. Integer lacinia. Quisque porta. Fusce tellus odio, dapibus id fermentum quis, suscipit id erat.

            Donec quis nibh at felis congue commodo. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Curabitur sagittis hendrerit ante. Donec quis nibh at felis congue commodo. Praesent id justo in neque elementum ultrices. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Nam sed tellus id magna elementum tincidunt. Integer tempor. Etiam egestas wisi a erat. In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. In enim a arcu imperdiet malesuada. Praesent dapibus. Praesent id justo in neque elementum ultrices. Vivamus luctus egestas leo. Pellentesque sapien. Maecenas lorem. Aenean id metus id velit ullamcorper pulvinar.

            Nunc tincidunt ante vitae massa. Sed ac dolor sit amet purus malesuada congue. Fusce aliquam vestibulum ipsum. Quisque tincidunt scelerisque libero. Nullam at arcu a est sollicitudin euismod. Duis ante orci, molestie vitae vehicula venenatis, tincidunt ac pede. Morbi imperdiet, mauris ac auctor dictum, nisl ligula egestas nulla, et sollicitudin sem purus in lacus. Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Morbi imperdiet, mauris ac auctor dictum, nisl ligula egestas nulla, et sollicitudin sem purus in lacus. Mauris tincidunt sem sed arcu. In convallis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer imperdiet lectus quis justo. Nullam faucibus mi quis velit. Curabitur ligula sapien, pulvinar a vestibulum quis, facilisis vel sapien. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Vivamus ac leo pretium faucibus. Etiam quis quam.

            Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Vivamus luctus egestas leo. Duis viverra diam non justo. Integer pellentesque quam vel velit. Aliquam ante. Morbi imperdiet, mauris ac auctor dictum, nisl ligula egestas nulla, et sollicitudin sem purus in lacus. Integer in sapien. Mauris dictum facilisis augue. Maecenas aliquet accumsan leo. Phasellus rhoncus.

        </div>
    </div>

    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <!-- Popper.JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#sidebarCollapse').on('click', function() {
                $('#sidebar').toggleClass('active');
            });
        });
    </script>
</body>

</html>