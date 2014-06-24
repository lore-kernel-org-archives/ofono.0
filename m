Content-Type: multipart/mixed; boundary="===============8257795878511223911=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 3/3] gprs: provision the authentication method
Date: Tue, 24 Jun 2014 11:57:06 +0200
Message-ID: <1403603826-17021-4-git-send-email-philip@paeps.cx>
In-Reply-To: <1403603826-17021-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257795878511223911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 1efcc0c..05ab499 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -3030,6 +3030,8 @@ static void provision_context(const struct ofono_gprs=
_provision_data *ap,
 	if (ap->password !=3D NULL)
 		strcpy(context->context.password, ap->password);
 =

+	context->context.auth_method =3D ap->auth_method;
+
 	strcpy(context->context.apn, ap->apn);
 	context->context.proto =3D ap->proto;
 =

-- =

1.7.10.4


--===============8257795878511223911==--

