Content-Type: multipart/mixed; boundary="===============3018807883091787469=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ussd-mmi PATCH 4/4] voicecall: check g_try_new0 return value
Date: Wed, 06 Oct 2010 17:52:19 +0300
Message-ID: <1286376739-20677-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286376739-20677-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3018807883091787469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/voicecall.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 8be7487..7b5fe3b 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2281,6 +2281,9 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 	 */
 =

 	req =3D g_try_new0(struct dial_request, 1);
+	if (req =3D=3D NULL)
+		return -ENOMEM;
+
 	req->message =3D g_strdup(message);
 	req->icon_id =3D icon_id;
 	req->interaction =3D interaction;
-- =

1.7.0.4


--===============3018807883091787469==--

