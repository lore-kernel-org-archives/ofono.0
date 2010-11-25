Content-Type: multipart/mixed; boundary="===============1908836357343388625=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/5] Add ofono_modem_reset()
Date: Thu, 25 Nov 2010 17:02:16 -0200
Message-ID: <1290711740-27886-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1908836357343388625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems can screw up everything and then we will need to do a silent
reset of the modem. This patch take the modem back to the OFFLINE state.
---
 include/modem.h |    2 ++
 src/modem.c     |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index 7b13ee0..a92eb88 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -46,6 +46,8 @@ int ofono_modem_register(struct ofono_modem *modem);
 ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem);
 void ofono_modem_remove(struct ofono_modem *modem);
 =

+void ofono_modem_reset(struct ofono_modem *modem);
+
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
 =

diff --git a/src/modem.c b/src/modem.c
index f032d93..6233944 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1615,6 +1615,21 @@ void ofono_modem_remove(struct ofono_modem *modem)
 	g_free(modem);
 }
 =

+void ofono_modem_reset(struct ofono_modem *modem)
+{
+	int err;
+
+	DBG("%p", modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	err =3D set_powered(modem, TRUE);
+	if (err =3D=3D -EINPROGRESS)
+		return;
+
+	modem_change_state(modem, MODEM_STATE_PRE_SIM);
+}
+
 int ofono_modem_driver_register(const struct ofono_modem_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.3.2


--===============1908836357343388625==--

