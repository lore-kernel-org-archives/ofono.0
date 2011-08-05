Content-Type: multipart/mixed; boundary="===============1808406151262198356=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/2] gatppp: save dumpfile into ppp info to start
 recording during open phase.
Date: Fri, 05 Aug 2011 16:48:32 +0100
Message-ID: <568DE01DA537804BA73470071BAC28893905C0C0@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4E3C029F.7000706@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1808406151262198356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> >>>>> @@ -541,6 +542,8 @@ gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO
> *io)
> >>>>>  	if (ppp->hdlc =3D=3D NULL)
> >>>>>  		return FALSE;
> >>>>>
> >>>>> +	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
> >>>>> +
> >>>
> >>> I force the start of the recording in the ppp_open.
> >>>
> >>> Without this change, if we call g_at_ppp_set_record before
> >> g_at_ppp_open, as it's done in gsmdial, it's totaly useless.
> >> g_at_ppp_set_record will call g_at_hdlc_set_recording, and
> >> g_at_hdlc_set_recording will check ppp->hdlc. But ppp->hdlc is set
> in
> >> g_at_ppp_open.
> >>>
> >>
> >> Then at least do this everywhere g_at_hdlc is created...
> >
> > Agreed.
> >
> >>>>>  	ppp->suspended =3D FALSE;
> >>>>>  	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
> >>>>>  	g_at_hdlc_set_suspend_function(ppp->hdlc,
> >>>>> @@ -593,7 +596,11 @@ void g_at_ppp_set_recording(GAtPPP *ppp,
> const
> >>>> char *filename)
> >>>>>  	if (ppp =3D=3D NULL)
> >>>>>  		return;
> >>>>>
> >>>>> -	g_at_hdlc_set_recording(ppp->hdlc, filename);
> >>>>> +	g_free(ppp->dumpfile);
> >>>>> +
> >>>>> +	ppp->dumpfile =3D g_strdup(filename);
> >>>>> +
> >>>>> +	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
> >>>>
> >>>> I'm failing to see the point in making this change.  Why do you
> need
> >> to
> >>>> save the dump filename inside gatppp?
> >>>
> >>> So in the g_at_ppp_set_recording, I store the file. And during the
> >> ppp_open, I start the recording immediately. So with this change, we
> >> cannot miss a PPP frame. Because without the change, if we start the
> >> recording after the ppp_open, we might loose some info.
> >>>
> >>
> >> However, I'm still not convinced we want to pay the price of storing
> >> the
> >> filename.  Setting recording after ppp_open should be fine, all
> GAtHDLC
> >> writes are deferred until the next poll/select fires, which implies
> >> going into the main event loop.  So no data will be lost.
> >
> > Up to you to decide. If you think that we will not lose any frames if
> you do the set_recording just after the open, let's do it this way. I
> agree that it will save some memory, and so it's better.
> >
> =

> Please do it this way:
> =

> g_at_ppp_set_recording:
> 	if (ppp->hdlc =3D=3D NULL)
> 		ppp->recording_filename =3D g_strdup(filename);
> 		return;
> =

> 	g_at_hdlc_set_recording(filename);
> =

> and whenever you open hdlc, free recording_filename and set it to NULL
> after calling g_at_hdlc_set_recording.
> =

> Free in unref as well if for some reason we fail to open/listen to to
> the ppp object.

Good compromise :)

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1808406151262198356==--

