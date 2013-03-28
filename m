Content-Type: multipart/mixed; boundary="===============7546019058809828194=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 28 Mar 2013 09:42:25 -0500
Message-ID: <515456D1.80800@gmail.com>
In-Reply-To: <515453D2.9040404@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7546019058809828194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

> I don't know why ofono call the callback with ok=3D0. In the log, I see
> the command was successful:
>
> ---------------
> Mar 28 13:50:05 mr3000 ofonod[6859]: Data: > AT+CRSM=3D192,28589\r
> Mar 28 13:50:05 mr3000 ofonod[6859]: Data: < \r\n+CRSM:
> 144,0,""\r\n\r\nOK\r\n
> ---------------
>

The above CRSM response is equivalent to: "File not found".

Regards,
-Denis

--===============7546019058809828194==--

