Content-Type: multipart/mixed; boundary="===============3298569387228352423=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 21/32] sap: Add modem type sap
Date: Tue, 22 Nov 2011 18:09:50 +0100
Message-ID: <1321981801-5452-22-git-send-email-wagi@monom.org>
In-Reply-To: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3298569387228352423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/sap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index f88e61a..d893bc1 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -306,6 +306,7 @@ static void bluetooth_sap_set_alias(const char *device,=
 const char *alias)
 =

 static struct ofono_modem_driver sap_driver =3D {
 	.name		=3D "sap",
+	.modem_type	=3D OFONO_MODEM_TYPE_SAP,
 	.probe		=3D sap_probe,
 	.remove		=3D sap_remove,
 	.enable		=3D sap_enable,
-- =

1.7.8.rc1.14.g248db


--===============3298569387228352423==--

