Content-Type: multipart/mixed; boundary="===============5483002492277699179=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] mbpi: Pop subparser stack after mmsc and mmsproxy
Date: Thu, 06 Feb 2014 14:12:26 +0200
Message-ID: <1391688746-5457-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5483002492277699179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 17ba4d8..dff8752 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -190,7 +190,9 @@ static void apn_end(GMarkupParseContext *context, const=
 gchar *element_name,
 {
 	if (g_str_equal(element_name, "name") ||
 			g_str_equal(element_name, "username") ||
-			g_str_equal(element_name, "password"))
+			g_str_equal(element_name, "password") ||
+			g_str_equal(element_name, "mmsc") ||
+			g_str_equal(element_name, "mmsproxy"))
 		g_markup_parse_context_pop(context);
 }
 =

-- =

1.8.3.2


--===============5483002492277699179==--

