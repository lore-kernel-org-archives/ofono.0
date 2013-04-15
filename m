Content-Type: multipart/mixed; boundary="===============7360119076370158032=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 6/6] handsfree-audio: Toggle wideband support when the
 agent registers
Date: Mon, 15 Apr 2013 10:54:53 -0300
Message-ID: <1366034093-24084-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366034093-24084-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7360119076370158032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each time an agent registers itself, we check if we support deferred
setup and if the agent has mSBC as a codec, if both checks are true,
we enable wideband speech support.
---
 src/handsfree-audio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index fc3d15b..c24e787 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -646,7 +646,7 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	unsigned char *codecs;
 	DBusMessageIter iter, array;
 	int length, i;
-	gboolean has_cvsd =3D FALSE;
+	gboolean has_cvsd =3D FALSE, has_msbc =3D FALSE;
 =

 	if (agent)
 		return __ofono_error_in_use(msg);
@@ -668,10 +668,17 @@ static DBusMessage *am_agent_register(DBusConnection =
*conn,
 	for (i =3D 0; i < length; i++) {
 		if (codecs[i] =3D=3D HFP_CODEC_CVSD)
 			has_cvsd =3D TRUE;
-		else if (codecs[i] !=3D HFP_CODEC_MSBC)
+		else if (codecs[i] =3D=3D HFP_CODEC_MSBC)
+			has_msbc =3D TRUE;
+		else
 			return __ofono_error_invalid_args(msg);
 	}
 =

+	if (has_msbc && defer_setup =3D=3D 1)
+		has_wideband =3D TRUE;
+	else
+		has_wideband =3D FALSE;
+
 	if (has_cvsd =3D=3D FALSE) {
 		ofono_error("CVSD codec is mandatory");
 		return __ofono_error_invalid_args(msg);
-- =

1.8.2


--===============7360119076370158032==--

