Content-Type: multipart/mixed; boundary="===============8253586607431662895=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH v2] stemodem: Check for ok in voicecall_initialize.
Date: Fri, 04 Feb 2011 15:40:04 +0100
Message-ID: <1296830404-24691-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8253586607431662895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 drivers/stemodem/voicecall.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index dde1387..4a3a83d 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -535,6 +535,13 @@ static void ste_voicecall_initialized(gboolean ok, GAt=
Result *result,
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

+	if (!ok) {
+		ofono_error("*ECAV not enabled. "
+				"Do not have proper call handling");
+		ofono_voicecall_remove(vc);
+		return;
+	}
+
 	g_at_chat_register(vd->chat, "*ECAV:", ecav_notify, FALSE, vc, NULL);
 	ofono_voicecall_register(vc);
 }
-- =

1.7.1


--===============8253586607431662895==--

