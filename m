Content-Type: multipart/mixed; boundary="===============8754678806283656934=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: ConnectionContext on Nokia 6760s-1
Date: Tue, 22 Mar 2011 18:57:34 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D40DD@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1300804470.2673.14.camel@claudio-ThinkPad-R61>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8754678806283656934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

> Hi,
> =

> We have tried to attach an Nokia 6760s-1, for using it like 3G modem.
> Ofono manages correctly the mobile phone creating /isiusb0/
> and /isiusb0/context1 and i think it uses the isi modem driver.
> =

> Next we have activated the pdp context, but it returns the following
> dbus exception =

> =

> 	org.ofono.Error.NotAttached GPRS is not attached

This basically means that oFono thinks the modem is not attached to the GPR=
S service. Did you set the modem online before trying this (e.g. by running=
 the online-modem script from the test directory)?

> is it possible to use the nokia phone as 3G modem?

Should be possible, although it may be that the driver needs minor modifica=
tions for 6760. Depends on the ISI interface versions of the modem firmware.

If it won't work, you can set the OFONO_ISI_DEBUG and OFONO_ISI_TRACE envir=
onment variables to get more verbose logging. We'd need the full log output=
 to check what is going wrong.

Br,

	MikaL

--===============8754678806283656934==--

