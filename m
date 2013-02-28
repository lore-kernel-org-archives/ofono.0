Content-Type: multipart/mixed; boundary="===============8808897761286629899=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 08/10] handsfree-audio: Check CVSD when registering agent
Date: Thu, 28 Feb 2013 15:52:50 -0300
Message-ID: <1362077572-28049-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8808897761286629899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch makes CVSD codec mandatory when registering a Handsfree
Audio Agent.
---
 src/handsfree-audio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 50bd861..d0ccf29 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -448,6 +448,7 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	unsigned char *codecs;
 	DBusMessageIter iter, array;
 	int length, i;
+	gboolean has_cvsd =3D FALSE;
 =

 	if (agent)
 		return __ofono_error_in_use(msg);
@@ -467,11 +468,17 @@ static DBusMessage *am_agent_register(DBusConnection =
*conn,
 		return __ofono_error_invalid_args(msg);
 =

 	for (i =3D 0; i < length; i++) {
-		if (codecs[i] !=3D HFP_CODEC_CVSD &&
-				codecs[i] !=3D HFP_CODEC_MSBC)
+		if (codecs[i] =3D=3D HFP_CODEC_CVSD)
+			has_cvsd =3D TRUE;
+		else if (codecs[i] !=3D HFP_CODEC_MSBC)
 			return __ofono_error_invalid_args(msg);
 	}
 =

+	if (has_cvsd =3D=3D FALSE) {
+		ofono_error("CVSD codec is mandatory");
+		return __ofono_error_invalid_args(msg);
+	}
+
 	agent =3D g_new0(struct agent, 1);
 	agent->owner =3D g_strdup(sender);
 	agent->path =3D g_strdup(path);
-- =

1.7.11.7


--===============8808897761286629899==--

