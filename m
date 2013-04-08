Content-Type: multipart/mixed; boundary="===============3675389885264873438=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/6] handsfree-audio: Remove unused 'codecs' field from agent
Date: Mon, 08 Apr 2013 19:41:03 -0300
Message-ID: <1365460863-14645-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3675389885264873438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we only keep track whether we support wideband speech or not, we
don't have to keep track of the list of codecs supported by the Agent.
---
 src/handsfree-audio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 69d033d..188deee 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -55,8 +55,6 @@ struct ofono_handsfree_card {
 struct agent {
 	char *owner;
 	char *path;
-	unsigned char *codecs;
-	int codecs_len;
 	guint watch;
 };
 =

@@ -548,7 +546,6 @@ static void agent_free(struct agent *agent)
 =

 	g_free(agent->owner);
 	g_free(agent->path);
-	g_free(agent->codecs);
 	g_free(agent);
 }
 =

@@ -660,8 +657,6 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	agent =3D g_new0(struct agent, 1);
 	agent->owner =3D g_strdup(sender);
 	agent->path =3D g_strdup(path);
-	agent->codecs =3D g_memdup(codecs, length);
-	agent->codecs_len =3D length;
 	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
 						agent_disconnect, NULL, NULL);
 =

-- =

1.8.2


--===============3675389885264873438==--

