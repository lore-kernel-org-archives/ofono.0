Content-Type: multipart/mixed; boundary="===============7767754168951238583=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFC 5/6] main: Enable parsing SMS ref number setting
Date: Wed, 26 Jan 2011 10:56:25 +0200
Message-ID: <1296032186-21497-6-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296032186-21497-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7767754168951238583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c  |   11 +++++++++++
 src/ofono.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/main.c b/src/main.c
index 129d36c..e55b6e7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -116,6 +116,7 @@ static void parse_config(GKeyFile *config)
 {
 	GError *err =3D NULL;
 	char *str;
+	gboolean val;
 =

 	if (!config)
 		return;
@@ -130,6 +131,16 @@ static void parse_config(GKeyFile *config)
 		main_opts.flags |=3D OFONO_SET_NOPLUGIN;
 		g_free(str);
 	}
+
+	val =3D g_key_file_get_boolean(config, "MessageManager",
+					"Use16bitReference", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("Use16bitReference=3D%s", val ? "true" : "false");
+		main_opts.use_16bit_ref =3D val;
+	}
 }
 =

 static void init_defaults(void)
diff --git a/src/ofono.h b/src/ofono.h
index 54de5a6..0c0f2a8 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -27,6 +27,7 @@
 =

 struct main_opts {
 	char *noplugin;
+	gboolean use_16bit_ref;
 	unsigned long flags;
 };
 =

-- =

1.7.1


--===============7767754168951238583==--

