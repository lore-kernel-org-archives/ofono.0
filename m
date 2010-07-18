Content-Type: multipart/mixed; boundary="===============4093371051375722986=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei E176 - not online
Date: Sun, 18 Jul 2010 09:55:57 -0500
Message-ID: <4C4315FD.2030306@gmail.com>
In-Reply-To: <20100718110441.GA20371@h02.hostsharing.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4093371051375722986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

> I can't get my Huawei E176 USB Stick into the online state.
> =


You won't be able to get into Online state unless your SIM is present.
<snip>

> atlog output:

oFono huawei driver determines sim presense in two ways: ^SIMST:1
unsolicited notification, and by querying the ^SYSINFO.
> =

> ofonod[15261]: oFono version 0.25
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,2,0,25\r\n
> ofonod[15261]: Pcui:> ATE0\r
> ofonod[15261]: Pcui:< \r\n^RSSI:99\r\n\r\n^SRVST:0\r\n\r\n^MODE:0,0\r\n\r=
\n^RSSI:10\r\n\r\n^SRVST:1\r\n\r\n^MODE:5,4\r\n\r\n^BOOT:********,0,0,0,25\=
r\n\r\nOK\r\n
> ofonod[15261]: Pcui:> AT+CFUN=3D1\r
> ofonod[15261]: Pcui:< \r\nOK\r\n
> ofonod[15261]: Pcui:> AT^SYSINFO\r
> ofonod[15261]: Pcui:< \r\n^SYSINFO:1,0,1,5,0,,4\r\n\r\nOK\r\n

According to Huawei docs, the 5th field is the SIM presence state.  The
above is telling us it isn't present.

> ofonod[15261]: Pcui:> AT+CGMI\r
> ofonod[15261]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:> AT+CGMM\r
> ofonod[15261]: Pcui:< \r\nE176\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:> AT+CGMR\r
> ofonod[15261]: Pcui:< \r\n11.104.14.01.55\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:> AT+CGSN\r
> ofonod[15261]: Pcui:< \r\n***************\r\n\r\nOK\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
> =


It sounds like your firmware never sends us the SIMST unsolicited
notification.  Can you check whether after sending CFUN=3D1, few seconds
later ^SYSINFO goes to 1?  See plugins/huawei.c for more details.

Regards,
-Denis

--===============4093371051375722986==--

