Content-Type: multipart/mixed; boundary="===============9081264608725227037=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] plugin: Don't unload external plugins too early
Date: Fri, 20 Jul 2018 20:35:23 +0300
Message-ID: <1532108123-23886-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9081264608725227037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Plugins may reference data structures allocated by each other.
They all need to be deinitialized first, only then it should be
safe to unload the libraries.
---
 src/plugin.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index 2c9c619..924a45e 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -190,17 +190,26 @@ void __ofono_plugin_cleanup(void)
 =

 	DBG("");
 =

+	/*
+	 * Terminate the plugins but don't unload the libraries yet.
+	 * Plugins may reference data structures allocated by each other.
+	 */
 	for (list =3D plugins; list; list =3D list->next) {
 		struct ofono_plugin *plugin =3D list->data;
 =

 		if (plugin->active =3D=3D TRUE && plugin->desc->exit)
 			plugin->desc->exit();
+	}
+
+	/* Second pass - unload the libraries */
+	for (list =3D plugins; list; list =3D list->next) {
+		struct ofono_plugin *plugin =3D list->data;
 =

 		if (plugin->handle)
 			dlclose(plugin->handle);
-
-		g_free(plugin);
 	}
 =

-	g_slist_free(plugins);
+	/* Finally, free the memory */
+	g_slist_free_full(plugins, g_free);
+	plugins =3D NULL;
 }
-- =

1.9.1


--===============9081264608725227037==--

