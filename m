Content-Type: multipart/mixed; boundary="===============2564860328445484522=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] stk-api.txt: Introduce a new API to display abortable
 information
Date: Wed, 30 Mar 2011 12:05:31 +0200
Message-ID: <1301479531.2572.122.camel@aeonflux>
In-Reply-To: <4D92A151.6050806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2564860328445484522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >  doc/stk-api.txt |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> > index f8a115e..fc69bb9 100644
> > --- a/doc/stk-api.txt
> > +++ b/doc/stk-api.txt
> > @@ -252,6 +252,7 @@ Methods		byte RequestSelection(string title, byte i=
con_id,
> >  			Possible Errors: [service].Error.SimToolkit.EndSession
> >  =

> >  		void DisplayActionInformation(string text, byte icon_id)
> > +						[noreply]
> >  =

> >  			Supplies a text string and/or icon concerning the
> >  			current activity in the terminal and UICC.  The
> > @@ -267,6 +268,16 @@ Methods		byte RequestSelection(string title, byte =
icon_id,
> >  			confirmation message to oFono and then should open
> >  			the launch browser with the given url.
> >  =

> > +		void DisplayAbortableActionInfo(string text, byte icon_id)
> > +
> =

> I've thought some more about this and I think we should name this method
> 'DisplayAction'

then it might be a good idea to rename DisplayActionInformation into
somthing like DisplayInformation to keep them all a bit simpler.

Regards

Marcel



--===============2564860328445484522==--

