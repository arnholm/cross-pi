/***************************************************************
 * Name:      cross_pi_gui_sampleMain.h
 * Purpose:   Defines Application Frame
 * Author:    Carsten Arnholm ()
 * Created:   2013-08-31
 * Copyright: Carsten Arnholm ()
 * License:
 **************************************************************/

#ifndef cross_pi_gui_sampleMAIN_H
#define cross_pi_gui_sampleMAIN_H

//(*Headers(cross_pi_gui_sampleDialog)
#include <wx/button.h>
#include <wx/dialog.h>
#include <wx/sizer.h>
#include <wx/statline.h>
#include <wx/stattext.h>
//*)

class cross_pi_gui_sampleDialog: public wxDialog
{
    public:

        cross_pi_gui_sampleDialog(wxWindow* parent,wxWindowID id = -1);
        virtual ~cross_pi_gui_sampleDialog();

    private:

        //(*Handlers(cross_pi_gui_sampleDialog)
        void OnQuit(wxCommandEvent& event);
        void OnAbout(wxCommandEvent& event);
        //*)

        //(*Identifiers(cross_pi_gui_sampleDialog)
        static const long ID_STATICTEXT1;
        static const long ID_BUTTON1;
        static const long ID_STATICLINE1;
        static const long ID_BUTTON2;
        //*)

        //(*Declarations(cross_pi_gui_sampleDialog)
        wxBoxSizer* BoxSizer1;
        wxBoxSizer* BoxSizer2;
        wxButton* Button1;
        wxButton* Button2;
        wxStaticLine* StaticLine1;
        wxStaticText* StaticText1;
        //*)

        DECLARE_EVENT_TABLE()
};

#endif // cross_pi_gui_sampleMAIN_H
