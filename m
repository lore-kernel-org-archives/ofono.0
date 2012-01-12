Content-Type: multipart/mixed; boundary="===============3593465170484418430=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Thu, 12 Jan 2012 05:08:13 +0100
Message-ID: <4F0E5CAD.5070703@eclis.ch>
In-Reply-To: <1326175413.6454.185.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3593465170484418430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Thanks for your valuable response. Here is an update of the situation.

>> The modem is connected by the USB and report: vendor=3D0x05c6
>> product=3D0x9000. This seem to indicate that it use a Qualcomm chip. It
>> expose 5 serial interfaces, where the 2 and 3 (starting from 0) are for
>> the AT commands. Since the "atgen" driver is no more, I tested it with
>> the "g1" driver. It was only a guess and I would like to know if an
>> other driver is a better choice.
>
> you really want to have a custom modem plugin for this chip. It is
> pretty easy to develop this. Modem plugins are dirt simple to write and
> that is intentional of course :)
>
> I think there was some kind of SIMCOM patch (or similar enough) posted
> on the mailing list some weeks ago.

It's a mystery for me if Simcom do there own software or only use the =

Qualcamm one. The chipset of this modem is the QSC6270 and I expected =

that ofono already have something appropriate. I suspect the "g1" driver =

to be a close match and if fact it work already quite well. Are you =

willing to accept a new modem plugin that is basically a copy of the "g1" ?

The "sim900" patch is still not accepted and, I as far as I understand, =

it don't handle as many feature as the "g1" in the post_sim(). I don't =

known yet if the two products are close enough to be handled by the same =

driver. I have asked Simcom about this question an I hope that there =

will give some indication.

> With USB as transport you really wanna do modem detection via udev. So
> you might wanna get this solved with uclibc.

After some additional work I was getting udev working on the target. But =

understanding how the udev ofono rules should be written for a composite =

device is really hard. I did not found an example on how this should be =

done to set both OFONO_DRIVER _and_ OFONO_LABEL. I was also confused by =

the fact that there is two plugins that handles the udev events: udev =

and udevng.

I finally gave up and used the patch below, without any udev rule. ( I =

use the "g1" driver for now, but I understand that I need to change that =

later. )

diff -ruN ofono/a/plugins/udevng.c ofono/b/plugins/udevng.c
--- ofono/a/plugins/udevng.c	2012-01-07 05:21:37.000000000 +0100
+++ ofono/b/plugins/udevng.c	2012-01-12 01:10:39.000000000 +0100
@@ -595,6 +595,36 @@
  	return TRUE;
  }

+static gboolean setup_g1(struct modem_info *modem)
+{
+	const char *device =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s", info->devnode, info->interface,
+						info->number, info->label);
+
+		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0 &&
+					g_strcmp0(info->number, "03") =3D=3D 0) {
+			device =3D info->devnode;
+			break;
+		}
+	}
+
+	if (device =3D=3D NULL)
+		return FALSE;
+
+	DBG("device=3D%s", device);
+
+	ofono_modem_set_string(modem->modem, "Device", device);
+
+	return TRUE;
+}
+
  static struct {
  	const char *name;
  	gboolean (*setup)(struct modem_info *modem);
@@ -616,6 +646,7 @@
  	{ "telit",	setup_telit	},
  	{ "zte",	setup_zte	},
  	{ "samsung",	setup_samsung	},
+	{ "g1",		setup_g1	},
  	{ }
  };

@@ -808,6 +839,7 @@
  	{ "nokia",	"option",	"0421", "0623"	},
  	{ "samsung",	"option",	"04e8", "6889"	},
  	{ "samsung",	"kalmia"			},
+	{ "g1",		"option",	"05c6", "9000"	},
  	{ }
  };

Should I insist with the udev rules, or something like this (but the =

"g1") is ok ?

> For the backtrace() support, I am pretty disappointed that uclibc does
> not support this. It is a fundamental piece that you especially want in
> embedded system. So this is strange to me.
>
> Instead of us working around it, it might be better to get uclibc fixed
> to support this. On the other hand I am open to look at patches to make
> this optional.

I discovered that the last version of uClibc have now the libubactrace. =

So I updated to it. I can propose this really simple patch to assert the =

presence of the backtrace call:

 From 662640e0afb2eb38d896c2673b3afe4c5a280737 Mon Sep 17 00:00:00 2001
From: Jean-Christian de Rivaz <jc@eclis.ch>
Date: Wed, 11 Jan 2012 11:39:22 +0100
Subject: [PATCH] Add autoconfigure rule to search for backtrace().

Add autoconfigure rule to search for backtrace().
On system with the uClibc, it can be into the libubacktrace.

---
  configure.ac |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4115e34..b07544e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,10 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
  AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
  			AC_MSG_ERROR(dynamic linking loader is required))

+AC_SEARCH_LIBS([backtrace], [execinfo ubacktrace], [], [
+			AC_MSG_ERROR(backtrace support is required)
+])
+
  PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.22, dummy=3Dyes,
  				AC_MSG_ERROR(GLib >=3D 2.22 is required))
  AC_SUBST(GLIB_CFLAGS)
-- =

1.7.6.3

>> ofonod[1346]:>  AT+CLCC\r
>> ofonod[1346]:<  \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
>> ofonod[1346]:>  AT+CLCC\r
>> ofonod[1346]:<  \r\n+CME ERROR: unknown\r\n
>> ofonod[1346]: We are polling CLCC and received an error
>> ofonod[1346]: All bets are off for call management
>> ofonod[1346]:<  \r\nMISSED_CALL: 09:34AM 0786577442\r\n
>> After that Ofono seem to be lost and only able to be terminated.
>
> This looks like the voice call handling via AT+CLCC is really broken on
> this modem. So you have a real problem here.
>
> Do have the AT command specification for this modem? Maybe Simcom has a
> vendor specific command for voice call state handling. And you are
> suppose to use that instead.

Simcom have now provided to me a complete documentation of all the AT =

commands supported by this modem. The AT+CLCC command seem to be ok:

+CLCC:<id1>,<dir>,<stat>,<mode>,<mpty>[,<number>,<type>[,<alpha>]]

I can give more details if needed. The +CME ERROR: <err> is listed as a =

possible response of the command. I noticed that the error raise when =

the a call change his state (typically a hangup) at the same time that =

the AT+CLCC is processing. The AT+CLCC command after the call state =

change returns a valid result. Here is an example:

ofonod[28737]: > AT+CLCC\r
ofonod[28737]: < \r\n+CLCC: 1,1,4,0,0,"0786577442",129\r\n\r\nOK\r\n
ofonod[28737]: > AT+CHUP\r
ofonod[28737]: < \r\nOK\r\n
ofonod[28737]: > AT+CLCC\r
ofonod[28737]: < \r\n+CME ERROR: unknown\r\n
ofonod[28737]: We are polling CLCC and received an error
ofonod[28737]: All bets are off for call management
ofonod[28737]: < \r\nMISSED_CALL: 04:11AM 0786577442\r\n
ofonod[28737]: > AT+CLCC\r
ofonod[28737]: < \r\nOK\r\n

Look like a -EINTR on UNIX that require to make a new invocation. Maybe =

we should ignore this error for this modem in this particular case. I =

have contacted the Simcom support to ask why this modem can return a =

"+CME ERROR: unknown" to the AT+CLCC and how we should handle this.

Regards,

Jean-Christian

--===============3593465170484418430==--

