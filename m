Content-Type: multipart/mixed; boundary="===============2434069040656393023=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v4 11/16] dundee: Add callback helpers
Date: Tue, 20 Dec 2011 15:47:14 +0100
Message-ID: <1324392439-26508-12-git-send-email-wagi@monom.org>
In-Reply-To: <1324392439-26508-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2434069040656393023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/dundee.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/dundee/dundee.h b/dundee/dundee.h
index 2ce4270..660c245 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -28,6 +28,50 @@
 =

 void __dundee_exit(void);
 =

+enum dundee_error_type {
+	DUNDEE_ERROR_TYPE_NO_ERROR =3D 0,
+	DUNDEE_ERROR_TYPE_FAILURE,
+};
+
+struct dundee_error {
+	enum dundee_error_type type;
+	int error;
+};
+
+struct cb_data {
+	void *cb;
+	void *data;
+	void *user;
+};
+
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
+#define CALLBACK_WITH_FAILURE(cb, args...)		\
+	do {						\
+		struct dundee_error cb_e;		\
+		cb_e.type =3D DUNDEE_ERROR_TYPE_FAILURE;	\
+		cb_e.error =3D 0;				\
+							\
+		cb(&cb_e, ##args);			\
+	} while (0)					\
+
+#define CALLBACK_WITH_SUCCESS(f, args...)		\
+	do {						\
+		struct dundee_error e;			\
+		e.type =3D DUNDEE_ERROR_TYPE_NO_ERROR;	\
+		e.error =3D 0;				\
+		f(&e, ##args);				\
+	} while(0)					\
+
 #include <ofono/log.h>
 =

 int __ofono_log_init(const char *program, const char *debug,
-- =

1.7.8.110.g4cb5d1


--===============2434069040656393023==--

