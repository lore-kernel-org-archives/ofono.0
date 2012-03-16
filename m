Content-Type: multipart/mixed; boundary="===============6992347930669497176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Trouble sending sms with cinterion tc65
Date: Fri, 16 Mar 2012 15:20:50 -0500
Message-ID: <4F63A0A2.7020008@gmail.com>
In-Reply-To: <20120316143327.792318b5@bertello>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6992347930669497176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Reynaldo,

> =

> It seems to be registered now, but when sending a sms it fails (+CME
> Error 549), I attach a full log including the failed sms sending.
> =


Error 549 seems to be 'incorrect PDU length'.  Which means this modem
works differently from every single other modem on the market.  Try
quirking the sms atom driver to submit the full length, not just the
tpdu length.

E.g. something like:

if (OFONO_VENDOR_CINTERION)
	        len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", pdu_len);
else
	        len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);

Regards,
-Denis

--===============6992347930669497176==--

