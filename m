Content-Type: multipart/mixed; boundary="===============6775090240684490274=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH] test: add a script for STK conformance tests
Date: Mon, 20 Dec 2010 08:40:14 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136EF07A6@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D0B8270.9020003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6775090240684490274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Friday, December 17, 2010 4:32 PM
> To: ofono(a)ofono.org
> Cc: Lucas, GuillaumeX
> Subject: Re: [PATCH] test: add a script for STK conformance tests
> =

> Hi Guillaume,
> =

> On 12/16/2010 10:04 AM, Lucas, GuillaumeX wrote:
> > From: Guillaume Lucas <guillaumex.lucas@intel.com>
> >
> > To be able to run STK conformance tests at ofono
> > level, we need to have a STK agent registered. The
> > test-stk-conformance script provided here do that.
> > This script is for conformance so all the data input
> > of the agent are displayed to be able to check them.
> > The existing test-stk-menu is usable only when there
> > is a STK menu provided by the (U)SIM card.
> > ---
> >  test/test-stk-conformance |  226
> +++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 226 insertions(+), 0 deletions(-)
> >  create mode 100755 test/test-stk-conformance
> >
> =

> I really don't like the amount of code copying going on here.  Have you
> considered extending the current test-stk-menu with the ability to run
> as the 'default' agent instead?  Maybe via a command line option?
> =


You're right, it will be probably better to extend the current stk test scr=
ipt.
I'll review my changes in this way.

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


--===============6775090240684490274==--

