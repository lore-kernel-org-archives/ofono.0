Content-Type: multipart/mixed; boundary="===============0382033013618981344=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 9/9] handsfree-audio: Add an option to kill incoming
 connections
Date: Mon, 25 Mar 2013 18:16:35 +0100
Message-ID: <1364231795-13787-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364231795-13787-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0382033013618981344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/handsfree-audio.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/handsfree-audio.c b/tools/handsfree-audio.c
index e8725b7..90c274b 100644
--- a/tools/handsfree-audio.c
+++ b/tools/handsfree-audio.c
@@ -64,6 +64,7 @@ static gboolean option_nocvsd =3D FALSE;
 static gboolean option_nomsbc =3D FALSE;
 static gboolean option_server =3D FALSE;
 static gboolean option_defer =3D FALSE;
+static gboolean option_kill =3D FALSE;
 static gchar *option_client_addr =3D NULL;
 =

 static const char sntable[4] =3D { 0x08, 0x38, 0xC8, 0xF8 };
@@ -556,6 +557,9 @@ static int new_connection(int fd, int codec)
 	struct hfp_thread *thread;
 =

 	DBG("New connection: fd=3D%d codec=3D%d", fd, codec);
+	if (option_kill)
+		return -ECANCELED;
+
 	thread =3D g_try_malloc0(sizeof(struct hfp_thread));
 	if (thread =3D=3D NULL)
 		return -ENOMEM;
@@ -891,6 +895,8 @@ static GOptionEntry options[] =3D {
 				"Server" },
 	{ "client", 'C', 1, G_OPTION_ARG_STRING, &option_client_addr,
 				"Client addr" },
+	{ "kill", 'k', 0, G_OPTION_ARG_NONE, &option_kill,
+				"Kill all new connections" },
 	{ NULL },
 };
 =

-- =

1.7.9.5


--===============0382033013618981344==--

