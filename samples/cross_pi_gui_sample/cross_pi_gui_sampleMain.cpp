/***************************************************************
 * Name:      cross_pi_gui_sampleMain.cpp
 * Purpose:   Code for Application Frame
 * Author:    Carsten Arnholm ()
 * Created:   2013-08-31
 * Copyright: Carsten Arnholm ()
 * License:
 **************************************************************/

#include "cross_pi_gui_sampleMain.h"
#include <wx/msgdlg.h>

//(*InternalHeaders(cross_pi_gui_sampleDialog)
#include <wx/font.h>
#include <wx/intl.h>
#include <wx/string.h>
//*)

//helper functions
enum wxbuildinfoformat {
    short_f, long_f };

wxString wxbuildinfo(wxbuildinfoformat format)
{
    wxString wxbuild(wxVERSION_STRING);

    if (format == long_f )
    {
#if defined(__WXMSW__)
        wxbuild << _T("-Windows");
#elif defined(__UNIX__)
        wxbuild << _T("-Linux");
#endif

#if wxUSE_UNICODE
        wxbuild << _T("-Unicode build");
#else
        wxbuild << _T("-ANSI build");
#endif // wxUSE_UNICODE
    }

    return wxbuild;
}

//(*IdInit(cross_pi_gui_sampleDialog)
const long cross_pi_gui_sampleDialog::ID_STATICTEXT1 = wxNewId();
const long cross_pi_gui_sampleDialog::ID_BUTTON1 = wxNewId();
const long cross_pi_gui_sampleDialog::ID_STATICLINE1 = wxNewId();
const long cross_pi_gui_sampleDialog::ID_BUTTON2 = wxNewId();
//*)

BEGIN_EVENT_TABLE(cross_pi_gui_sampleDialog,wxDialog)
    //(*EventTable(cross_pi_gui_sampleDialog)
    //*)
END_EVENT_TABLE()

cross_pi_gui_sampleDialog::cross_pi_gui_sampleDialog(wxWindow* parent,wxWindowID id)
{
    //(*Initialize(cross_pi_gui_sampleDialog)
    Create(parent, id, _("wxWidgets app"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, _T("id"));
    BoxSizer1 = new wxBoxSizer(wxHORIZONTAL);
    StaticText1 = new wxStaticText(this, ID_STATICTEXT1, _("Welcome to wxWidgets\nand  Raspberry PI\n\nThis is a sample cross-pi \nGUI demo application"), wxDefaultPosition, wxDefaultSize, 0, _T("ID_STATICTEXT1"));
    wxFont StaticText1Font(16,wxFONTFAMILY_SWISS,wxFONTSTYLE_NORMAL,wxFONTWEIGHT_NORMAL,false,_T("Noto Sans"),wxFONTENCODING_DEFAULT);
    StaticText1->SetFont(StaticText1Font);
    BoxSizer1->Add(StaticText1, 1, wxALL|wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL, 10);
    BoxSizer2 = new wxBoxSizer(wxVERTICAL);
    Button1 = new wxButton(this, ID_BUTTON1, _("About"), wxDefaultPosition, wxDefaultSize, 0, wxDefaultValidator, _T("ID_BUTTON1"));
    BoxSizer2->Add(Button1, 1, wxALL|wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL, 4);
    StaticLine1 = new wxStaticLine(this, ID_STATICLINE1, wxDefaultPosition, wxSize(10,-1), wxLI_HORIZONTAL, _T("ID_STATICLINE1"));
    BoxSizer2->Add(StaticLine1, 0, wxALL|wxEXPAND, 4);
    Button2 = new wxButton(this, ID_BUTTON2, _("Quit"), wxDefaultPosition, wxDefaultSize, 0, wxDefaultValidator, _T("ID_BUTTON2"));
    BoxSizer2->Add(Button2, 1, wxALL|wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL, 4);
    BoxSizer1->Add(BoxSizer2, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL, 4);
    SetSizer(BoxSizer1);
    BoxSizer1->Fit(this);
    BoxSizer1->SetSizeHints(this);

    Connect(ID_BUTTON1,wxEVT_COMMAND_BUTTON_CLICKED,(wxObjectEventFunction)&cross_pi_gui_sampleDialog::OnAbout);
    Connect(ID_BUTTON2,wxEVT_COMMAND_BUTTON_CLICKED,(wxObjectEventFunction)&cross_pi_gui_sampleDialog::OnQuit);
    //*)
}

cross_pi_gui_sampleDialog::~cross_pi_gui_sampleDialog()
{
    //(*Destroy(cross_pi_gui_sampleDialog)
    //*)
}

void cross_pi_gui_sampleDialog::OnQuit(wxCommandEvent& event)
{
    Close();
}

void cross_pi_gui_sampleDialog::OnAbout(wxCommandEvent& event)
{
    wxString msg = wxbuildinfo(long_f);
    wxMessageBox(msg, _("Welcome to..."));
}
