<g:if test="${trackList.size() }">
	<g:each in="${trackList}" var="track">
		<tr>
			<td><div class='info-box' title="${track.title }">${track.title }</div></td>
			<td><div class='info-box' title="${track.artist}">${track.artist }</div></td>
			<td><div class='info-box' title="${track.album }">${track.album }</div></td>
			<td><input type="button" data-id="${track.id}" value="Play" class='list-play-btn'/></td>
			<td><a href="${track.link }">${track.link }</a></td>
		</tr>
	</g:each>
</g:if>
<g:else>
	<tr>
		<td colspan=4 align="center">
			<i>Did not find any results</i>	
		</td>
	</tr>
</g:else>
