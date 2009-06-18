Content-Type: multipart/mixed; boundary="===============7918905596263380640=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Teach USSD to recognise password change strings.
Date: Thu, 18 Jun 2009 06:04:23 +0200
Message-ID: <1245297863-15310-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7918905596263380640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is slightly hacky, part of ussd.c responsible for registering services
is duplicated and parse_ss_control_string is modified to accept a fourth
SI fragment in the input string.
---
 src/common.c       |    3 +-
 src/common.h       |    2 +-
 src/modem.h        |    1 +
 src/ussd.c         |  144 ++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/ussd.h         |   10 ++++
 unit/test-common.c |   10 +++-
 6 files changed, 159 insertions(+), 11 deletions(-)

diff --git a/src/common.c b/src/common.c
index 8653432..a9166bf 100644
--- a/src/common.c
+++ b/src/common.c
@@ -465,7 +465,7 @@ const char *ss_control_type_to_string(enum ss_control_t=
ype type)
 gboolean parse_ss_control_string(char *str, int *ss_type,
 					char **sc, char **sia,
 					char **sib, char **sic,
-					char **dn)
+					char **sid, char **dn)
 {
 	int len =3D strlen(str);
 	int cur =3D 0;
@@ -533,6 +533,7 @@ gboolean parse_ss_control_string(char *str, int *ss_typ=
e,
 	NEXT_FIELD(c, *sia);
 	NEXT_FIELD(c, *sib);
 	NEXT_FIELD(c, *sic);
+	NEXT_FIELD(c, *sid);
 =

 	if (*c =3D=3D '\0')
 		ret =3D TRUE;
diff --git a/src/common.h b/src/common.h
index 1c0a776..0f7684e 100644
--- a/src/common.h
+++ b/src/common.h
@@ -192,7 +192,7 @@ gboolean valid_ussd_string(const char *str);
 gboolean parse_ss_control_string(char *str, int *ss_type,
 					char **sc, char **sia,
 					char **sib, char **sic,
-					char **dn);
+					char **sid, char **dn);
 =

 const char *ss_control_type_to_string(enum ss_control_type type);
 =

diff --git a/src/modem.h b/src/modem.h
index 22655f7..bbe7f99 100644
--- a/src/modem.h
+++ b/src/modem.h
@@ -28,6 +28,7 @@ struct ofono_modem {
 	void 		*userdata;
 =

 	GSList *ss_control_list;
+	GSList *ss_passwd_list;
 =

 	struct ofono_modem_data *modem_info;
 	struct network_registration_data *network_registration;
diff --git a/src/ussd.c b/src/ussd.c
index 7225398..d2251c8 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -165,22 +165,148 @@ void ss_control_unregister(struct ofono_modem *modem=
, const char *str,
 						l->data);
 }
 =

+struct ss_passwd_entry {
+	char *service;
+	ss_passwd_cb_t cb;
+};
+
+static struct ss_passwd_entry *ss_passwd_entry_create(const char *service,
+							ss_passwd_cb_t cb)
+{
+	struct ss_passwd_entry *r;
+
+	r =3D g_try_new0(struct ss_passwd_entry, 1);
+
+	if (!r)
+		return r;
+
+	r->service =3D g_strdup(service);
+	r->cb =3D cb;
+
+	return r;
+}
+
+static void ss_passwd_entry_destroy(struct ss_passwd_entry *ca)
+{
+	g_free(ca->service);
+	g_free(ca);
+}
+
+static gint ss_passwd_entry_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ss_passwd_entry *ca =3D a;
+	const struct ss_passwd_entry *cb =3D b;
+	int ret;
+
+	ret =3D strcmp(ca->service, cb->service);
+
+	if (ret)
+		return ret;
+
+	if (ca->cb < cb->cb)
+		return -1;
+
+	if (ca->cb > cb->cb)
+		return 1;
+
+	return 0;
+}
+
+static gint ss_passwd_entry_find_by_service(gconstpointer a, gconstpointer=
 b)
+{
+	const struct ss_passwd_entry *ca =3D a;
+
+	return strcmp(ca->service, b);
+}
+
+gboolean ss_passwd_register(struct ofono_modem *modem, const char *str,
+				ss_passwd_cb_t cb)
+{
+	struct ss_passwd_entry *entry;
+
+	if (!modem)
+		return FALSE;
+
+	entry =3D ss_passwd_entry_create(str, cb);
+
+	if (!entry)
+		return FALSE;
+
+	modem->ss_passwd_list =3D g_slist_append(modem->ss_passwd_list, entry);
+
+	return TRUE;
+}
+
+void ss_passwd_unregister(struct ofono_modem *modem, const char *str,
+				ss_passwd_cb_t cb)
+{
+	const struct ss_passwd_entry entry =3D { (char *)str, cb };
+	GSList *l;
+
+	if (!modem)
+		return;
+
+	l =3D g_slist_find_custom(modem->ss_passwd_list, &entry,
+				ss_passwd_entry_compare);
+
+	if (!l)
+		return;
+
+	ss_passwd_entry_destroy(l->data);
+	modem->ss_passwd_list =3D g_slist_remove(modem->ss_passwd_list,
+						l->data);
+}
+
+static gboolean recognized_passwd_change_string(struct ofono_modem *modem,
+						int type, char *sc,
+						char *sia, char *sib,
+						char *sic, char *sid,
+						char *dn, DBusMessage *msg)
+{
+	GSList *l =3D modem->ss_passwd_list;
+
+	switch (type) {
+	case SS_CONTROL_TYPE_ACTIVATION:
+	case SS_CONTROL_TYPE_REGISTRATION:
+		break;
+
+	default:
+		return FALSE;
+	}
+
+	if (strcmp(sc, "03") || strlen(dn) || strcmp(sic, sid))
+		return FALSE;
+
+	while ((l =3D g_slist_find_custom(l, sia,
+			ss_passwd_entry_find_by_service)) !=3D NULL) {
+		struct ss_passwd_entry *entry =3D l->data;
+
+		if (entry->cb(modem, sia, sib, sic, msg))
+			return TRUE;
+
+		l =3D l->next;
+	}
+
+	return FALSE;
+}
+
 static gboolean recognized_control_string(struct ofono_modem *modem,
 						const char *ss_str,
 						DBusMessage *msg)
 {
 	char *str =3D g_strdup(ss_str);
-	char *sc, *sia, *sib, *sic, *dn;
+	char *sc, *sia, *sib, *sic, *sid, *dn;
 	int type;
 	gboolean ret =3D FALSE;
 =

 	ofono_debug("parsing control string");
 =

-	if (parse_ss_control_string(str, &type, &sc, &sia, &sib, &sic, &dn)) {
+	if (parse_ss_control_string(str, &type, &sc,
+				&sia, &sib, &sic, &sid, &dn)) {
 		GSList *l =3D modem->ss_control_list;
 =

-		ofono_debug("Got parse result: %d, %s, %s, %s, %s, %s",
-				type, sc, sia, sib, sic, dn);
+		ofono_debug("Got parse result: %d, %s, %s, %s, %s, %s, %s",
+				type, sc, sia, sib, sic, sid, dn);
 =

 		while ((l =3D g_slist_find_custom(l, sc,
 				ss_control_entry_find_by_service)) !=3D NULL) {
@@ -193,6 +319,13 @@ static gboolean recognized_control_string(struct ofono=
_modem *modem,
 =

 			l =3D l->next;
 		}
+
+		/* A password change string needs to be treated separately
+		 * because it uses a fourth SI and is thus not a valid
+		 * control string.  */
+		if (recognized_passwd_change_string(modem, type, sc,
+					sia, sib, sic, sid, dn, msg))
+			goto out;
 	}
 =

 	/* TODO: Handle all strings that control voice calls */
@@ -205,9 +338,6 @@ static gboolean recognized_control_string(struct ofono_=
modem *modem,
 	 * by SEND and are not valid USSD requests.
 	 */
 =

-	/* TODO: Handle Password registration according to 22.030 Section 6.5.4
-	 */
-
 out:
 	g_free(str);
 =

diff --git a/src/ussd.h b/src/ussd.h
index 5b956e5..5f40f61 100644
--- a/src/ussd.h
+++ b/src/ussd.h
@@ -26,8 +26,18 @@ typedef gboolean (*ss_control_cb_t)(struct ofono_modem *=
modem,
 					const char *sic, const char *dn,
 					DBusMessage *msg);
 =

+typedef gboolean (*ss_passwd_cb_t)(struct ofono_modem *modem, const char *=
sc,
+					const char *old, const char *new,
+					DBusMessage *msg);
+
 gboolean ss_control_register(struct ofono_modem *modem, const char *str,
 				ss_control_cb_t cb);
 =

 void ss_control_unregister(struct ofono_modem *modem, const char *str,
 				ss_control_cb_t cb);
+
+gboolean ss_passwd_register(struct ofono_modem *modem, const char *str,
+				ss_passwd_cb_t cb);
+
+void ss_passwd_unregister(struct ofono_modem *modem, const char *str,
+				ss_passwd_cb_t cb);
diff --git a/unit/test-common.c b/unit/test-common.c
index 5c753d3..96509bd 100644
--- a/unit/test-common.c
+++ b/unit/test-common.c
@@ -57,6 +57,7 @@ static void test_invalid()
 	char *sia;
 	char *sib;
 	char *sic;
+	char *sid;
 	char *dn;
 	int type;
 =

@@ -71,7 +72,9 @@ static void test_invalid()
 		str =3D strdup(invalid_strings[i]);
 =

 		ret =3D parse_ss_control_string(str, &type, &sc,
-						&sia, &sib, &sic, &dn);
+						&sia, &sib, &sic, &sid, &dn);
+		if (strlen(sid))
+			ret =3D FALSE;
 =

 		g_assert(ret =3D=3D FALSE);
 =

@@ -105,6 +108,7 @@ static void test_valid()
 	char *sia;
 	char *sib;
 	char *sic;
+	char *sid;
 	char *dn;
 	int type;
 	gboolean ret;
@@ -119,7 +123,9 @@ static void test_valid()
 		str =3D strdup(valid_strings[i]);
 =

 		ret =3D parse_ss_control_string(str, &type, &sc,
-						&sia, &sib, &sic, &dn);
+						&sia, &sib, &sic, &sid, &dn);
+		if (strlen(sid))
+			ret =3D FALSE;
 =

 		g_assert(ret =3D=3D TRUE);
 =

-- =

1.6.0


--===============7918905596263380640==--

