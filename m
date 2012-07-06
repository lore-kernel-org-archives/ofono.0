Content-Type: multipart/mixed; boundary="===============0369865228615580212=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 3/3] service: use delivery_report in send_req message
Date: Fri, 06 Jul 2012 11:32:27 +0200
Message-ID: <1341567147-18467-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1341567147-18467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0369865228615580212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/service.c b/src/service.c
index 5913a55..e3812a7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -918,6 +918,8 @@ static DBusMessage *send_message(DBusConnection *conn,
 	if (msg->transaction_id =3D=3D NULL)
 		goto release_msg;
 =

+	msg->sr.dr =3D service->dr;
+
 	request =3D create_request(MMS_REQUEST_TYPE_POST,
 				result_request_send_conf, NULL, service, msg);
 	if (request =3D=3D NULL)
-- =

1.7.9.5


--===============0369865228615580212==--

