Content-Type: multipart/mixed; boundary="===============5612806923214977009=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: Network information can't be updated dynamically
Date: Wed, 29 Jul 2009 16:28:38 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C4EFB@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5612806923214977009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I take a phone as modem to use ofono and find the network information can't=
 be updated dynamically in ofono: so the network status always is roaming.
Because ofono get the response is roaming status at beginning.
  ofonod[10503]:  Response line: +CREG: 2,5,"188E","00006302"

The network status and signal strength will update dynamically but ofono ca=
n't receive it automatically because modem can't send it regular. or anythi=
ng wrong in my understanding?

Can ofono send the CREG command regular to get the network information look=
 like COPS command?

If we expect application to initialize this request then which interface fo=
r it?
Get properties and properties_changed can't get the updated information so =
far.

Thanks


--===============5612806923214977009==--

