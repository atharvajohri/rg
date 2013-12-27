

<%@ page import="com.rg.core.Track" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'track.label', default: 'Track')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${trackInstance}">
            <div class="errors">
                <g:renderErrors bean="${trackInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="track.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${trackInstance?.type}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="link"><g:message code="track.link.label" default="Link" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'link', 'errors')}">
                                    <g:textField name="link" value="${trackInstance?.link}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="length"><g:message code="track.length.label" default="Length" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'length', 'errors')}">
                                    <g:textField name="length" value="${trackInstance?.length}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="details"><g:message code="track.details.label" default="Details" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'details', 'errors')}">
                                    <g:textField name="details" value="${trackInstance?.details}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="suggestions"><g:message code="track.suggestions.label" default="Suggestions" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'suggestions', 'errors')}">
                                    <g:textField name="suggestions" value="${trackInstance?.suggestions}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="genre"><g:message code="track.genre.label" default="Genre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'genre', 'errors')}">
                                    <g:textField name="genre" value="${trackInstance?.genre}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fromSite"><g:message code="track.fromSite.label" default="From Site" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'fromSite', 'errors')}">
                                    <g:textField name="fromSite" value="${trackInstance?.fromSite}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="active"><g:message code="track.active.label" default="Active" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'active', 'errors')}">
                                    <g:checkBox name="active" value="${trackInstance?.active}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="album"><g:message code="track.album.label" default="Album" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'album', 'errors')}">
                                    <g:textField name="album" value="${trackInstance?.album}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="artist"><g:message code="track.artist.label" default="Artist" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'artist', 'errors')}">
                                    <g:textField name="artist" value="${trackInstance?.artist}" />
                                </td>
                            </tr>
                            
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="artist">Artwork</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'artwork', 'errors')}">
                                    <g:textField name="artist" value="${trackInstance?.artwork}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title"><g:message code="track.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: trackInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${trackInstance?.title}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
