Content-Type: multipart/mixed; boundary="===============7412128589016774748=="
MIME-Version: 1.0
From: Daniele Palmas <Daniele.Palmas@telit.com>
Subject: Unable to use DataConnectionManager
Date: Tue, 18 May 2010 16:06:19 +0200
Message-ID: <24A9345B397CD24AA76A4E82E2379565317D9CFEBE@XCHTS.tmt.telital.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7412128589016774748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to make Ofono work with Telit modules using the atmodem driver. =
I succeeded in using all the features but the DataConnectionManager.

When I list the interfaces of the modem org.ofono.DataConnectionManager is =
missing. Using debug print I put, it seems that the probe function for the =
gprs interface is never called.

Is there something I should enable for using gprs capabilities?

Thanks,
Daniele
--===============7412128589016774748==--

