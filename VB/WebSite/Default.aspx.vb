Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

	End Sub

	#region "Set master grid"

	#End Region

	#region "Set detail grid"
	Protected Sub ASPxGridView1_BeforePerformDataSelect(ByVal sender As Object, ByVal e As EventArgs)
		Session("CategoryID") = (CType(sender, ASPxGridView)).GetMasterRowKeyValue()
	End Sub

	Protected Sub ASPxGridView1_DataBound(ByVal sender As Object, ByVal e As EventArgs)
		CType(sender, ASPxGridView).ClientInstanceName = "detailGrid" & (CType(sender, ASPxGridView)).GetMasterRowKeyValue().ToString()

		For i As Integer = 0 To (CType(sender, ASPxGridView)).VisibleRowCount - 1
			Dim key As String = (CType(sender, ASPxGridView)).GetRowValues(i, "ProductID").ToString()
			If detailSelection.Contains("key" & key) Then
				CType(sender, ASPxGridView).Selection.SelectRow(i)
			End If
		Next i
	End Sub
	Protected Sub ASPxGridView1_Init(ByVal sender As Object, ByVal e As EventArgs)
		CType(sender, ASPxGridView).ClientInstanceName = "detailGrid" & (CType(sender, ASPxGridView)).GetMasterRowKeyValue().ToString()

	End Sub


   #End Region

	#region "Set select checkbox"
	Protected Sub detailSelectCheckbox_Init(ByVal sender As Object, ByVal e As EventArgs)
		Dim c As GridViewDataItemTemplateContainer = TryCast((CType(sender, ASPxCheckBox)).NamingContainer, GridViewDataItemTemplateContainer)
		Dim index As Integer = c.VisibleIndex
		Dim key As String = c.KeyValue.ToString()
		Dim ownerGridClientInstanceName As String = c.Grid.ClientInstanceName

		CType(sender, ASPxCheckBox).ClientSideEvents.CheckedChanged = "function(s,e){ProcessSelection(" & ownerGridClientInstanceName & "," & index & ",s," & key & ",detailSelection);}"

		If c.Grid.Selection.IsRowSelected(index) Then
			CType(sender, ASPxCheckBox).Checked = True
		End If
	End Sub
	#End Region






End Class
