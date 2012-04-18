Content-Type: multipart/mixed; boundary="===============8930328508907889372=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 03/10] service: remove useless variable
Date: Wed, 18 Apr 2012 15:27:41 +0200
Message-ID: <1334755668-27458-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8930328508907889372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

---
 src/service.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index e36f318..4ec49e6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1803,7 +1803,6 @@ static gboolean web_get_cb(GWebResult *result, gpoint=
er user_data)
 	gsize written;
 	gsize chunk_size;
 	struct mms_request *request =3D user_data;
-	struct mms_service *service;
 	const guint8 *chunk;

 	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
@@ -1838,16 +1837,14 @@ error:
 	unlink(request->data_path);

 complete:
-	service =3D request->service;
-
 	if (request->result_cb !=3D NULL)
 		request->result_cb(request);

 	mms_request_destroy(request);

-	service->current_request_id =3D 0;
+	request->service->current_request_id =3D 0;

-	process_request_queue(service);
+	process_request_queue(request->service);

 	return FALSE;
 }
--
1.7.4.1


--===============8930328508907889372==--

