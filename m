Content-Type: multipart/mixed; boundary="===============2389705162265715160=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH 1/3] ifx: integration of kernel mux (n_gsm) and its	line
 discipline
Date: Mon, 14 Mar 2011 09:35:51 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813AA0BB06@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1299881083.2055.8.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2389705162265715160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> Hi Guillaume,
> =

> > > > diff --git a/plugins/ifx.c b/plugins/ifx.c
> > > > index 527a8c4..9c2a5c1 100644
> > > > --- a/plugins/ifx.c
> > > > +++ b/plugins/ifx.c
> > > > @@ -26,8 +26,12 @@
> > > >  #include <stdio.h>
> > > >  #include <errno.h>
> > > >  #include <stdlib.h>
> > > > +#include <string.h>
> > > >  #include <sys/stat.h>
> > > >  #include <sys/ioctl.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/gsmmux.h>
> > > > +#include <unistd.h>
> > >
> > > please move unistd.h up since as a rule of thumb, the system headers
> > > should be included before the unix ones.
> > >
> > > Also gsmmux.h is not acceptable. We have to carry a local copy for a
> > > while since otherwise compilation would fail on older kernels.
> >
> > Ok. It's what Robertino did in his first patch for the kernel mux integ=
ration.
> > I've changed that thinking it was better to used the gsmmux.h of the ke=
rnel tree. =

> > I'll redo that.
> >
> > >
> > > Why do you need linux/types.h?
> > >
> >
> > Do not really remember :(
> > I think this is for the gsmmux.h file but if it's the case it to this f=
ile to =

> > include this one. I'll review that.
> =

> in theory if gsmmux.h requires linux/types.h, then it should include
> it.
> =


I've asked the team who handle this file to add this missing include.

> > > >
> > > > +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> > > > +	if (options =3D=3D NULL)
> > > > +		goto error;
> > > > +
> > > > +	g_hash_table_insert(options, "Local", "on");
> > > > +
> > >
> > > Why is this needed?
> >
> > This is needed for PDP context deactivation.
> > If you don't set the local to on a tty close occurs when you do the PDP=
 context deactivation.
> =

> That sounds like a kernel bug to me as well. Why is the kernel closing
> the TTY if you switch back to AT command mode. We are still holding an
> open file descriptor to it.
> =


It's the kernel mux driver that makes a TTY hang-up when the "Local" option=
 is set to OFF.
The TTY hang-up is done because the modem line TIOCM_CD moves from 0 to 1 (=
DV bit of the modem status command set to 1).
It's what I've seen in the code, I'm not enough expert of 27.010 and TTY to=
 be able to say if this correct or not.
Regarding the SPEC the mapping done in the kernel mux between 27.010 contro=
l signals and TTY signals seems correct for me. =


> > > >
> > > >  	/* Enable multiplexer */
> > > > -	data->frame_size =3D 1509;
> > > > +	data->frame_size =3D 1500;
> > > >
> > > > -	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
> > > > +	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1500,10,3,30,,", NULL,
> > > >  					mux_setup_cb, modem, NULL);
> > >
> > > So why did the frame_size changed here? Does the modem firmware chang=
ed
> > > or is this actual a bug in oFono already today?
> > >
> >
> > It's a bug in oFono.
> =

> Then lets get that fixed separately with a proper commit message
> explaining why using frame size of 1500 is correct.
> =

> We need a proper track record of changes and don't intermix them.
> =


I'll do that.

Regards,
Guillaume
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


--===============2389705162265715160==--

