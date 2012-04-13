Content-Type: multipart/mixed; boundary="===============3526266859979682905=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 08/10] service: refactoring error code
Date: Fri, 13 Apr 2012 18:33:47 +0200
Message-ID: <1334334829-31617-9-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3526266859979682905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/service.c b/src/service.c
index f8ad05f..de92487 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1814,7 +1814,7 @@ static gboolean web_get_cb(GWebResult *result, gpoint=
er user_data)
 =

 	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
 		mms_error("Fail to get data chunk");
-		goto error;
+		goto complete;
 	}
 =

 	if (chunk_size =3D=3D 0) {
@@ -1832,21 +1832,21 @@ static gboolean web_get_cb(GWebResult *result, gpoi=
nter user_data)
 =

 	if (written !=3D chunk_size) {
 		mms_error("only %zd/%zd bytes written\n", written, chunk_size);
-		goto error;
+		goto complete;
 	}
 =

 	return TRUE;
 =

-error:
-	unlink(request->data_path);
-
 complete:
 	close(request->fd);
 =

-	if (request->result_cb !=3D NULL)
-		request->result_cb(request);
-
-	mms_request_destroy(request);
+	if (request->result_cb =3D=3D NULL || request->result_cb(request) =3D=3D =
TRUE)
+		mms_request_destroy(request);
+	else {
+		mms_error("Fail to get data (http status =3D %03u)",
+							request->status);
+		unlink(request->data_path);
+	}
 =

 	request->service->current_request_id =3D 0;
 =

-- =

1.7.4.4


--===============3526266859979682905==--

