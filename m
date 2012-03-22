Content-Type: multipart/mixed; boundary="===============4125178039648266643=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] sim: Use quoted string with AT+CRSM data parameter
Date: Thu, 22 Mar 2012 08:58:36 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18A82838@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <1332350294.1870.26.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4125178039648266643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > Fix issue with some modems preventing to update elementary files
> > (speedup, ZTE, huawei, MBM)
> > ---
> >  drivers/atmodem/sim.c |   52
> ++++++++++++++++++++++++++++++++++++++++++------
> >  1 files changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c index
> > 8ee9822..f307708 100644
> > --- a/drivers/atmodem/sim.c
> > +++ b/drivers/atmodem/sim.c
> > @@ -305,18 +305,38 @@ static void at_sim_update_binary(struct
> > ofono_sim *sim, int fileid,  {
> >  	struct sim_data *sd =3D ofono_sim_get_data(sim);
> >  	struct cb_data *cbd =3D cb_data_new(cb, data);
> > -	char *buf =3D g_try_new(char, 36 + length * 2);
> > +	char *buf;
> >  	int len, ret;
> > +	int size =3D 36 + length * 2;
> >
> > +	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
> > +			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
> > +			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
> > +			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
> > +		size +=3D 2; /*Add quotes*/
> =

> this is better done with a switch statement. And please fix the comment s=
tyle to
> adhere to the coding style.
> =

> > +
> > +	buf =3D g_try_new(char, size);
> >  	if (buf =3D=3D NULL)
> >  		goto error;
> >
> >  	len =3D sprintf(buf, "AT+CRSM=3D214,%i,%i,%i,%i,", fileid,
> >  			start >> 8, start & 0xff, length);
> >
> > +	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
> > +			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
> > +			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
> > +			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
> > +		sprintf(buf + len, "\"");
> > +
> =

> I am getting a little bit worried about spreading sd->vendor checks at ma=
ny
> places here. Maybe this can be done smarter and cleaner.

Maybe you can always add the 2 bytes for the memory allocation, whatever th=
e modem is. The cost is not so high, and the memory is freed at the end of =
the function.

And then, you can create a small function that 'append' the hex value. So t=
he modem check would be only in this function, instead of being in at_sim_u=
pdate_binary, at_sim_update_binary and at_sim_update_cyclic.

Doing this, you will have 2 modem checks instead of 9.

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


--===============4125178039648266643==--

