
<%@ page import="com.rg.core.Track" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'track.label', default: 'Track')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'track.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="type" title="${message(code: 'track.type.label', default: 'Type')}" />
                        
                            <g:sortableColumn property="link" title="${message(code: 'track.link.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="length" title="${message(code: 'track.length.label', default: 'Genre')}" />
                        
                            <g:sortableColumn property="details" title="${message(code: 'track.details.label', default: 'Details')}" />
                        
                            <g:sortableColumn property="suggestions" title="${message(code: 'track.suggestions.label', default: 'Suggestions')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${trackInstanceList}" status="i" var="trackInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${trackInstance.id}">${fieldValue(bean: trackInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: trackInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: trackInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: trackInstance, field: "genre")}</td>
                        
                            <td>${fieldValue(bean: trackInstance, field: "details")}</td>
                        
                            <td>${fieldValue(bean: trackInstance, field: "suggestions")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${trackInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
