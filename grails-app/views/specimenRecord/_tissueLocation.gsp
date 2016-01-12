<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templateseci
  and open the template in the editor.
-->

<!-- This template renders a drop down after a city is selected -->
%{-- <g:select name="team.id" from="${teams}" optionValue="name"
          optionKey="id"/> --}%
%{-- <g:select name="tissueLocation.id" from="${tissueLocations}" optionKey="id" optionValue="${specimenRecordInstance?.tissueLocation?.id}" class="many-to-one" noSelection="['':'-Select one-']"/> --}%
<g:select name="tissueLocation.id" from="${tissueLocs}" optionKey="id" optionValue="${specimenRecordInstance?.tissueLocation?.id}" class="many-to-one" noSelection="['':'-Select one-']"/>

