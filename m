Content-Type: multipart/mixed; boundary="===============0256890894935297800=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 5/6] service: fix some leaks
Date: Fri, 23 Mar 2012 17:45:40 +0100
Message-ID: <1332521141-31865-6-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332521141-31865-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0256890894935297800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index 2047008..a68516d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1135,6 +1135,11 @@ static void process_message_on_start(struct mms_serv=
ice *service,
 			if (request =3D=3D NULL)
 				goto register_sr;
 =

+			close(request->fd);
+			request->fd =3D -1;
+
+			unlink(request->data_path);
+			g_free(request->data_path);
 			request->data_path =3D mms_store_get_path(service_id,
 									uuid);
 		} else
-- =

1.7.4.4


--===============0256890894935297800==--

