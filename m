Content-Type: multipart/mixed; boundary="===============0310714717276067972=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] atmodem: Add use of pin event *EPEV after sending PUK.
Date: Tue, 02 Nov 2010 16:28:40 +0100
Message-ID: <1288711720.3322.177.camel@aeonflux>
In-Reply-To: <4CD02D20.5090502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0310714717276067972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> The MBM/STE modems send the unsolicited result code *EPEV to report wh=
en =

> >> the PIN code has been inserted and accepted.
> > =

> > I almost thought so, but I was not sure when adapting this for IFX.
> > =

> >> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> >> index 94658f2..3abd1d8 100644
> >> --- a/drivers/atmodem/sim.c
> >> +++ b/drivers/atmodem/sim.c
> >> @@ -671,6 +671,16 @@ static void at_pin_send_puk_cb(gboolean ok, GAtRe=
sult *result,
> >>  							at_xsim_notify,
> >>  							FALSE, cbd, g_free);
> >>  		return;
> >> +	case OFONO_VENDOR_MBM:
> >> +		/*
> >> +		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
> >> +		 * for a moment after successful AT+CPIN=3D"..", but then
> >> +		 * sends *EPEV when that changes.
> >> +		 */
> >> +		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
> >> +							at_epev_notify,
> >> +							FALSE, cbd, g_free);
> >> +		return;
> >>  	}
> > =

> > Denis, I think we can merge the PIN entering and PUK entering code paths
> > into one. No need to keep them separate.
> > =

> =

> Or refactor the EPEV registration into a separate function.  But either
> is fine with me.

I actually meant combining at_pin_send_puk_cb and at_pin_send_cb into
one function. Since their code should now be identical.

Regards

Marcel



--===============0310714717276067972==--

