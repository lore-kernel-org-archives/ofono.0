Content-Type: multipart/mixed; boundary="===============8687249446296590510=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 1/2] main: Remove handsfree audio manager init and cleanup
Date: Mon, 02 Feb 2015 14:43:05 +0200
Message-ID: <1422880986-11262-2-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1422880986-11262-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8687249446296590510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Init allocates a SCO audio socket always. Ofono should do that
with bluez5 but not with bluez4.
---
 src/main.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/main.c b/src/main.c
index d6349cb..46bb90b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -239,8 +239,6 @@ int main(int argc, char **argv)
 =

 	__ofono_manager_init();
 =

-	__ofono_handsfree_audio_manager_init();
-
 	__ofono_plugin_init(option_plugin, option_noplugin);
 =

 	g_free(option_plugin);
@@ -250,8 +248,6 @@ int main(int argc, char **argv)
 =

 	__ofono_plugin_cleanup();
 =

-	__ofono_handsfree_audio_manager_cleanup();
-
 	__ofono_manager_cleanup();
 =

 	__ofono_modemwatch_cleanup();
-- =

1.7.9.5


--===============8687249446296590510==--

