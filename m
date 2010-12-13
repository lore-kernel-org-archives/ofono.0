Content-Type: multipart/mixed; boundary="===============0072466285592627969=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [RFC PATCH] stk: add support of next action for menu
Date: Mon, 13 Dec 2010 09:01:36 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136D96688@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D025C8B.1000707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0072466285592627969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Friday, December 10, 2010 6:00 PM
> To: ofono(a)ofono.org
> Cc: Lucas, GuillaumeX
> Subject: Re: [RFC PATCH] stk: add support of next action for menu
> =

> Hi Guillaume,
> =

> On 12/09/2010 07:00 AM, Lucas, GuillaumeX wrote:
> > From: Guillaume Lucas <guillaumex.lucas@intel.com>
> >
> > According to the 3GPP 31.124 the support of next action
> > in SIM toolkit menus is mandatory.
> > ---
> >  doc/stk-api.txt    |    5 +++--
> >  src/stk.c          |    6 ++++++
> >  src/stkagent.c     |    6 ++++--
> >  src/stkagent.h     |    1 +
> >  test/test-stk-menu |    6 +++---
> >  5 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/doc/stk-api.txt b/doc/stk-api.txt
> > index 79daee6..f5bcae4 100644
> > --- a/doc/stk-api.txt
> > +++ b/doc/stk-api.txt
> > @@ -66,13 +66,14 @@ Properties	string IdleModeText [readonly]
> >  			Contains the identifier of the icon accompanying
> >  			the idle mode text.
> >
> > -		array{struct{string, byte}} MainMenu [readonly]
> > +		array{struct{string, byte, byte}} MainMenu [readonly]
> =

> Can you tell me exactly what this can be used for?  What is the usecase
> for the application to know this information?
> =


The next action is an indicator added for each item of a STK menu. It is to=
 allow the terminal to indicate to the user the consequences of performing =
the selection of an item. I confess that I've never seen use of this option=
 in a real STK application yet.

According to the applicability table (chapter 3.4) of the SATK conformance =
specification (3GPP TS 31.124) the support of the next action indicator is =
mandatory. Chapters 27.22.4.8.3 and 27.22.4.9.2 are the ones relative to th=
e test of this feature.

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


--===============0072466285592627969==--

