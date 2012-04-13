Content-Type: multipart/mixed; boundary="===============8935244373834947526=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 06/10] service: refactoring file closure
Date: Fri, 13 Apr 2012 18:33:45 +0200
Message-ID: <1334334829-31617-7-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8935244373834947526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index ee06dca..1be0386 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1813,8 +1813,6 @@ static gboolean web_get_cb(GWebResult *result, gpoint=
er user_data)
 	}
 =

 	if (chunk_size =3D=3D 0) {
-		close(request->fd);
-
 		request->status =3D g_web_result_get_status(result);
 =

 		DBG("status: %03u", request->status);
@@ -1835,10 +1833,11 @@ static gboolean web_get_cb(GWebResult *result, gpoi=
nter user_data)
 	return TRUE;
 =

 error:
-	close(request->fd);
 	unlink(request->data_path);
 =

 complete:
+	close(request->fd);
+
 	if (request->result_cb !=3D NULL)
 		request->result_cb(request);
 =

-- =

1.7.4.4


--===============8935244373834947526==--

