Content-Type: multipart/mixed; boundary="===============0996098996505973424=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 21/22] emulator: Copy callback mechanism from atutil.h
Date: Thu, 16 May 2013 14:16:41 -0300
Message-ID: <1368724602-27781-22-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0996098996505973424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

atutil.h needs GAtChat and GAtResult definitions and we do not have
these definitions inside emulator.c.
---
 src/emulator.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 2ce1542..c468452 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -47,6 +47,28 @@
 =

 #define HFP_16_AG_DRIVER "hfp16-ag-driver"
 =

+#define CALLBACK_WITH_FAILURE(cb, args...)		\
+	do {						\
+		struct ofono_error cb_e;		\
+		cb_e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
+		cb_e.error =3D 0;				\
+							\
+		cb(&cb_e, ##args);			\
+	} while (0)					\
+
+#define CALLBACK_WITH_SUCCESS(cb, args...)		\
+	do {						\
+		struct ofono_error e;			\
+		e.type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
+		e.error =3D 0;				\
+		cb(&e, ##args);				\
+	} while (0)
+
+struct cb_data {
+	void *cb;
+	void *data;
+};
+
 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
@@ -80,6 +102,17 @@ struct indicator {
 	gboolean mandatory;
 };
 =

+static inline struct cb_data *cb_data_new(void *cb, void *data)
+{
+	struct cb_data *ret;
+
+	ret =3D g_new0(struct cb_data, 1);
+	ret->cb =3D cb;
+	ret->data =3D data;
+
+	return ret;
+}
+
 static void emulator_debug(const char *str, void *data)
 {
 	ofono_info("%s: %s\n", (char *)data, str);
-- =

1.7.9.5


--===============0996098996505973424==--

