<%
    if (username.length() > 0) {
 %>
    <li class="nav-item">
        <div class="btn-group nav-link" role="group">
            <button id="btnGroupDrop1" type="button"
                class="btn btn-primary
                dropdown-toggle" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">
                <%=username%>
            </button>
            <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                <a class="dropdown-item" href="../user">Control Panel</a>
                <a class="dropdown-item" href="../Logout">Logout</a>
            </div>
        </div>
    </li>
<%
    }
 %>
    </ul>
    </div>
</div>
</nav>