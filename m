Content-Type: multipart/mixed; boundary="===============7443187212772716403=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Simcom SIM800 gprs data connection not working
Date: Thu, 16 May 2019 10:39:59 -0500
Message-ID: <cbedc417-1540-937a-357d-e91d56e33661@gmail.com>
In-Reply-To: <1f4ad17d-10d6-a0cf-5b6d-aa1abf12e198@springtech.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7443187212772716403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Riccardo,

> =

> # dbus-send --system --print-reply --dest=3Dorg.ofono /sim900_0/context1 =

> org.ofono.ConnectionContext.SetProperty string:"Active" =

> variant:boolean:true
> Error org.ofono.Error.NotImplemented: Implementation not provided

This basically means that no gprs_context atom has been created by the =

modem driver or the driver initialization has failed.  Briefly looking =

at plugins/sim900.c, I can see that only sim900 (not sim800) supports =

gprs.  Given that you get this far, I assume you hacked this part to =

create gprs/gprs_context...

The other place to look is to see whether the 'atmodem' gprs_context =

driver is working properly.  Perhaps you're missing the TUN/TAP support =

in your kernel?  Run 'sudo modprobe tun' and see if that fixes things.

See drivers/atmodem/gprs-context.c for more details.

Regards,
-Denis

--===============7443187212772716403==--

