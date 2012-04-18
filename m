Content-Type: multipart/mixed; boundary="===============3289189883242656329=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 06/10] service: refactoring file closure
Date: Wed, 18 Apr 2012 15:27:44 +0200
Message-ID: <1334755668-27458-7-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3289189883242656329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

---
 src/service.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index efb90cb..70b3dda 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1815,8 +1815,6 @@ static gboolean web_get_cb(GWebResult *result, gpoint=
er user_data)
 	}

 	if (chunk_size =3D=3D 0) {
-		close(request->fd);
-
 		request->status =3D g_web_result_get_status(result);

 		DBG("status: %03u", request->status);
@@ -1837,10 +1835,11 @@ static gboolean web_get_cb(GWebResult *result, gpoi=
nter user_data)
 	return TRUE;

 error:
-	close(request->fd);
 	unlink(request->data_path);

 complete:
+	close(request->fd);
+
 	if (request->result_cb !=3D NULL)
 		request->result_cb(request);

--
1.7.4.1


--===============3289189883242656329==--

