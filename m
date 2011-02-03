Content-Type: multipart/mixed; boundary="===============4546063351239842297=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Check for ok in voicecall_initialize.
Date: Thu, 03 Feb 2011 14:13:24 +0100
Message-ID: <1296738804-23599-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4546063351239842297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 drivers/stemodem/voicecall.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index fa078a8..2eaba8c 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -522,6 +522,10 @@ static void ste_voicecall_initialized(gboolean ok, GAt=
Result *result,
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

+	if (!ok)
+		ofono_error("*ECAV not enabled. "
+				"Do not have proper call handling");
+
 	g_at_chat_register(vd->chat, "*ECAV:", ecav_notify, FALSE, vc, NULL);
 	ofono_voicecall_register(vc);
 }
-- =

1.7.1


--===============4546063351239842297==--

