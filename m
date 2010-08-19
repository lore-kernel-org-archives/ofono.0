Content-Type: multipart/mixed; boundary="===============0660019313615687407=="
MIME-Version: 1.0
From: Arun.Ravindran@elektrobit.com
Subject: RE: Gatmux doubt and suggestion
Date: Thu, 19 Aug 2010 16:22:22 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA8029A7EC3@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1282216923.23399.180.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0660019313615687407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Marcel,

> > In mux_query_cb(), the frame size is taken as default (31 or 64). We

> > have a case where the default values are not accepted by the modem.
> > =

> > Gatmux is a generic component, and so makes all modem to use the =

> > default values, one needs to modify the gatmux to enable for =

> > example, a larger frame size.
> > =

> > Why not let the modem plug-in parse the CMUX query and decide on a =

> > suitable configuration for enabling MUX?
> > =

> > What is your opinion?
> =

> > patches are welcome.
> > However you do know that the GAtMux has setup functions for basic =

> > and
> advanced mode. So you could parse AT+CMUX all by yourself in the modem

> plugin.
> > GAtMux *g_at_mux_new_gsm0710_basic(GIOChannel *channel, int
> framesize); GAtMux *g_at_mux_new_gsm0710_advanced(GIOChannel *channel,

> int framesize);
> > There is no requirement to actually use g_at_mux_setup_gsm0710(), =

> > but
> it is a lot more convenient.
> =

> I am thinking of a solution, where the modem plugin passes a call back

> function pointer to g_at_mux_setup_gsm0710(). mux_query_cb() can call =

> this call back function during processing of CMUX=3D? Response. This =

> call back function will be a member of struct mux_setup_data. This way

> the modem plugins can have the freedom to set the CMUX parameters if =

> they wish to do so. If the call back is NULL the default values are =

> applied as now.
> =

> But this involves patches in the existing plugins (calypso etc) and =

> Gatmux, but gives options to plugins (their of values or default =

> values).

> changing modem plugins is not a problem at.

> However if you make an extra callback to parse the AT+CMUX=3D? result
and then send force it to send the AT+CMUX command by itself, then this
makes no sense. It is as > complicated as doing it manually in the first
place.

> If you wanna modify setup_gsm0710() to always pick the largest
available framesize instead of default, then yes, that sounds
reasonable. For your proposed solution I prefer > you just use the
manual setup. If you try it you will see that there is no difference.
You just replace one function call to setup_gsm0710() with a call to >
g_at_chat_send().

It is not only framesize, it can also be for other parameters, where the
default values seem insufficient. I can see that the existing plugins
are not using those, but need not be true for other modems. Ok now I
understand, writing a plugin specific mux initialization
(xxmodem_mux_setup_gsm0710(...) ) is more clean, and use
g_at_mux_new_gsm0710_basic () g_at_mux_new_gsm0710_advanced()from there.
right? =


Thanks Marcel.

Regards
Arun

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============0660019313615687407==--

