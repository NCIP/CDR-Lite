%{-- <%@ page import="nci.bbrb.cdr.staticmembers.Module" %> --}%
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<g:hasErrors bean="${slideRecord}">
    <div class="errors">
        <g:renderErrors bean="${slideRecord}" as="list"/>
    </div>
</g:hasErrors>

<table>
    <tbody>
      <tr>
          <th valign="top" class="name">
              Slide ID
          </th>
          <th valign="top" class="name">
              Specimen
          </th>
          <th class="editOnly" valign="top" style="text-align: center">
              Action
          </th>
      </tr>
      <g:each in="${slides}" status="i" var="slide">
          <tr class="${i%2 == 0 ? 'even' : 'odd'}">
              <td> ${slide?.slideId}</td>
              <td> ${slide?.specimenRecord?.specimenId}</td>
          </tr>
      </g:each>
    </tbody>
</table>