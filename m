Content-Type: multipart/mixed; boundary="===============6484435271633458556=="
MIME-Version: 1.0
From: Bassem Boubaker <bassem.boubaker@actia.fr>
Subject: [PATCH] Fix bug with "PropertyChanged" signals not being emmitted by
 ofono for org.ofono.cdma.NetworkRegistration
Date: Fri, 16 Mar 2018 16:24:10 +0100
Message-ID: <1521213850-13133-1-git-send-email-bassem.boubaker@actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6484435271633458556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
---
 src/cdma-netreg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index ba9ee23..23616d9 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -115,6 +115,8 @@ static const GDBusMethodTable cdma_netreg_manager_metho=
ds[] =3D {
 };
 =

 static const GDBusSignalTable cdma_netreg_manager_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 =

-- =

2.7.4


--===============6484435271633458556==--

