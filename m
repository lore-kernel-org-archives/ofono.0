Content-Type: multipart/mixed; boundary="===============6569600724604377873=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] change ifx command for enabling SATK
Date: Thu, 13 Jan 2011 15:27:26 +0200
Message-ID: <1294925247-5144-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6569600724604377873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch replaces the AT+CFUN=3D6 by AT+XSATK=3D1,1 for enabling SA=
TK

Regards,
Jeevaka

Jeevaka Badrappan (1):
  ifxmodem: change AT command for enabling SATK

 drivers/ifxmodem/stk.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


--===============6569600724604377873==--

