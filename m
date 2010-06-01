Content-Type: multipart/mixed; boundary="===============3213547066209516053=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono with Sagem Hilo GPRS
Date: Tue, 01 Jun 2010 14:11:48 -0500
Message-ID: <201006011411.49380.denkenz@gmail.com>
In-Reply-To: <323786.70841.qm@web23307.mail.ird.yahoo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3213547066209516053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yoann,

<snip>

> ofonod[3221]: src/modem.c:get_modem_property() modem 0x8142058 property
>  status-poll-interval ofonod[3221]: > AT+CSIM=3D8,A0F200C0\r
> ofonod[3221]: < AT+CSIM=3D8,A0F200C0\r\r\n+CME ERROR: 3\r\n
> =


The culprit was sim polling which performs CSIM pdus to detect a dead SIM.  =

Your modem doesn't seem to support CSIM command, so returns an error and oF=
ono =

foolishly thinks the SIM has been removed.  For now I disabled this in the =

atgen plugin, but the proper solution is for you to write a Sagem Hilo driv=
er.

If you still have problems, let us know.

Regards,
-Denis

--===============3213547066209516053==--

