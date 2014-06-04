Content-Type: multipart/mixed; boundary="===============0195382543764337189=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Multiplexer PH8 Cinterion modem
Date: Wed, 04 Jun 2014 09:30:44 -0500
Message-ID: <538F2D94.7010009@gmail.com>
In-Reply-To: <3921A44ACDC6C642B0BF6D8E48A862D19C0E86E02E@pdc.office.intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0195382543764337189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 06/04/2014 03:26 AM, Mark vd. Putten wrote:
> I have got a PH8 Cinterion modem.
> =

> gatmux.c        ->      g_at_mux_setup_gsm0710
> Queries the modem for available multiplex modes
> The modem only returns a list with mode 0
> =

> ofonod[7120]: Setup: > AT+CMUX=3D?\r
> ofonod[7120]: Setup: < \r\n+CMUX: (0)\r\n\r\nOK\r\n
> =

> This is not correctly handles by
> gatmux.c        ->      mux_query_cb
> =

> It expects another subset
> 798     /* Subset */
> 799     if (!g_at_result_iter_open_list(&iter))
> 800             goto error;
> =

> Multiplex port is on USB and therefore has no requirements on speed.

subset parameter is not about speed.  It has been a while, but I believe
we only support UIH framing mode, hence why that code checks for subset=3D0.

> =

> What would be the best solution in changing this?
> Hack the gatmux.c?
> =


In general GAtMux tries to make the most intelligent choice based on the
standard CMUX syntax (per 27.007).  In cases where a modem does
something different and this logic breaks down, one can always setup the
MUX manually.  Refer to plugins/ifx.c and plugins/sim900.c for examples.

Regards,
-Denis

--===============0195382543764337189==--

