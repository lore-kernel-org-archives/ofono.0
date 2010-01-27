Content-Type: multipart/mixed; boundary="===============1747922732314247238=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: HFP support into BlueZ and oFono
Date: Wed, 27 Jan 2010 17:12:46 -0200
Message-ID: <1264619569-12448-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1747922732314247238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

New patches for the HFP support. The BlueZ part was updated with the Johan'=
s comments and the oFono patch supports load/remove of bluetooth devices dy=
namically.
We still have bug: the link RFCOMM on the AG side is closed only when bluet=
oothd shuts down. Any idea on that?

Comments are welcome.

-- =

Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi =



--===============1747922732314247238==--

