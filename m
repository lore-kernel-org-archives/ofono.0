Content-Type: multipart/mixed; boundary="===============6853783730493123957=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 1/2] voicecall: manage multiparty list in AT+CHLD=3
Date: Tue, 05 Jul 2011 07:50:36 +0200
Message-ID: <1309845037-27360-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1309845037-27360-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6853783730493123957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 9620838..14f25ab 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1788,7 +1788,7 @@ static DBusMessage *multiparty_private_chat(DBusConne=
ction *conn,
 	unsigned int id;
 	GSList *l;
 =

-	if (vc->pending)
+	if (vc->pending || vc->pending_em)
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &callpath,
@@ -1886,7 +1886,7 @@ static DBusMessage *multiparty_create(DBusConnection =
*conn,
 {
 	struct ofono_voicecall *vc =3D data;
 =

-	if (vc->pending)
+	if (vc->pending || vc->pending_em)
 		return __ofono_error_busy(msg);
 =

 	if (!voicecalls_have_held(vc) || !voicecalls_have_active(vc))
@@ -1907,7 +1907,7 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 {
 	struct ofono_voicecall *vc =3D data;
 =

-	if (vc->pending || vc->release_list)
+	if (vc->pending || vc->pending_em || vc->release_list)
 		return __ofono_error_busy(msg);
 =

 	if (vc->driver->release_specific =3D=3D NULL)
@@ -2710,6 +2710,44 @@ static void emulator_generic_cb(const struct ofono_e=
rror *error, void *data)
 	ofono_emulator_send_final(em, error);
 }
 =

+static void emulator_mpty_join_cb(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_voicecall *vc =3D data;
+	GSList *old;
+
+	ofono_emulator_send_final(vc->pending_em, error);
+	vc->pending_em =3D NULL;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
+
+	/*
+	 * We just created a multiparty call, gather all held
+	 * active calls and add them to the multiparty list
+	 */
+	old =3D vc->multiparty_list;
+	vc->multiparty_list =3D 0;
+
+	vc->multiparty_list =3D g_slist_concat(vc->multiparty_list,
+						voicecalls_held_list(vc));
+
+	vc->multiparty_list =3D g_slist_concat(vc->multiparty_list,
+						voicecalls_active_list(vc));
+
+	vc->multiparty_list =3D g_slist_sort(vc->multiparty_list,
+						call_compare);
+
+	if (g_slist_length(vc->multiparty_list) < 2) {
+		ofono_error("Created multiparty call, but size is less than 2"
+				" panic!");
+		g_slist_free(old);
+		return;
+	}
+
+	voicecalls_multiparty_changed(old, vc->multiparty_list);
+	g_slist_free(old);
+}
+
 static void emulator_ata_cb(struct ofono_emulator *em,
 			struct ofono_emulator_request *req, void *userdata)
 {
@@ -2903,8 +2941,17 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			if (vc->driver->create_multiparty =3D=3D NULL)
 				goto fail;
 =

+			if (vc->pending_em || vc->pending || vc->dial_req)
+				goto fail;
+
+			if (!voicecalls_have_held(vc)
+					|| !voicecalls_have_active(vc))
+				goto fail;
+
+			vc->pending_em =3D em;
+
 			vc->driver->create_multiparty(vc,
-					emulator_generic_cb, em);
+					emulator_mpty_join_cb, vc);
 			return;
 		case 4:
 			if (vc->driver->transfer =3D=3D NULL)
-- =

1.7.1


--===============6853783730493123957==--

