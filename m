Content-Type: multipart/mixed; boundary="===============7685439096500871527=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 08/10] service: refactoring error code
Date: Wed, 18 Apr 2012 15:27:46 +0200
Message-ID: <1334755668-27458-9-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7685439096500871527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

---
 src/service.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/service.c b/src/service.c
index e577198..bcfd9e0 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1816,7 +1816,7 @@ static gboolean web_get_cb(GWebResult *result, gpoint=
er user_data)

 	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
 		mms_error("Fail to get data chunk");
-		goto error;
+		goto complete;
 	}

 	if (chunk_size =3D=3D 0) {
@@ -1834,21 +1834,21 @@ static gboolean web_get_cb(GWebResult *result, gpoi=
nter user_data)

 	if (written !=3D chunk_size) {
 		mms_error("only %zd/%zd bytes written\n", written, chunk_size);
-		goto error;
+		goto complete;
 	}

 	return TRUE;

-error:
-	unlink(request->data_path);
-
 complete:
 	close(request->fd);

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

 	request->service->current_request_id =3D 0;

--
1.7.4.1


--===============7685439096500871527==--

