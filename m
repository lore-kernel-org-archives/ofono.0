Content-Type: multipart/mixed; boundary="===============0621190471525369322=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono+connman he910
Date: Thu, 12 Mar 2015 11:46:03 -0500
Message-ID: <5501C2CB.6000601@gmail.com>
In-Reply-To: <55015EF1.9070806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0621190471525369322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On 03/12/2015 04:40 AM, Alexey Mednyy wrote:
> Is anybody here successfully using connman+ofono with Telit he910 modem?
>
> Seems like connman using .set_online interface in ofono_modem_driver,
> I've added set_online_ to he910 plugin. And everything works fine.
> Except after set offline/set online sequence I can't activate gprs
> context anymore.

Why? The earlier firmware HE910 did not have a concept of 'Online'. =

CFUN=3D1 triggered full functionality, while CFUN=3D4 disabled the SIM.  So =

for oFono's purposes, CFUN=3D4 was a powered down modem.

If the plugin does not provide .set_online, then oFono core assumes the =

modem only supports Powered =3D False and { Powered =3D True, Online =3D Tr=
ue =

}.  { Powered =3D True, Online =3D False } mode is not possible to achieve.

I have no idea if ConnMan supports this setup.

I believe Telit made CFUN=3D4 only affect the TX/RX circuits in their =

latest firmware, but my information might be a year or two out of date =

and my memory may be faulty :)

> Here is log:
> Jan  9 14:32:51 yarus-ng daemon.info ofonod[138]: Modem: >
> AT+CGDATA=3D"PPP",1\r
> Jan  9 14:32:51 yarus-ng daemon.info ofonod[138]: Modem: <
> AT+CGDATA=3D"PPP",1\r\r\nNO CARRIER\r\n
> Jan  9 14:32:51 yarus-ng daemon.debug ofonod[138]:
> drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
> Jan  9 14:32:51 yarus-ng daemon.info ofonod[138]: Unable to enter data st=
ate
> Jan  9 14:32:51 yarus-ng daemon.debug ofonod[138]:
> src/gprs.c:pri_activate_callback() 0x149318
> Jan  9 14:32:51 yarus-ng daemon.debug ofonod[138]:
> src/gprs.c:pri_activate_callback() Activating context failed with error:
> Unknown error type
> Jan  9 14:32:51 yarus-ng daemon.debug connmand[135]:
> plugins/ofono.c:set_property_reply() /he910_0 path /he910_0/context1
> org.ofono.ConnectionContext.Active
> Jan  9 14:32:51 yarus-ng daemon.err connmand[135]: Failed to change
> property: /he910_0/context1 org.ofono.ConnectionContext.Active:
> org.ofono.Error.Failed Operation failed
>
> AT+CREG? and AT+CGREG? normal answers
> so modem registered in network and gprs context attached AT+CGATT=3D1...
>
> What causes NO CARRIER answer of modem?

No idea.

Regards,
-Denis

--===============0621190471525369322==--

