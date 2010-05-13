Content-Type: multipart/mixed; boundary="===============1371312450582677650=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 09/16] emulator: Add interface to send AT result
Date: Thu, 13 May 2010 18:02:32 +0800
Message-ID: <1273744959-3711-10-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-9-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1371312450582677650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   20 ++++++++++++++++++++
 src/ofono.h    |    7 +++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 5ad0d78..e66e9ca 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -294,6 +294,26 @@ static gboolean emulator_dbus_register(struct ofono_em=
ulator *oe,
 	return TRUE;
 }
 =

+void ofono_emulator_send_final(struct emulator *e, GAtServerResult result)
+{
+	g_at_server_send_final(e->server, result);
+}
+
+void ofono_emulator_send_ext_final(struct emulator *e, const char *result)
+{
+	g_at_server_send_ext_final(e->server, result);
+}
+
+void ofono_emulator_send_intermediate(struct emulator *e, const char *resu=
lt)
+{
+	g_at_server_send_intermediate(e->server, result);
+}
+
+void ofono_emulator_send_unsolicited(struct emulator *e, const char *resul=
t)
+{
+	g_at_server_send_unsolicited(e->server, result);
+}
+
 static int emulators_path_list(struct ofono_emulator *oe, char ***objlist)
 {
 	GSList *emulator_list =3D oe->emulator_list;
diff --git a/src/ofono.h b/src/ofono.h
index 120238c..047260c 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -270,6 +270,7 @@ void __ofono_message_waiting_mwi(struct ofono_message_w=
aiting *mw,
 #include <ofono/emulator.h>
 =

 struct emulator;
+enum _GAtServerResult;
 =

 enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_CREATE =3D 0,
@@ -296,3 +297,9 @@ unsigned int __ofono_emulator_add_status_watch(struct o=
fono_emulator *emulator,
 =

 gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *emula=
tor,
 						unsigned int id);
+
+void ofono_emulator_send_final(struct emulator *e,
+					enum _GAtServerResult result);
+void ofono_emulator_send_ext_final(struct emulator *e, const char *result);
+void ofono_emulator_send_intermediate(struct emulator *e, const char *resu=
lt);
+void ofono_emulator_send_unsolicited(struct emulator *e, const char *resul=
t);
-- =

1.6.3.3


--===============1371312450582677650==--

