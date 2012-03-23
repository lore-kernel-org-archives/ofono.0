Content-Type: multipart/mixed; boundary="===============5132030552671217498=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 6/6] service: request needs to keep msg
Date: Fri, 23 Mar 2012 17:45:41 +0100
Message-ID: <1332521141-31865-7-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332521141-31865-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5132030552671217498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index a68516d..824257f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1142,6 +1142,8 @@ static void process_message_on_start(struct mms_servi=
ce *service,
 			g_free(request->data_path);
 			request->data_path =3D mms_store_get_path(service_id,
 									uuid);
+
+			request->msg =3D msg;
 		} else
 			request =3D NULL;
 register_sr:
-- =

1.7.4.4


--===============5132030552671217498==--

