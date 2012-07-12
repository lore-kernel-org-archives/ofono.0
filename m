Content-Type: multipart/mixed; boundary="===============4098151603664877368=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH] phonesim: one small fix regarding the dbus interface
Date: Thu, 12 Jul 2012 10:06:09 +0200
Message-ID: <1342080370-24537-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4098151603664877368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Heyho,

while working with phonesim's dbus interface I discovered it's not using fo=
r each reported
error the same error domain. The attached patch fixes this.

regards,
Simon

Simon Busch (1):
  control: use correct dbus error domain

 src/control.cpp |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- =

1.7.9.5


--===============4098151603664877368==--

