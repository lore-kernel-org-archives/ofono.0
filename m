Content-Type: multipart/mixed; boundary="===============2093826981759672808=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 27/32] telit: Add modem type hardware
Date: Tue, 22 Nov 2011 18:09:56 +0100
Message-ID: <1321981801-5452-28-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2093826981759672808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/telit.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 48087f2..ef8e262 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -666,6 +666,7 @@ static void telit_remove(struct ofono_modem *modem)
 =

 static struct ofono_modem_driver telit_driver =3D {
 	.name		=3D "telit",
+	.modem_type	=3D OFONO_MODEM_TYPE_HARDWARE,
 	.probe		=3D telit_probe,
 	.remove		=3D telit_remove,
 	.enable		=3D telit_enable,
-- =

1.7.8.rc1.14.g248db


--===============2093826981759672808==--

