Content-Type: multipart/mixed; boundary="===============7653848590466806014=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 4/6] plugins/file-provisioning.c: support for auth NONE
Date: Tue, 02 Oct 2018 08:26:25 +0200
Message-ID: <20181002062628.17466-3-gciofono@gmail.com>
In-Reply-To: <20181002062628.17466-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7653848590466806014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/file-provision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/file-provision.c b/plugins/file-provision.c
index d4846a65..9c4a02d1 100644
--- a/plugins/file-provision.c
+++ b/plugins/file-provision.c
@@ -104,6 +104,9 @@ static int config_file_provision_get_settings(const cha=
r *mcc,
 		else if (g_strcmp0(value, "pap") =3D=3D 0)
 			(*settings)[0].auth_method =3D
 						OFONO_GPRS_AUTH_METHOD_PAP;
+		else if (g_strcmp0(value, "none") =3D=3D 0)
+			(*settings)[0].auth_method =3D
+						OFONO_GPRS_AUTH_METHOD_NONE;
 		else
 			DBG("Unknown auth method: %s", value);
 =

-- =

2.17.1


--===============7653848590466806014==--

