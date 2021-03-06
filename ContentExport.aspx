﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContentExport.aspx.cs" Inherits="ContentExportTool.ContentExport" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Content Export Tool</title>
    <style>
        body {
            background: white !important;
            padding: 10px;
        }

        .header {
            color: brown;
        }

        .notes {
            color: GrayText;
            font-size: 12px;
        }

        .container {
            margin-bottom: 10px;
            font-family: Arial;
        }

        .advanced .advanced-inner {
            display: none;
            margin-top: 10px;
        }

        .advanced .advanced-btn {
            color: brown;
            font-weight: bold;
            padding-bottom: 10px;
            cursor: pointer;
        }

            .advanced .advanced-btn:after {
                border-style: solid;
                border-width: 0.25em 0.25em 0 0;
                content: '';
                display: inline-block;
                height: 0.45em;
                left: 0.15em;
                position: relative;
                vertical-align: top;
                width: 0.45em;
                top: 0;
                transform: rotate(135deg);
                margin-left: 5px;
            }

        .advanced.open a.advanced-btn:after {
            top: 0.3em;
            transform: rotate(-45deg);
        }

        .txtCustomDatabase {
            margin-left: 5px;
        }

        .include-ids {
            color: brown;
            font-size: 14px;
        }

        input[type='text'] {
            width: 500px;
            max-width: 80%;
        }

        a.clear-btn, .show-hints {
            cursor: pointer;
            color: brown;
            font-size: 11px;
            margin-left: 6px;
        }

        .show-hints {
            margin-left: 0;
            display: block;
        }

        .lit-fast-query {
            color: brown;
            font-size: 12px;
        }

        .hints .notes {
            display: block;
            display: none;
            width: 750px;
            max-width: 80%;
        }

        .browse-btn {
            margin-left: 5px;
        }

        .modal.browse-modal {
            z-index: 999;
            position: absolute;
            background: white;
            border: 2px solid brown;
            width: 700px;
            margin-left: 20%;
            height: 60%;
        }

        .selector-box {
            width: 450px;
            overflow: scroll;
            height: 100%;
            float: left;
        }

        .selection-box {
            display: inline-block;
            width: 250px;
            height: 100%;
            position: relative;
        }

        .modal.browse-modal ul {
            list-style: none;
            width: 100%;
            margin-top: 0;
        }

            .modal.browse-modal ul li {
                position: relative;
                left: -20px;
            }

        .modal.browse-modal li ul {
            display: none;
        }

        .modal.browse-modal li.expanded > ul {
            display: block;
        }

        .modal.browse-modal a {
            cursor: pointer;
            text-decoration: none;
            color: black;
        }

        .modal.browse-modal a:hover {
            font-weight: bold;
        }

        .modal.browse-modal .browse-expand {
            color: brown;
            position: absolute;
        }

        .modal.browse-modal .sitecore-node {
            margin-left: 12px;
            display: block;
        }

        .main-btns .right {
            float: right;
        }

        .main-btns {
            width: 600px;
            display: inline-block;
            height: auto;
        }

            .main-btns .left {
                float: left;
            }

        .save-settings-box {
            border: 1px solid;
            background: #eee;
            padding: 5px;
            left: 20%;
        }

            .save-settings-box input[type="text"] {
                width: 200px;
            }

        .save-settings-close {
            position: absolute;
            right: 2px;
            cursor: pointer;
            top: 2px;
        }

        #btnSaveSettings {
            display: none;
        }

        .error-message {
            color: red;
            font-size: 12px;
            display: none;
        }

            .error-message.server {
                display: block;
            }

        span.save-message {
            color: brown;
            margin-left: 2px;
            display: inline-block;
        }

        .row:not(:last-child) {
            margin-bottom: 5px;
        }

        .btn-clear-all {
            background: none;
            border: none;
            color: brown;
            margin-top: 10px;
            font-size: 14px;
            padding: 0;
            cursor: pointer;
        }

        .selection-box-inner {
            padding: 10px;
        }

        a.btn {
            font-weight: normal !important;
            padding: 1px 6px;
            align-items: flex-start;
            text-align: center;
            cursor: default !important;
            color: buttontext !important;
            background-color: buttonface;
            box-sizing: border-box;
            border-width: 2px;
            border-style: outset;
            border-color: buttonface;
            border-image: initial;
            text-rendering: auto;
            letter-spacing: normal;
            word-spacing: normal;
            text-transform: none;
            text-shadow: none;
            -webkit-appearance: button;
            -webkit-writing-mode: horizontal-tb;
            font: 13.3333px Arial;
        }

        .btn.disabled {
            pointer-events: none;
            color: graytext !important;
        }

        span.selected-node {
            width: 100%;
            word-wrap: break-word;
            display: inline-block;
            font-size: 14px;
        }

        .browse-btns {
            margin-top: 10px;
        }

        .select-box {
            width: 48%;
            height: 100%;
            float: left;
            overflow: auto;
            font-size: 14px;
            position: relative;
        }

        .selector-box {
            position: relative;
            font-size: 14px;
        }

        .selected-box {
            width: 48%;
            height: 100%;
            float: right;
            position: relative;
        }

        .arrows {
            width: 4%;
            height: 100%;
            margin: 0;
            float: left;
            background: #eee;
            font-size: 14px;
        }

        .temp-selected, .temp-selected-remove {
            display: none;
        }

        .modal.browse-modal.templates a.selected, .modal.browse-modal.templates a:hover,
        .modal.browse-modal.fields a.selected, .modal.browse-modal.fields a:hover {
            font-weight: bold;
        }

        .modal.browse-modal.templates a .modal.browse-modal.fields a {
            font-weight: normal;
            font-size: 14px;
        }

        .browse-btns {
            padding: 0 20px 20px 0;
            position: absolute;
            right: 0;
            bottom: 0;
            text-align: right;
            width: 90%;
        }

        #btnBrowseTemplates,
        #btnBrowseFields {
            position: relative;
            top: -13px;
        }

        .modal.browse-modal.templates a {
            font-weight: normal;
        }

        .modal.browse-modal.templates span {
            color: darkgray;
            margin-left: 5px;
        }

        .disabled {
            pointer-events: none;
            color: darkgray !important;
        }

        .browse-modal li span {
            margin-left: 10px;
            color: darkgray;
        }

        .modal.browse-modal.fields a {
            font-weight: normal;
        }

        .modal.browse-modal a.select-all {
            font-size: 12px;
            margin-left: 5px;
            color: brown;
            cursor: pointer;
        }

        ul.selected-box-list a {
            font-size: 14px;
        }

        ul.selected-box-list {
            max-height: 90%;
            overflow-y: auto;
            width: 100%;
            padding-left: 0;
            margin: 0;
        }

        .modal.browse-modal ul.selected-box-list li {
            left: 0;
            padding-left: 10px;
        }

        .arrows .btn {
            position: relative;
            top: 150px;
            margin-bottom: 10px;
        }

        input.field-search {
            width: 94%;
            display: inline-block;
            margin-bottom: 10px;
            max-width: none;
            padding: 4px 16px 2px 5px;
            border: none;
            border-bottom: 1px solid #ccc;
        }

        ::-webkit-input-placeholder { /* Chrome/Opera/Safari */
          font-style:italic;
        }
        ::-moz-placeholder { /* Firefox 19+ */
          font-style:italic;
        }
        :-ms-input-placeholder { /* IE 10+ */
          font-style:italic;
        }
        :-moz-placeholder { /* Firefox 18- */
          font-style:italic;
        }

        a.clear-search {
            position: absolute;
            right: 2px;
            top: 2px;
            color: darkgray !important;
        }

        li.hidden {
            display: none;
        }

        .hidden {
            display: none;
        }

        .clear-selections {
            float: left;
        }
    </style>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="ContentExportScripts.js"></script>

</head>
<body>
<asp:PlaceHolder runat="server" ID="phOverwriteScript" Visible="False">
    <script>
        $(document).ready(function() {
            var overwrite = confirm("There are already settings saved with this name. Do you want to overwrite?");
            if (overwrite) {
                $(".btn-overwrite").click();
            }
        });
    </script>
</asp:PlaceHolder>
    <form id="form1" runat="server">
        <div>
            <h2 id="headline" runat="server">Content Export Tool</h2>

            <div class="container" style="background-color: brown; border-width: 1px; color: white; width: 600px; padding: 2px 4px; font-size: 12px">
                <asp:Literal runat="server" ID="litFeedback"></asp:Literal>
            </div>

            <div class="controls">



                <div class="main-btns">
                    <div class="left">
                        <asp:Button runat="server" ID="btnRunExport" OnClick="btnRunExport_OnClick" Text="Run Export" /><br />
                        <asp:Button runat="server" ID="btnClearAll" Text="Clear All" OnClick="btnClearAll_OnClick" CssClass="btn-clear-all" />
                    </div>

                    <div class="right">
                        <div class="save-settings-box">
                            <div class="row">
                                <span class="header">Enter a name to save: </span>
                                <input runat="server" id="txtSaveSettingsName" />
                                <input type="button" class="save-btn-decoy" value="Save Settings" />
                                <asp:Button runat="server" ID="btnSaveSettings" OnClick="btnSaveSettings_OnClick" Text="Save Settings" /><span class="save-message">
                                    <asp:Literal runat="server" ID="litSavedMessage"></asp:Literal></span>
                                <asp:Button runat="server" ID="btnOverWriteSettings" OnClick="btnOverWriteSettings_OnClick" CssClass="hidden btn-overwrite"/>

                                <span class="error-message">You must enter a name for this configuration<br />
                                </span>
                            </div>
                            <div class="row">
                                <span class="header">Saved settings: </span>
                                <asp:DropDownList runat="server" ID="ddSavedSettings" AutoPostBack="True" OnSelectedIndexChanged="ddSavedSettings_OnSelectedIndexChanged" />
                                <a runat="server" Visible="False" ID="btnDeletePrompt" class="btn" onclick="confirmDelete()">Delete</a>
                                <asp:Button runat="server" ID="btnDeleteSavedSetting" OnClick="btnDeleteSavedSetting_OnClick" CssClass="hidden btn-delete"/><br />
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <br />

                <div class="container">

                    <asp:PlaceHolder runat="server" ID="PhBrowseTree">
                        <div class="modal browse-modal">
                            <div class="selector-box left">
                                <input class="field-search" type="text" placeholder="search" onkeyup="browseSearch($(this))"/>
                                <a class="clear-search" href="javascript:void(0)" onclick="clearSearch($(this))">X</a>
                                <asp:Literal runat="server" ID="litSitecoreContentTree"></asp:Literal>
                            </div>
                            <div class="selection-box">
                                <div class="selection-box-inner">
                                    <span class="header">Selected node:</span><br />
                                    <span class="selected-node">(No node selected)</span>
                                    <div class="browse-btns">
                                        <a href="javascript:void(0)" class="btn disabled select-node-btn" onclick="confirmSelection();">Select</a>
                                        <a class="btn close-modal" onclick="closeTreeBox()">Cancel</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder runat="server" ID="PhBrowseTemplates">
                        <div class="modal browse-modal templates">
                            <div class="select-box left">
                                <input class="field-search" type="text" placeholder="search" onkeyup="browseSearch($(this))"/>
                                <a class="clear-search" href="javascript:void(0)" onclick="clearSearch($(this))">X</a>
                                <asp:Literal runat="server" ID="litBrowseTemplates"></asp:Literal>
                            </div>
                            <div class="arrows">
                                <a class="btn" onclick="addTemplate()">&raquo;</a>
                                <a class="btn" onclick="removeTemplate()">&laquo;</a>
                            </div>
                            <div class="selected-box">
                                <span class="temp-selected"></span>
                                <span class="temp-selected-remove"></span>
                                <ul class="selected-box-list">
                                </ul>
                                <div class="browse-btns">
                                    <a href="javascript:void" class="btn clear-selections" onclick="clearModalSelections();">Clear</a>
                                    <a href="javascript:void(0)" class="btn disabled select-node-btn" onclick="confirmTemplateSelection();">Select</a>
                                    <a class="btn close-modal" onclick="closeTemplatesModal()">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder runat="server" ID="PhBrowseFields">
                        <div class="modal browse-modal fields">
                            <div class="select-box left">
                                <input class="field-search" type="text" placeholder="search" onkeyup="browseSearch($(this))"/>
                                <a class="clear-search" href="javascript:void(0)" onclick="clearSearch($(this))">X</a>
                                <asp:Literal runat="server" ID="litBrowseFields"></asp:Literal>
                            </div>
                            <div class="arrows">
                                <a class="btn" onclick="addTemplate()">&raquo;</a>
                                <a class="btn" onclick="removeTemplate()">&laquo;</a>
                            </div>
                            <div class="selected-box">
                                <span class="temp-selected"></span>
                                <span class="temp-selected-remove"></span>
                                <ul class="selected-box-list">
                                </ul>
                                <div class="browse-btns">
                                    <a href="javascript:void" class="btn clear-selections" onclick="clearModalSelections();">Clear</a>
                                    <a href="javascript:void(0)" class="btn disabled select-node-btn" onclick="confirmFieldSelection();">Select</a>
                                    <a class="btn close-modal" onclick="closeFieldModal()">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>

                    <span class="header">Database</span>
                    <asp:DropDownList runat="server" ID="ddDatabase" CssClass="ddDatabase" /><input runat="server" class="txtCustomDatabase" id="txtCustomDatabase" style="display: none" />
                    <br />
                    <span class="notes">Select database. Defaults to web</span><br />
                    <br />

                    <asp:CheckBox runat="server" ID="chkIncludeIds" /><span class="header">Include IDs</span><br />
                    <span class="notes">Check this box to include item IDs (guid) in the exported file. Item paths are already included.</span><br />
                    <br />

                    <span class="header">Start Item</span><a class="clear-btn" data-id="inputStartitem">clear</a><br />
                    <span class="notes">Enter the path or ID of the starting node, or use Browse* to select.<br/> Only content beneath and including this node will be exported. If field is left blank, the starting node will be /sitecore/content.<br/>*Browse might take a while to load</span><br />
                    
                    <input runat="server" id="inputStartitem" /><asp:Button runat="server" ID="btnBrowse" OnClick="btnBrowse_OnClick" CssClass="browse-btn" Text="Browse" />
                    <br />
                    <span>OR</span><br />
                    <span class="header">Fast Query</span><a class="clear-btn" id="clear-fast-query" data-id="txtFastQuery">clear</a><br />
                    <span class="notes">Enter a fast query to run a filtered export. You can use the Templates box as well.<br />
                        Example: fast:/sitecore/content/Home//*[@__Updated >= '20140610' and @__Updated <'20140611']</span><br />
                    <input runat="server" id="txtFastQuery" />
                    <asp:Button runat="server" ID="btnTestFastQuery" OnClick="btnTestFastQuery_OnClick" Text="Test" />
                    <span class="lit-fast-query">
                        <asp:Literal runat="server" ID="litFastQueryTest"></asp:Literal></span>
                    <br />
                    <br />

                    <span class="header">Templates</span><a class="clear-btn" data-id="inputTemplates">clear</a><br />
                    <span class="notes">Enter template names and/or IDs separated by commas, or use Browse to select. <br/>Items will only be exported if their template is in this list. If this field is left blank, all templates will be included.</span><br />
                    <textarea runat="server" id="inputTemplates" cols="60" row="5"></textarea><asp:Button runat="server" ID="btnBrowseTemplates" OnClick="btnBrowseTemplates_OnClick" CssClass="browse-btn" Text="Browse" />
                    <br />

                    <div class="hints">
                        <a class="show-hints">Hints</a>
                        <span class="notes">Example: Standard Page, {12345678-901-2345-6789-012345678901}
                        </span>
                    </div>
                    <asp:CheckBox runat="server" ID="chkIncludeTemplate" />
                    <span class="header">Include Template Name</span><br />
                    <span class="notes">Check this box to include the template name with each item</span><br />
                    <br />


                    <span class="header">Fields</span><a class="clear-btn" data-id="inputFields">clear</a><br />
                    <span class="notes">Enter field names or IDs separated by commas, or use Browse to select fields.</span><br />
                    <textarea runat="server" id="inputFields" cols="60" row="5"></textarea><asp:Button runat="server" ID="btnBrowseFields" OnClick="btnBrowseFields_OnClick" CssClass="browse-btn" Text="Browse" />
                    <br />
                    <br />




                    <div class="advanced">
                        <a class="advanced-btn">Advanced Options</a>
                        <div class="advanced-inner">

                            <asp:CheckBox runat="server" ID="chkIncludeLinkedIds" /><span class="header">Include linked item IDs </span><span class="notes">(images, links, droplists, multilists)</span><br />
                            <asp:CheckBox runat="server" ID="chkIncludeRawHtml" /><span class="header">Include raw HTML </span><span class="notes">(images and links)</span><br />

                            <asp:CheckBox runat="server" CssClass="workflowBox" ID="chkWorkflowName" /><span class="header">Workflow</span><br />
                            <asp:CheckBox runat="server" CssClass="workflowBox" ID="chkWorkflowState" /><span class="header">Workflow State</span>
                            <br />
                            <span class="notes">Workflow options require the database to be set to master</span>
                            <br />
                            <br />

                            <asp:CheckBox runat="server" ID="chkAllLanguages" /><span class="header">Get All Language Versions</span><br />
                            <span class="notes">This will get the selected field values for all languages that each item has an existing version for</span>
                            <br />
                            <br />

                            <asp:Button runat="server" ID="btnRunExportDupe" OnClick="btnRunExport_OnClick" Text="Run Export" /><br />
                            <br />
                        </div>
                    </div>
                    <br />

                </div>


            </div>

        </div>
    </form>
</body>
</html>
