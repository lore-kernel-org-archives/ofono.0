Content-Type: multipart/mixed; boundary="===============1454662971540968030=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/1] ublox: detect and support LARA R2 series
Date: Fri, 28 Jun 2019 07:59:15 +0200
Message-ID: <a0378722-b005-a710-d319-24788137db04@norrbonn.se>
In-Reply-To: <004701d52813$9faf67a0$df0e36e0$@iwavesystems.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1454662971540968030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

First of all, don't top-post to this mailing list.


On 21/06/2019 11:28, Krishna wrote:
> Hi Jonas,
> =

> Thanks for the patch.
> =

> Withyour patch, ofono is ableto recognize LARA modems.

<snip>

> Setting modem /ublox_0 online...
> =

> root(a)imx:/usr/lib/ofono/test# ./activate-context
> =

> *Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS =

> is not attached***
> =

> Without ofono,I am able to activate the context and get GPRS.With ofono =

> only I am getting belowerror.

If you run ofono as:

OFONO_AT_DEBUG=3D1 ofonod -d -n

then you'll get more info on what AT commands are being sent and which =

ones are failing.  If you could do so and post the log here then we can =

maybe see what's going on.

> =

> Let me know if I am missing any configuration.
> =

> Insourcecode(drivers/ubloxmodem/lte.c), I found AT commands specific to =

> TOBY module for configuring the PDP context(Eg:*****UCGDFLT*).
> =

> Whether any flowneed to be modified for LARA-R2?

Possibly... we'll need to check what the LARA R2 wants there.

/Jonas


--===============1454662971540968030==--

