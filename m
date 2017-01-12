Content-Type: multipart/mixed; boundary="===============4191336259419034035=="
MIME-Version: 1.0
From: Vincent Cesson <cesson.vincent@gmail.com>
Subject: [RFC 0/1] Fix CGDCONT result parsing in atmodem
Date: Thu, 12 Jan 2017 18:09:29 +0100
Message-ID: <1484240970-3406-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4191336259419034035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The AT command CGDCONT=3D? may give several ranges of supported context ide=
ntifier.
For example with Cinterion PHS8:

 AT+CGDCONT=3D?
 +CGDCONT: (1-17,101-116),"IP",,,(0),(0-4)

The callback in atmodem driver fails because it expects a unique range in f=
irst list.
I propose to skip to next list instead of trying to close the brackets.

vcesson (1):
  atmodem: Fix CGDCONT result parsing.

 drivers/atmodem/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- =

1.9.1


--===============4191336259419034035==--

