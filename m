Content-Type: multipart/mixed; boundary="===============7149704376422605066=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Huawei EM770W SIM card issues
Date: Thu, 05 Aug 2010 17:54:54 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528E0E433@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C5A6CB6.8020903@mayer-electronics.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7149704376422605066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Florian Mayer (Mayer Electronics) wrote:
> Hello,
> =

> we encountered the following problem with the EM770W: If the
> SIM card is
> plugged in after our test system is powered on, it is not
> recognised in
> ofono. Even if we restart ofonod after plugging in the SIM
> card. We use
> the 2.6.35~rc5 kernel from Meego 1.1 trunk because we encountered
> problems in the option driver with Kernel 2.6.33.3 (the communication
> got stuck from time to time). For ofono we use the latest 0.26 and
> for connman 0.55. =

> =

> Is this a bug relted to ofono or a limitation of the Huawei hardware?

I watch oFono chat with EM770W modem. If I restart ofonod after plugging
in the SIM card. We have:

ofonod[7871]: Pcui:< \r\n^SYSINFO:1,0,1,5,255,,4\r\n\r\nOK\r\n
ofonod[7871]: Pcui:> AT+CGMI\r
ofonod[7871]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
ofonod[7871]: Pcui:> AT+CGMM\r
ofonod[7871]: Pcui:< \r\nEM770W\r\n\r\nOK\r\n
ofonod[7871]: Pcui:> AT+CGMR\r
ofonod[7871]: Pcui:< \r\n11.126.08.01.00\r\n\r\nOK\r\n
ofonod[7871]: Pcui:> AT+CGSN\r
ofonod[7871]: Pcui:< \r\n357030020291346\r\n\r\nOK\r\n
ofonod[7871]: Pcui:< \r\n^BOOT:20291346,0,0,0,20\r\n

ofonod[7897]: Pcui:< \r\n^RSSI:15\r\n\r\n^SRVST:1\r\n
ofonod[7897]: Pcui:< \r\n^MODE:5,4\r\n

However, if I powered on modem with SIM card inserted, I have:

ofonod[7960]: Pcui:> AT+CGSN\r
ofonod[7960]: Pcui:< \r\n357030020291346\r\n\r\nOK\r\n
ofonod[7960]: Pcui:< \r\n^RSSI:1\r\n
ofonod[7960]: Pcui:< \r\n^BOOT:20291346,0,0,0,20\r\n
ofonod[7960]: Pcui:< \r\n^MODE:3,3\r\n\r\n^SIMST:1\r\n
ofonod[7960]: Pcui:> AT+CRSM=3D176,28590,0,0,1\r
ofonod[7960]: Pcui:< \r\n^SRVST:2\r\n\r\n^MODE:3,3\r\n
ofonod[7960]: Pcui:< \r\n+CRSM: 144,0,"03"\r\n\r\nOK\r\n
ofonod[7960]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,=
 1
ofonod[7960]: Pcui:> AT+CPIN?\r
ofonod[7960]: Pcui:< \r\n+CPIN: READY\r\n\r\nOK\r\n
ofonod[7960]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY

So looks like Huawei modem doesn't send us ^SIMST unsolicited
notification in the first case.

> Regards
> Florian Mayer
> Mayer Electronics
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua


--===============7149704376422605066==--

