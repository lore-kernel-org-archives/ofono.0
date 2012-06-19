Content-Type: multipart/mixed; boundary="===============4346722836678759098=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS re-connect problem
Date: Tue, 19 Jun 2012 03:30:07 -0500
Message-ID: <4FE0388F.4060203@gmail.com>
In-Reply-To: <4FE2FCC5.3010008@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4346722836678759098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi August,

On 06/21/2012 05:51 AM, August Mayer wrote:
> Hello,
>
> When connecting again to GPRS / PPP, after an Internet connection has
> been closed previously, the connection seems to fail. It looks like the
> ofono_modem serial data channel is completely closed when a PPP
> connection is shut down. I'm using a Telit Modem, which provides several
> serial ports, and am right now using separate serials for the AT chat
> and the data/PPP; for this reason, the AT chat continues working, but
> the data channel is dead.
>

Something similar was happening on Qualcomm based modems from Huawei, =

ZTE, etc.  The modem was sending a HUP on the PPP channel after PPP link =

was dropped.  I believe the preferred solution was to send AT&C0 when =

initializing that port.

> My question is, is it somehow necessary to re-initialise the modem data
> serial channel after a PPP connection? Or could there be a conceptual
> problem that I have overlooked?
>

This can be possible as well.  See commit =

7ed56d6844f8131cbf981e482b7bded8b20db7ab for another possible solution =

(prior to &C0) that can be used as well.

Regards,
-Denis

--===============4346722836678759098==--

