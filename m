Content-Type: multipart/mixed; boundary="===============8229194195256537791=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v3 2/3] service: NULL uuid here is an error
Date: Mon, 26 Mar 2012 18:12:38 +0200
Message-ID: <1332778359-5756-3-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332778359-5756-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8229194195256537791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index 25a4fc4..25a2563 100644
--- a/src/service.c
+++ b/src/service.c
@@ -750,6 +750,8 @@ static DBusMessage *send_message(DBusConnection *conn,
 =

 	msg->uuid =3D g_strdup(mms_store_file(service->identity,
 						request->data_path));
+	if (msg->uuid =3D=3D NULL)
+		goto release_request;
 =

 	meta =3D mms_store_meta_open(service->identity, msg->uuid);
 	if (meta =3D=3D NULL)
-- =

1.7.4.4


--===============8229194195256537791==--

