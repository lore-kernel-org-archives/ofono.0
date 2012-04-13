Content-Type: multipart/mixed; boundary="===============5509102861820217560=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 03/10] service: remove useless variable
Date: Fri, 13 Apr 2012 18:33:42 +0200
Message-ID: <1334334829-31617-4-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5509102861820217560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index 6041d6d..7969988 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1801,7 +1801,6 @@ static gboolean web_get_cb(GWebResult *result, gpoint=
er user_data)
 	gsize written;
 	gsize chunk_size;
 	struct mms_request *request =3D user_data;
-	struct mms_service *service;
 	const guint8 *chunk;
 =

 	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
@@ -1836,16 +1835,14 @@ error:
 	unlink(request->data_path);
 =

 complete:
-	service =3D request->service;
-
 	if (request->result_cb !=3D NULL)
 		request->result_cb(request);
 =

 	mms_request_destroy(request);
 =

-	service->current_request_id =3D 0;
+	request->service->current_request_id =3D 0;
 =

-	process_request_queue(service);
+	process_request_queue(request->service);
 =

 	return FALSE;
 }
-- =

1.7.4.4


--===============5509102861820217560==--

