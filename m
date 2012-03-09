Content-Type: multipart/mixed; boundary="===============3943006043743930153=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/4] emulator: Force indicator event implementation
Date: Fri, 09 Mar 2012 16:26:54 +0100
Message-ID: <1331306815-13424-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1331306815-13424-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3943006043743930153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 0f1ceca..34329f0 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -62,6 +62,7 @@ struct indicator {
 	gboolean deferred;
 	gboolean active;
 	gboolean mandatory;
+	gboolean forced;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -1181,11 +1182,12 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 =

 	ind =3D find_indicator(em, name, &i);
 =

-	if (ind =3D=3D NULL || ind->value =3D=3D value || value < ind->min
-			|| value > ind->max)
+	if (ind =3D=3D NULL || (ind->value =3D=3D value && !ind->forced)
+			|| value < ind->min || value > ind->max)
 		return;
 =

 	ind->value =3D value;
+	ind->forced =3D FALSE;
 =

 	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
 	cs_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, NULL);
@@ -1245,3 +1247,15 @@ start_ring:
 	em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
 							notify_ring, em);
 }
+
+void ofono_emulator_indicator_set_forced(struct ofono_emulator *em,
+					const char *name)
+{
+	struct indicator *ind;
+
+	ind =3D find_indicator(em, name, NULL);
+	if (ind =3D=3D NULL)
+		return;
+
+	ind->forced =3D TRUE;
+}
-- =

1.7.1


--===============3943006043743930153==--

