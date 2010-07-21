Content-Type: multipart/mixed; boundary="===============8438489717385595754=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Huawei E176 - not online
Date: Wed, 21 Jul 2010 10:56:28 +0200
Message-ID: <4C46B63C.3060704@canonical.com>
In-Reply-To: <20100718110441.GA20371@h02.hostsharing.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8438489717385595754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/18/2010 01:04 PM, Florian Steinel wrote:
> Hi,
>    =

Hi Florian,
> I can't get my Huawei E176 USB Stick into the online state.
>    =

I'm travelling and I don't have access to my Huawei E1552 right now. But =

I'll test it as soon as I get back home.
> Maybe commit cc6a43c477c1310643279139ba6808799a8c637e removed to much cod=
e?
> (rssi_notify)
>    =

Commit 6a480bb861f9a83c46368a2ee50a23f062edc207 added the same code to =

atmodem/network-registration.c, I doubt that's the cause here.
> ofonod[15261]: oFono version 0.25
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,2,0,25\r\n
> ofonod[15261]: Pcui:>  ATE0\r
> ofonod[15261]: Pcui:<  \r\n^RSSI:99\r\n\r\n^SRVST:0\r\n\r\n^MODE:0,0\r\n\=
r\n^RSSI:10\r\n\r\n^SRVST:1\r\n\r\n^MODE:5,4\r\n\r\n^BOOT:********,0,0,0,25=
\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:>  AT+CFUN=3D1\r
> ofonod[15261]: Pcui:<  \r\nOK\r\n
> ofonod[15261]: Pcui:>  AT^SYSINFO\r
> ofonod[15261]: Pcui:<  \r\n^SYSINFO:1,0,1,5,0,,4\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:>  AT+CGMI\r
> ofonod[15261]: Pcui:<  \r\nhuawei\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:>  AT+CGMM\r
> ofonod[15261]: Pcui:<  \r\nE176\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:>  AT+CGMR\r
> ofonod[15261]: Pcui:<  \r\n11.104.14.01.55\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:>  AT+CGSN\r
> ofonod[15261]: Pcui:<  \r\n***************\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:<  \r\n^BOOT:********,0,0,0,25\r\n
>    =

SIM doesn't seem to be ready. I would expect to see ^SIMST messages in =

the log to notify when the SIM is ready, but for some reason there =

aren't any.

Do you know what was the last commit when your modem worked? You could =

also try to bisect it, it's really easy with git.

Kalle

--===============8438489717385595754==--

