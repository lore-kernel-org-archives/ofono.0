Content-Type: multipart/mixed; boundary="===============5135742823737990637=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: About Gatmux
Date: Tue, 24 Aug 2010 17:47:38 +0800
Message-ID: <4C73953A.3080102@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5135742823737990637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

In DLC establish phase, 27.010 have said if the station wish to =

establish a DLC, if the responding station is ready to establish the =

connection it will reply with a UA frame with the F-bit set to 1. If the =

responding station is not ready or unwilling to establish the particular =

DLC it will reply with a DM frame with the F-bit set to 1.

But in function gsm0710_packet, i can't find the corresponding =

processing, so does retransmit processing.

So does Gatmux support this, or it will support?

Any suggestion will welcome

B.R

Steven
---------------------------------------------------------------------------=
------------------------
Confidentiality Notice: The information contained in this e-mail and any ac=
companying attachment(s) =

is intended only for the use of the intended recipient and may be confident=
ial and/or privileged of =

Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader =
of this communication is =

not the intended recipient, unauthorized use, forwarding, printing,  storin=
g, disclosure or copying =

is strictly prohibited, and may be unlawful.If you have received this commu=
nication in error,please =

immediately notify the sender by return e-mail, and delete the original mes=
sage and all copies from =

your system. Thank you. =

---------------------------------------------------------------------------=
------------------------


--===============5135742823737990637==--

