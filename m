Content-Type: multipart/mixed; boundary="===============4774062743362330402=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH] stkutil: fix crash issue cause by null length of text
 string
Date: Wed, 08 Dec 2010 08:37:19 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136D95D4B@irsmsx501.ger.corp.intel.com>
In-Reply-To: <AANLkTikwmCamhNXwtZyRhqMp94gx-2zzQnB7M+xrR07=@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4774062743362330402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

> =

> On 7 December 2010 22:55,  <Jeevaka.Badrappan@elektrobit.com> wrote:
> > Hi Guillaume,
> >
> >>
> >> According to 3GPP TS 31.124 a null length for the text string
> >> should be allowed. An empty string must be returned to the
> >> user in this case.
> >> ---
> >> =C2=A0src/stkutil.c | =C2=A0 =C2=A06 ++++--
> >> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >
> > Agree. As per the 3GPP TS 31.124 null text string will be indicated
> with
> > length 0.
> > So, in first place if (text =3D=3D NULL) check in
> handle_command_get_input,
> > handle_command_get_inkey has to be removed. Removing this check will
> > result
> > in crash due to the fact that we are not handling this case properly
> > neither
> > in parse_dataobj_text nor in corresponding stkagent functions.
> >
> > There are 2ways to solve this issue:
> >
> > First option - Fix provided in the function parse_dataobj_text( e.g.
> > *text =3D "")
> > Second option - In all the stk_agent_ function which has this text
> > string we
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0need to check fo=
r NULL and assign it to empty string
> if
> > it is NULL.
> >
> > First option seems to be right and also better one.
> =


Agree. It's why I've did this one :)
I'll be more explicit in the description for my future patches. Especially =
for crash issue.

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

--===============4774062743362330402==--

