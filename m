Content-Type: multipart/mixed; boundary="===============5900189945510630659=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 6/7] modem: M16 coding style fix
Date: Sat, 05 Feb 2011 06:29:10 -0800
Message-ID: <1296916151-21778-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5900189945510630659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 8e243d8..6cb8fab 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -121,7 +121,7 @@ unsigned int __ofono_modem_callid_next(struct ofono_mod=
em *modem)
 	unsigned int i;
 =

 	for (i =3D 1; i < sizeof(modem->call_ids) * 8; i++) {
-		if (modem->call_ids & (0x1 << i))
+		if (modem->call_ids & (1 << i))
 			continue;
 =

 		return i;
@@ -132,12 +132,12 @@ unsigned int __ofono_modem_callid_next(struct ofono_m=
odem *modem)
 =

 void __ofono_modem_callid_hold(struct ofono_modem *modem, int id)
 {
-	modem->call_ids |=3D (0x1 << id);
+	modem->call_ids |=3D (1 << id);
 }
 =

 void __ofono_modem_callid_release(struct ofono_modem *modem, int id)
 {
-	modem->call_ids &=3D ~(0x1 << id);
+	modem->call_ids &=3D ~(1 << id);
 }
 =

 void ofono_modem_set_data(struct ofono_modem *modem, void *data)
-- =

1.7.0.4


--===============5900189945510630659==--

