Content-Type: multipart/mixed; boundary="===============1132149944352598091=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 4/4] qmimodem: convert register_net_cb errors into CMEs
Date: Tue, 05 Dec 2017 19:20:17 +0100
Message-ID: <20171205182017.462-4-lynxis@fe80.eu>
In-Reply-To: <20171205182017.462-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1132149944352598091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain modems doesn't support manual registering (gobi 2000).
Translate the error code into ofono error to report a
more detailed debug error message.
---
 drivers/qmimodem/network-registration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index c1760b83ee40..6c1f50ba0416 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -332,6 +332,7 @@ static void register_net_cb(struct qmi_result *result, =
void *user_data)
 	struct cb_data *cbd =3D user_data;
 	ofono_netreg_register_cb_t cb =3D cbd->cb;
 	uint16_t error;
+	int cme_error;
 =

 	DBG("");
 =

@@ -341,7 +342,8 @@ static void register_net_cb(struct qmi_result *result, =
void *user_data)
 			goto done;
 		}
 =

-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		cme_error =3D qmi_error_to_ofono_cme(error);
+		CALLBACK_WITH_CME_ERROR(cb, cme_error, cbd->data);
 		return;
 	}
 =

-- =

2.15.1


--===============1132149944352598091==--

