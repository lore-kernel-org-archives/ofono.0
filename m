Content-Type: multipart/mixed; boundary="===============0096904906016902126=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 3/5] Add ofono_modem_reset()
Date: Fri, 03 Dec 2010 16:52:55 -0200
Message-ID: <1291402377-9211-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291402377-9211-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0096904906016902126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems can screw up everything and then we will need to do a silent
reset of the modem. This patch take the modem back to the OFFLINE state.
---
 src/modem.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index d6ab316..3126af1 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1615,6 +1615,26 @@ void ofono_modem_remove(struct ofono_modem *modem)
 	g_free(modem);
 }
 =

+void ofono_modem_reset(struct ofono_modem *modem)
+{
+	int err;
+
+	DBG("%p", modem);
+
+	if (modem->pending) {
+		DBusMessage *reply =3D __ofono_error_failed(modem->pending);
+		__ofono_dbus_pending_reply(&modem->pending, reply);
+	}
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


--===============0096904906016902126==--

