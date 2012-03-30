Content-Type: multipart/mixed; boundary="===============0812025356975289938=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/2] service: transaction id should'nt be NULL
Date: Fri, 30 Mar 2012 17:40:52 +0200
Message-ID: <1333122053-30708-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1333122053-30708-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0812025356975289938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is not contained in an automatic retrieve_conf pdu.
---
 src/service.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 755ebc3..f148252 100644
--- a/src/service.c
+++ b/src/service.c
@@ -998,9 +998,11 @@ static gboolean load_message_from_store(const char *se=
rvice_id,
 		else
 			msg->rc.status =3D MMS_MESSAGE_STATUS_RECEIVED;
 	} else if (strcmp(state, "downloaded") =3D=3D 0
-			&& msg->type =3D=3D MMS_MESSAGE_TYPE_RETRIEVE_CONF)
+			&& msg->type =3D=3D MMS_MESSAGE_TYPE_RETRIEVE_CONF) {
 		msg->rc.status =3D MMS_MESSAGE_STATUS_DOWNLOADED;
-	else if (strcmp(state, "sent") =3D=3D 0
+		if (msg->transaction_id =3D=3D NULL)
+			msg->transaction_id =3D "";
+	} else if (strcmp(state, "sent") =3D=3D 0
 			&& msg->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
 		msg->sr.status =3D MMS_MESSAGE_STATUS_SENT;
 	else if (strcmp(state, "draft") =3D=3D 0
-- =

1.7.4.4


--===============0812025356975289938==--

