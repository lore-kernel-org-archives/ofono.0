Content-Type: multipart/mixed; boundary="===============3678521461362183291=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 2/3] emulator: Force indicator event implementation
Date: Wed, 14 Mar 2012 17:00:52 +0100
Message-ID: <1331740853-3994-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1331740853-3994-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3678521461362183291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 0f1ceca..8df721c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1245,3 +1245,26 @@ start_ring:
 	em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
 							notify_ring, em);
 }
+
+void ofono_emulator_set_indicator_forced(struct ofono_emulator *em,
+						const char *name, int value)
+{
+	int i;
+	struct indicator *ind;
+	char buf[20];
+
+	ind =3D find_indicator(em, name, &i);
+
+	if (ind =3D=3D NULL || value < ind->min || value > ind->max)
+		return;
+
+	ind->value =3D value;
+
+	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc && ind->active)=
 {
+		if (!g_at_server_command_pending(em->server)) {
+			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
+			g_at_server_send_unsolicited(em->server, buf);
+		} else
+			ind->deferred =3D TRUE;
+	}
+}
-- =

1.7.1


--===============3678521461362183291==--

