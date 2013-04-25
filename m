Content-Type: multipart/mixed; boundary="===============0496154440506030388=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 08/12] main: Call emulator init and cleanup functions
Date: Thu, 25 Apr 2013 16:09:09 -0300
Message-ID: <1366916953-12967-9-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0496154440506030388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/main.c b/src/main.c
index d6349cb..38aff7d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -241,6 +241,8 @@ int main(int argc, char **argv)
 =

 	__ofono_handsfree_audio_manager_init();
 =

+	__ofono_emulator_init();
+
 	__ofono_plugin_init(option_plugin, option_noplugin);
 =

 	g_free(option_plugin);
@@ -250,6 +252,8 @@ int main(int argc, char **argv)
 =

 	__ofono_plugin_cleanup();
 =

+	__ofono_emulator_cleanup();
+
 	__ofono_handsfree_audio_manager_cleanup();
 =

 	__ofono_manager_cleanup();
-- =

1.7.9.5


--===============0496154440506030388==--

