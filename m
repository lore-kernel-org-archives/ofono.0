Content-Type: multipart/mixed; boundary="===============6542740126482907548=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH] stk: Add busy error for the display text command
Date: Tue, 30 Nov 2010 12:38:44 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813547DA58@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4CF4ED29.6010000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6542740126482907548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Tuesday, November 30, 2010 1:25 PM
> To: ofono(a)ofono.org
> Cc: Lucas, GuillaumeX
> Subject: Re: [PATCH] stk: Add busy error for the display text command
> =

> Hi Guillaume,
> =

> >> According to TS 102.223 on Screen Busy we also need to append a
> >> "additional info" field in the Terminal Busy response with a 1-byte
> >> value 01 ("screen is busy").
> >
> > Yes you're right. I've seen this but after sending my patch.
> > I've another patch in my pipe regarding this but in top of the
> current busy patch.
> > I'm waiting the integration of the busy patch to submit it.
> =

> This is not how it works ;)  Please resubmit this patch with the code
> to
> send 'Screen is Busy' additional info included.  You can even submit
> your other pending patches in a series along with this one...
> =

> So e.g.
> =

> patch 1/n -> reworked add busy error...
> patch 2/n -> pending patch 1,
> etc
> =


Ok, I'll resubmmit my patch with all the necessary changes.

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

--===============6542740126482907548==--

