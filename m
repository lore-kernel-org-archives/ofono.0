Content-Type: multipart/mixed; boundary="===============7764865837531967803=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v3 4/6] qim: use named status value
Date: Sat, 15 Apr 2017 17:34:44 +0200
Message-ID: <20170415153446.31803-6-jonas@southpole.se>
In-Reply-To: <20170415153446.31803-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7764865837531967803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/network-registration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index a3f9cf9..c29a733 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -88,7 +88,7 @@ static bool extract_ss_info(struct qmi_result *result, in=
t *status,
 	if (qmi_result_get_uint8(result, QMI_NAS_RESULT_ROAMING_STATUS,
 								&roaming)) {
 		if (ss->status =3D=3D 1 && roaming =3D=3D 0)
-			*status =3D 5;
+			*status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
 	}
 =

 	if (!operator)
-- =

2.9.3


--===============7764865837531967803==--

