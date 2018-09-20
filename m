Content-Type: multipart/mixed; boundary="===============5669746437574094420=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 3/4] plugins/file-provisioning.c: take into account
 auth_methods NONE and ANY
Date: Thu, 20 Sep 2018 06:23:49 +0200
Message-ID: <1537417430-10904-3-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537417430-10904-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5669746437574094420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added the support for the NONE and ANY authentication methods
---
 plugins/file-provision.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/file-provision.c b/plugins/file-provision.c
index d4846a6..f7412e6 100644
--- a/plugins/file-provision.c
+++ b/plugins/file-provision.c
@@ -104,6 +104,12 @@ static int config_file_provision_get_settings(const ch=
ar *mcc,
 		else if (g_strcmp0(value, "pap") =3D=3D 0)
 			(*settings)[0].auth_method =3D
 						OFONO_GPRS_AUTH_METHOD_PAP;
+		else if (g_strcmp0(value, "none") =3D=3D 0)
+			(*settings)[0].auth_method =3D
+						OFONO_GPRS_AUTH_METHOD_NONE;
+		else if (g_strcmp0(value, "any") =3D=3D 0)
+			(*settings)[0].auth_method =3D
+						OFONO_GPRS_AUTH_METHOD_ANY;
 		else
 			DBG("Unknown auth method: %s", value);
 =

-- =

1.9.1


--===============5669746437574094420==--

