Content-Type: multipart/mixed; boundary="===============1583723226289518888=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Network information can't be updated dynamically
Date: Wed, 29 Jul 2009 17:41:48 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C4F33@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1302053C4EFB@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1583723226289518888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

And send the CQS to get the signal value.

Thanks

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of Li,
>Zhigang
>Sent: 2009=E5=B9=B47=E6=9C=8829=E6=97=A5 16:29
>To: ofono(a)ofono.org
>Subject: Network information can't be updated dynamically
>
>Hi,
>I take a phone as modem to use ofono and find the network information can'=
t be
>updated dynamically in ofono: so the network status always is roaming.
>Because ofono get the response is roaming status at beginning.
>  ofonod[10503]:  Response line: +CREG: 2,5,"188E","00006302"
>
>The network status and signal strength will update dynamically but ofono c=
an't
>receive it automatically because modem can't send it regular. or anything =
wrong
>in my understanding?
>
>Can ofono send the CREG command regular to get the network information loo=
k like
>COPS command?
>
>If we expect application to initialize this request then which interface f=
or
>it?
>Get properties and properties_changed can't get the updated information so=
 far.
>
>Thanks
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============1583723226289518888==--

