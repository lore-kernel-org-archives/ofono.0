Content-Type: multipart/mixed; boundary="===============1382391355608920521=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 2/2] ussd: check g_try_new0 return value
Date: Wed, 06 Oct 2010 18:01:40 +0300
Message-ID: <1286377300-21614-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286377300-21614-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1382391355608920521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/ussd.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index aad7d32..c80d247 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -888,6 +888,9 @@ int __ofono_ussd_initiate(struct ofono_ussd *ussd, int =
dcs,
 		return -EBUSY;
 =

 	req =3D g_try_new0(struct ussd_request, 1);
+	if (req =3D=3D NULL)
+		return -ENOMEM;
+
 	req->cb =3D cb;
 	req->user_data =3D user_data;
 =

-- =

1.7.0.4


--===============1382391355608920521==--

