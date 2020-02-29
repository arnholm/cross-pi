/***************************************************************
 * Name:      cross_pi_gui_sampleApp.cpp
 * Purpose:   Code for Application Class
 * Author:    Carsten Arnholm ()
 * Created:   2013-08-31
 * Copyright: Carsten Arnholm ()
 * License:
 **************************************************************/

#include "cross_pi_gui_sampleApp.h"

//(*AppHeaders
#include "cross_pi_gui_sampleMain.h"
#include <wx/image.h>
//*)

IMPLEMENT_APP(cross_pi_gui_sampleApp);

bool cross_pi_gui_sampleApp::OnInit()
{
    //(*AppInitialize
    bool wxsOK = true;
    wxInitAllImageHandlers();
    if ( wxsOK )
    {
    	cross_pi_gui_sampleDialog Dlg(0);
    	SetTopWindow(&Dlg);
    	Dlg.ShowModal();
    	wxsOK = false;
    }
    //*)
    return wxsOK;

}
