Content-Type: multipart/mixed; boundary="===============2289051466472464161=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 5/5] hsp_ag: change emulator type to hsp
Date: Mon, 14 Mar 2011 16:49:21 +0100
Message-ID: <1300117761-6181-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300117761-6181-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2289051466472464161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hsp_ag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hsp_ag.c b/plugins/hsp_ag.c
index 467b6b2..4ace88e 100644
--- a/plugins/hsp_ag.c
+++ b/plugins/hsp_ag.c
@@ -102,7 +102,7 @@ static void connect_cb(GIOChannel *channel, GError *err=
, gpointer data)
 	modem =3D modems->data;
 	DBG("Picked modem %p for emulator", modem);
 =

-	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HSP);
 	if (em =3D=3D NULL)
 		return;
 =

-- =

1.7.1


--===============2289051466472464161==--

