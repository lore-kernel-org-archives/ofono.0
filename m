Content-Type: multipart/mixed; boundary="===============2972749861726993376=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Gatmux doubt and suggestion
Date: Thu, 19 Aug 2010 12:51:27 +0200
Message-ID: <1282215087.23399.169.camel@localhost.localdomain>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A7E46@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2972749861726993376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

> In mux_query_cb(), the frame size is taken as default (31 or 64). We
> have a case where the default values are not accepted by the modem.
> =

> Gatmux is a generic component, and so makes all modem to use the
> default values, one needs to modify the gatmux to enable for example,
> a larger frame size.
> =

> Why not let the modem plug-in parse the CMUX query and decide on a
> suitable configuration for enabling MUX? =

> =

> What is your opinion?

patches are welcome.

However you do know that the GAtMux has setup functions for basic and
advanced mode. So you could parse AT+CMUX all by yourself in the modem
plugin.

GAtMux *g_at_mux_new_gsm0710_basic(GIOChannel *channel, int framesize);
GAtMux *g_at_mux_new_gsm0710_advanced(GIOChannel *channel, int framesize);

There is no requirement to actually use g_at_mux_setup_gsm0710(), but it
is a lot more convenient.

Regards

Marcel



--===============2972749861726993376==--

