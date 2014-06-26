Content-Type: multipart/mixed; boundary="===============5132770932104997751=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: Re: [PATCH 3/6] plugins: new driver for u-blox SARA-U270 modems
Date: Thu, 26 Jun 2014 16:49:34 +0200
Message-ID: <20140626144934.GT33006@rincewind.trouble.is>
In-Reply-To: <53AC2E5F.4010100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5132770932104997751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2014-06-26 09:29:51 (-0500), Denis Kenzior <denkenz@gmail.com> wrote:
> > +static void ublox_remove(struct ofono_modem *modem)
> > +{
> > +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> > +
> > +	DBG("%p", modem);
> > +
> > +	ofono_modem_set_data(modem, NULL);
> > +	g_at_chat_unref(data->aux);
> =

> Any reason data->modem is not being unrefed? e.g in the case of hot-unplu=
g?

As far as I can tell, disable is always called before remove.  In the
hot-unplug case, ofonod -d output goes:

ofonod[680]: src/gprs.c:gprs_remove() atom: 0x1443220
ofonod[680]: src/sim.c:sim_remove() atom: 0x1442fb0
ofonod[680]: src/modem.c:devinfo_remove() atom: 0x14425a0
ofonod[680]: plugins/ublox.c:ublox_disable() 0x143ba00
ofonod[680]: plugins/ublox.c:ublox_remove() 0x143ba00
ofonod[680]: src/modem.c:unregister_property() property 0x143bb00
ofonod[680]: src/modem.c:unregister_property() property 0x14448e0

Am I missing something?

> > +static int ublox_enable(struct ofono_modem *modem)
> > +   [...]
> > +	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL, cfun_enable,
> > +					modem, NULL);
> =

> Prefix should probably be used.  Also, should this be CFUN=3D4 and not 1?
>  enable() callback should be putting the modem in the SIM powered, RX/TX
> off mode (e.g. Offline).

Good point.  I'll fix that in the quectel driver too.

> > +static int ublox_disable(struct ofono_modem *modem)
> > +{
> > +   [...]
> > +	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
> > +					cfun_disable, modem, NULL);
> =

> This modem doesn't jump off the bus on CFUN=3D0, right?

Nope.  It stays on the bus with the radio off.

Thanks for the review!

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============5132770932104997751==--

