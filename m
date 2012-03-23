Content-Type: multipart/mixed; boundary="===============0975046418740490339=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 4/6] service: request_post_file opens the pdu itself
Date: Fri, 23 Mar 2012 17:45:39 +0100
Message-ID: <1332521141-31865-5-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332521141-31865-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0975046418740490339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 8dbee12..2047008 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1137,7 +1137,6 @@ static void process_message_on_start(struct mms_servi=
ce *service,
 =

 			request->data_path =3D mms_store_get_path(service_id,
 									uuid);
-			request->fd =3D open(request->data_path, O_RDONLY);
 		} else
 			request =3D NULL;
 register_sr:
-- =

1.7.4.4


--===============0975046418740490339==--

