Content-Type: multipart/mixed; boundary="===============2541067460531780416=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 01/11] Avoid duplicate in scanned network technologies list
Date: Tue, 11 Jan 2011 16:08:29 +0200
Message-ID: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2541067460531780416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index eb0f797..11f0fa2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -134,16 +134,28 @@ static char **network_operator_technologies(struct ne=
twork_operator_data *opd)
 			ntechs +=3D 1;
 	}
 =

-	techs =3D g_new0(char *, ntechs + 1);
+	techs =3D g_new(char *, ntechs + 1);
 	ntechs =3D 0;
 =

 	for (i =3D 0; i < sizeof(opd->techs) * 8; i++) {
+		const char *tech;
+		unsigned int j;
+
 		if (!(opd->techs & (1 << i)))
 			continue;
 =

-		techs[ntechs++] =3D g_strdup(registration_tech_to_string(i));
+		tech =3D registration_tech_to_string(i);
+
+		for (j =3D 0; j < ntechs; j++)
+			if (!strcmp(techs[j], tech))
+				break;
+
+		if (j =3D=3D ntechs)
+			techs[ntechs++] =3D g_strdup(tech);
 	}
 =

+	techs[i] =3D NULL;
+
 	return techs;
 }
 =

-- =

1.7.1


--===============2541067460531780416==--

