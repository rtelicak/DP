 <div class="navbar">
            <div class="navbar-inner">
                <ul class="nav pull-right">
                    <li id="fat-menu" class="dropdown">
                        <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-user"></i><?php echo $username ?>
                        <i class="icon-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="divider visible-phone"></li>
                            <li><a tabindex="-1" href="<?php echo base_url() ?>task/task_list/<?php $loggedUser = $this->session->userdata('logged_in');  echo $loggedUser['id']; ?>">Moje úlohy</a></li>
                            <li class="divider visible-phone"></li>
                            <li><a tabindex="-1" href="<?php echo base_url(); ?>home/logout">Odhlásenie</a></li>
                        </ul>
                    </li>
                </ul>
                <a class="brand" href="<?php echo base_url(); ?>home"><span class="first">Projekt</span> - <span class="second">Softvérové Inžinierstvo II</span></a>
            </div>
        </div>