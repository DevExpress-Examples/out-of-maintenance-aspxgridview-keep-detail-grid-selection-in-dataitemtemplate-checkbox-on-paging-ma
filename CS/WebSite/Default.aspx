<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register assembly="DevExpress.Web.ASPxGridView.v9.3, Version=9.3.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v9.3, Version=9.3.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxHiddenField" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function ProcessSelection(grid, visibleIndex, checkbox, keyValue, hiddenField) {
            if (checkbox.GetChecked()) {
                grid.SelectRowOnPage(visibleIndex);
                if (!hiddenField.Contains("key"+keyValue.toString())) {
                    hiddenField.Add("key"+keyValue.toString(), true);
                }
            }
            else 
            {
                grid.UnselectRowOnPage(visibleIndex);
                if (hiddenField.Contains("key"+keyValue)) {
                    hiddenField.Remove("key"+keyValue.toString());
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <dx:aspxgridview ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="AccessDataSource1" KeyFieldName="CategoryID" ClientInstanceName="masterGrid">
        <templates>
            <detailrow>
                  <dx:aspxgridview ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="AccessDataSource2" KeyFieldName="ProductID" 
                      onbeforeperformdataselect="ASPxGridView1_BeforePerformDataSelect" 
                      oninit="ASPxGridView1_Init" ondatabound="ASPxGridView1_DataBound">
                      <columns>
                          <dx:gridviewdatatextcolumn FieldName="ProductID" VisibleIndex="1">
                          </dx:gridviewdatatextcolumn>
                          <dx:gridviewdatatextcolumn FieldName="ProductName" VisibleIndex="2">
                          </dx:gridviewdatatextcolumn>
                          <dx:gridviewdatatextcolumn FieldName="UnitPrice" VisibleIndex="3">
                          </dx:gridviewdatatextcolumn>
                          <dx:gridviewdatatextcolumn Caption="#" Name="Selection" VisibleIndex="0">
                              <dataitemtemplate>
                                  <dx:aspxcheckbox ID="detailSelectCheckbox" runat="server" 
                                      oninit="detailSelectCheckbox_Init">
                                  </dx:aspxcheckbox>
                              </dataitemtemplate>
                          </dx:gridviewdatatextcolumn>
                      </columns>
                  </dx:aspxgridview>
            </detailrow>
        </templates>
        <settingspager PageSize="4">
        </settingspager>
        <columns>
            <dx:gridviewdatatextcolumn FieldName="CategoryID" ReadOnly="True" 
                VisibleIndex="1">
                <editformsettings Visible="False" />
            </dx:gridviewdatatextcolumn>
            <dx:gridviewdatatextcolumn FieldName="CategoryName" VisibleIndex="2">
            </dx:gridviewdatatextcolumn>
            <dx:gridviewdatatextcolumn FieldName="Description" VisibleIndex="3">
            </dx:gridviewdatatextcolumn>
          
        </columns>
        <settingsdetail ShowDetailRow="True" />
    </dx:aspxgridview>
    <asp:accessdatasource ID="AccessDataSource1" runat="server" 
        DataFile="~/App_Data/nwind.mdb" SelectCommand="SELECT * FROM [Categories]">
    </asp:accessdatasource>
     <asp:accessdatasource ID="AccessDataSource2" runat="server" 
        DataFile="~/App_Data/nwind.mdb" 
        SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Products] WHERE ([CategoryID] = ?)">
         <selectparameters>
             <asp:sessionparameter Name="CategoryID" SessionField="CategoryID" 
                 Type="Int32" />
         </selectparameters>
    </asp:accessdatasource>
    <dx:aspxhiddenfield ID="masterSelection" ClientInstanceName="masterSelection" runat="server">
    </dx:aspxhiddenfield>
      <dx:aspxhiddenfield ID="detailSelection" ClientInstanceName="detailSelection" runat="server">
    </dx:aspxhiddenfield>
    
   
    </form>
</body>
</html>
