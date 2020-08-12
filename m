Content-Type: multipart/mixed; boundary="===============7501942536863128677=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v2 3/3] gprs: Quectel EC21 does not understand AT+CPSB
Date: Wed, 12 Aug 2020 11:20:57 +0200
Message-ID: <20200812092057.w2h2oqc476x3cmxi@lem-wkst-02.lemonage>
In-Reply-To: <16f2773a-49c6-4318-8dea-36b1b9ebdd1d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7501942536863128677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 10:55:35AM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> On 8/11/20 6:42 AM, poeschel(a)lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > =

> > The Quectel EC21 modem does not understand the AT+CPSB command, so
> > aquire the current packet switched bearer from CGREG URC.
> > ---
> >   drivers/atmodem/gprs.c | 32 ++++++++++++++++++++++++++++++--
> >   1 file changed, 30 insertions(+), 2 deletions(-)
> > =

> > diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> > index b637f733..5583d6fa 100644
> > --- a/drivers/atmodem/gprs.c
> > +++ b/drivers/atmodem/gprs.c
> > @@ -40,6 +40,7 @@
> >   #include "gatresult.h"
> >   #include "atmodem.h"
> > +#include "common.h"
> >   #include "vendor.h"
> >   #define MAX_CONTEXTS 255
> > @@ -98,6 +99,29 @@ static void list_contexts_data_unref(gpointer user_d=
ata)
> >   	g_free(ld);
> >   }
> > +static int act_to_bearer(int act)
> > +{
> > +	switch (act) {
> > +		case 0:
> > +		case 1:
> > +			return PACKET_BEARER_GPRS;
> > +		case 2:
> > +			return PACKET_BEARER_UMTS;
> > +		case 3:
> > +			return PACKET_BEARER_EGPRS;
> > +		case 4:
> > +			return PACKET_BEARER_HSDPA;
> > +		case 5:
> > +			return PACKET_BEARER_HSUPA;
> > +		case 6:
> > +			return PACKET_BEARER_HSUPA_HSDPA;
> > +		case 7:
> > +			return PACKET_BEARER_EPS;
> > +		default:
> > +			return PACKET_BEARER_NONE;
> > +	}
> > +};
> > +
> =

> oFono driver interface is based on 27.007.  So that means values defined =
in
> 27.007 do not need to be 'converted'.  You can simply feed them in direct=
ly
> if they follow 27.007.

Well, yes. I saw this. But unfortunately at this point what is expected
are the 27.007 values from AT+CPSB defined in 7.29 (that EC21 quectel
modem does not support) and I get the values from AT+CGREG defined in 7.2.

> To me this looks like a no-op.  Is there a non-obvious reason why this co=
de
> is needed?

These are the values defined in 7.2 (CGREG) called access technology
0 - GSM
2 - UTRAN
3 - GSM W/EGPRS
4 - UTRAN W/HSDPA
5 - UTRAN W/HSUPA
6 - UTRAN W/HSDPA and HSUPA
7 - E-UTRAN

and these are the values defined in 7.29 (CPSB / ofono) called current
bearer:

1 - GPRS
2 - EGPRS
3 - Non-HSUPA in uplink and non-HSDPA in downlink.
4 - HSUPA in uplink and non-HSDPA in downlink.
5 - Non-HSUPA in uplink and HSDPA in downlink.
6 - HSUPA in uplink and HSDPA in downlink.
7 - EPS
8 - 5GS

You see ? They are similar but not the same. So I opted for the
conversion function.

> >   static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> >   {
> >   	struct cb_data *cbd =3D user_data;
> > @@ -342,11 +366,11 @@ static void at_gprs_list_active_contexts(struct o=
fono_gprs *gprs,
> >   static void cgreg_notify(GAtResult *result, gpointer user_data)
> >   {
> >   	struct ofono_gprs *gprs =3D user_data;
> > -	int status;
> > +	int status, tech;
> >   	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
> >   	if (at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
> > -				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
> > +				NULL, NULL, &tech, gd->vendor) =3D=3D FALSE)
> >   		return;
> >   	/*
> > @@ -372,6 +396,8 @@ static void cgreg_notify(GAtResult *result, gpointe=
r user_data)
> >   	}
> >   	ofono_gprs_status_notify(gprs, status);
> > +	if (gd->vendor =3D=3D OFONO_VENDOR_QUECTEL_EC2X)
> > +		ofono_gprs_bearer_notify(gprs, act_to_bearer(tech));
> =

> To follow up from above, any reason not to omit act_to_bearer() here?

See above.

> >   }
> >   static void cgev_notify(GAtResult *result, gpointer user_data)
> > @@ -624,6 +650,8 @@ static void gprs_initialized(gboolean ok, GAtResult=
 *result, gpointer user_data)
> >   		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
> >   						NULL, NULL, NULL);
> >   		break;
> > +	case OFONO_VENDOR_QUECTEL_EC2X:
> > +		break;
> >   	default:
> >   		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
> >   						FALSE, gprs, NULL);
> > =


Regards,
Lars
--===============7501942536863128677==--

