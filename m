Content-Type: multipart/mixed; boundary="===============5464245306006893330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Gatmux doubt and suggestion
Date: Thu, 19 Aug 2010 09:27:51 -0500
Message-ID: <4C6D3F67.70507@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A7E46@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5464245306006893330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On 08/19/2010 04:27 AM, Arun.Ravindran(a)elektrobit.com wrote:
> =

> Hi All,
> =

> In mux_query_cb(), the frame size is taken as default (31 or 64). We
> have a case where the default values are not accepted by the modem.
> =

> Gatmux is a generic component, and so makes all modem to use the default
> values, one needs to modify the gatmux to enable for example, a larger
> frame size.
> =

> Why not let the modem plug-in parse the CMUX query and decide on a
> suitable configuration for enabling MUX?
> =

> What is your opinion?

g_at_mux_setup_gsm0710 is really meant for the default cases.  If you
have some particular hardware in mind that requires specific parameters,
then sending the AT+CMUX command directly is a much better idea.

Regards,
-Denis

--===============5464245306006893330==--

