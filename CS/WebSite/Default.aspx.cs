using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxEditors;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region "Set master grid"
       
    #endregion

    #region "Set detail grid"
    protected void ASPxGridView1_BeforePerformDataSelect(object sender, EventArgs e)
    {
        Session["CategoryID"] = ((ASPxGridView)sender).GetMasterRowKeyValue();
    }

    protected void ASPxGridView1_DataBound(object sender, EventArgs e)
    {
        ((ASPxGridView)sender).ClientInstanceName = "detailGrid" + ((ASPxGridView)sender).GetMasterRowKeyValue().ToString();

        for (int i = 0; i < ((ASPxGridView)sender).VisibleRowCount; i++)
        {
            string key = ((ASPxGridView)sender).GetRowValues(i, "ProductID").ToString();
            if (detailSelection.Contains("key" + key))
            {
                ((ASPxGridView)sender).Selection.SelectRow(i);
            }
        }
    }
    protected void ASPxGridView1_Init(object sender, EventArgs e)
    {
        ((ASPxGridView)sender).ClientInstanceName = "detailGrid" + ((ASPxGridView)sender).GetMasterRowKeyValue().ToString();

    }

   
   #endregion

    #region "Set select checkbox"
    protected void detailSelectCheckbox_Init(object sender, EventArgs e)
    {
        GridViewDataItemTemplateContainer c = ((ASPxCheckBox)sender).NamingContainer as
    GridViewDataItemTemplateContainer;
        int index = c.VisibleIndex;
        string key = c.KeyValue.ToString();
        string ownerGridClientInstanceName = c.Grid.ClientInstanceName;

        ((ASPxCheckBox)sender).ClientSideEvents.CheckedChanged = "function(s,e){ProcessSelection(" +
            ownerGridClientInstanceName + "," + index + ",s," + key + ",detailSelection);}";

        if (c.Grid.Selection.IsRowSelected(index))
        {
            ((ASPxCheckBox)sender).Checked = true;
        }
    }
    #endregion

   
 
  

   
}
