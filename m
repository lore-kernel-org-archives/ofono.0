Content-Type: multipart/mixed; boundary="===============9100544247889053936=="
MIME-Version: 1.0
From: Predon, Frederic <frederic.predon@intel.com>
Subject: RE: [PATCH v3 2/2] plugins: add ctm create to ifx plugin
Date: Fri, 14 Jan 2011 08:57:08 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934E762131@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1294964100.3873.109.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9100544247889053936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of Marcel Holtmann
> Sent: Friday, January 14, 2011 1:15 AM
> To: ofono(a)ofono.org
> Subject: Re: [PATCH v3 2/2] plugins: add ctm create to ifx plugin
> =

> Hi Jeevaka,
> =

> >  plugins/ifx.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/plugins/ifx.c b/plugins/ifx.c
> > index c0a69c2..08b0001 100644
> > --- a/plugins/ifx.c
> > +++ b/plugins/ifx.c
> > @@ -57,6 +57,7 @@
> >  #include <ofono/radio-settings.h>
> >  #include <ofono/audio-settings.h>
> >  #include <ofono/stk.h>
> > +#include <ofono/ctm.h>
> >  #include <ofono/log.h>
> >
> >  #include <drivers/atmodem/atutil.h>
> > @@ -700,6 +701,7 @@ static void ifx_post_sim(struct ofono_modem
> *modem)
> >
> >  	DBG("%p", modem);
> >
> > +	ofono_ctm_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
> =

> so no emergency calls with CTM are possible? Or do we have to
> potentially also handle that?

Emergency calls with TTY are mandatory in the US so we have to handle that =
as well

Regards

Fred
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


--===============9100544247889053936==--

