Content-Type: multipart/mixed; boundary="===============4573655660079172852=="
MIME-Version: 1.0
From: Reinhard Speyerer <rspmn@arcor.de>
Subject: Re: [PATCH 6/8] gprs-context : Force use of atd99
Date: Mon, 18 Feb 2019 17:42:04 +0100
Message-ID: <20190218164204.GA8209@arcor.de>
In-Reply-To: <b1c57503-11b3-4eab-56c8-eb94fa475df8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4573655660079172852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2019 at 09:08:12PM -0600, Denis Kenzior wrote:
> Hi Philippe,
> =

> On 02/15/2019 06:11 AM, philippedeswert(a)gmail.com wrote:
> > From: Philippe De Swert <philippe.deswert@digitalistgroup.com>
> > =

> > QUIRCK: For some reason I really need to force the use of the atd99 com=
mand here.
> > ---
> >   drivers/atmodem/gprs-context.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > =

> > diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-cont=
ext.c
> > index 93894efd..a0776f2a 100644
> > --- a/drivers/atmodem/gprs-context.c
> > +++ b/drivers/atmodem/gprs-context.c
> > @@ -214,7 +214,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
> >   		return;
> >   	}
> > -	if (gcd->use_atd99)
> > +	if (gcd->use_atd99 || gcd->vendor =3D=3D OFONO_VENDOR_UBLOX)
> >   		sprintf(buf, "ATD*99***%u#", gcd->active_context);
> >   	else
> >   		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
> > @@ -457,6 +457,9 @@ static int at_gprs_context_probe(struct ofono_gprs_=
context *gc,
> >   	case OFONO_VENDOR_SIMCOM_SIM900:
> >   		gcd->use_atd99 =3D FALSE;
> >   		break;
> > +	case OFONO_VENDOR_UBLOX:
> > +		gcd->use_atd99 =3D TRUE;
> > +		break;
> =

> So why use both use_atd99 and a vendor quirk above?  Also, you're affecti=
ng
> other uBlox users, so do you want to introduce a different VENDOR quirk
> instead?

Hi Denis,

the effect observed by Philippe is caused by the fact that Qualcomm
firmwares typically do not support the use of AT+CGDATA=3D"PPP",<cid>
for contexts which have already been activated with AT+CGACT although
they respond with +CGDATA: ("PPP") to AT+CGDATA=3D?.

To minimize changes for other uBlox users it might make sense to limit
the use of ATD*99# to Qualcomm-based devices like their SARA R4 series.

Regards,
Reinhard

--===============4573655660079172852==--

