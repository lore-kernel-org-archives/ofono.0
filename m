Content-Type: multipart/mixed; boundary="===============2932618684882629269=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] main: Make -d option repeatable
Date: Tue, 04 Oct 2016 12:51:54 +0300
Message-ID: <1475574714-3539-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2932618684882629269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Concatenating the patterns makes more sense than using the last
supplied value and leaking the previous allocated patterns.
---
 src/main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 46bb90b..b43bb4e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -137,10 +137,19 @@ static gboolean option_version =3D FALSE;
 static gboolean parse_debug(const char *key, const char *value,
 					gpointer user_data, GError **error)
 {
-	if (value)
-		option_debug =3D g_strdup(value);
-	else
+	if (value) {
+		if (option_debug) {
+			char *prev =3D option_debug;
+
+			option_debug =3D g_strconcat(prev, ",", value, NULL);
+			g_free(prev);
+		} else {
+			option_debug =3D g_strdup(value);
+		}
+	} else {
+		g_free(option_debug);
 		option_debug =3D g_strdup("*");
+	}
 =

 	return TRUE;
 }
@@ -262,5 +271,7 @@ cleanup:
 =

 	__ofono_log_cleanup();
 =

+	g_free(option_debug);
+
 	return 0;
 }
-- =

1.9.1


--===============2932618684882629269==--

