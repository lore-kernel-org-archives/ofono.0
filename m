Content-Type: multipart/mixed; boundary="===============1385980812874377665=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/2] src/main.c: removed call to g_thread_init
Date: Thu, 20 Sep 2018 06:39:40 +0200
Message-ID: <1537418381-18473-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1385980812874377665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

according to g_thread documentation, this call is no longer needed,
and starting from g_thread version 2.32 it must not be used
---
 src/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/main.c b/src/main.c
index 2d359dd..d8a06ba 100644
--- a/src/main.c
+++ b/src/main.c
@@ -211,11 +211,6 @@ int main(int argc, char **argv)
 	struct ell_event_source *source;
 #endif
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

-- =

1.9.1


--===============1385980812874377665==--

