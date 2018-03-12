Content-Type: multipart/mixed; boundary="===============5415116700123982547=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: LTE atom support for gemalto modem
Date: Mon, 12 Mar 2018 14:36:58 +0100
Message-ID: <8e8e60f4-7eda-b8de-f88c-efdf1927f99c@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5415116700123982547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

First of all, sorry for having spammed the mailing list with last patch =

serie. I thought some hadn't been accepted. Some patches are from =

Mariem, a colleague, who wasn't in the subscribers before and she was in =

the cc: field.

I've been having a look at the recent LTE atom. I've noticed there was =

no vendor-specific parameter when registering it. I think we might have =

some problem with the atmodem driver as in the =

AT+CGDCONT=3D<context-id>,... command, the context-id starts from 0 on =

some modems and from 1 on other ones (I won't denounce gemalto).

I think adding the vendor ID as a parameter might cause heavy =

modifications so I wanted to have your opinion on how to handle this =

case the simpliest way.

Best Regards,

Gabriel Lucas


--===============5415116700123982547==--

