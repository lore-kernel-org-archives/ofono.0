Content-Type: multipart/mixed; boundary="===============0313540069936230904=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] speedup: during enable, we have to go offline first.
Date: Thu, 28 Jul 2011 12:59:43 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938FA9A50@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311851936.8920.87.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0313540069936230904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> >  plugins/speedup.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/plugins/speedup.c b/plugins/speedup.c
> > index 90ca5e3..a7aa43c 100644
> > --- a/plugins/speedup.c
> > +++ b/plugins/speedup.c
> > @@ -177,7 +177,7 @@ static int speedup_enable(struct ofono_modem *modem)
> >  	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL,
> NULL);
> >  	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NUL=
L);
> >
> > -	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
> > +	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL,
> >  					cfun_enable, modem, NULL);
> =

> this is not a correct fix. You are messing up the logic here. You are
> still in offline mode from an oFono point of view, but your modem is
> actually online.
> =

> Try the same that we did for ZTE with sending +CFUN=3D1;+CFUN=3D4 if that
> works out.

This is not working:

ofonod[17315]: plugins/speedup.c:speedup_enable() 0x9ae1af8
ofonod[17315]: src/modem.c:get_modem_property() modem 0x9ae1af8 property Mo=
dem
ofonod[17315]: plugins/speedup.c:open_device() Modem /dev/ttyUSB1
ofonod[17315]: src/modem.c:get_modem_property() modem 0x9ae1af8 property Aux
ofonod[17315]: plugins/speedup.c:open_device() Aux /dev/ttyUSB2
ofonod[17315]: Modem: > ATE0 +CMEE=3D1\r
ofonod[17315]: Aux: > ATE0 +CMEE=3D1\r
ofonod[17315]: Aux: < ATE0 +CMEE=3D1\r
ofonod[17315]: Modem: < \r\nOK\r\n
ofonod[17315]: Aux: < \r\nOK\r\n
ofonod[17315]: Aux: > AT+CFUN=3D1;+CFUN=3D4\r
ofonod[17315]: Aux: < \r\n+CME ERROR: 0\r\n
ofonod[17315]: plugins/speedup.c:cfun_enable()


> If not, then check if we can go CFUN=3D1 first and then after SIM query
> succeeded, we go into CFUN=3D4. We do this for Huawei actually.

I will try this...

> If none of these work, then you need to remove the set_online callback
> like we do for Nokia. If you can not support online/offline mode, then
> don't even try to.
> =

> And please show proper OFONO_AT_DEBUG traces. They can be part of the
> commit message actually.
> =


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


--===============0313540069936230904==--

