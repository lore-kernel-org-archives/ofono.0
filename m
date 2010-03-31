Content-Type: multipart/mixed; boundary="===============4978725301265783253=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/7] Fix Add check for return modem to avoid crash
Date: Wed, 31 Mar 2010 17:50:34 +0800
Message-ID: <1270029040-21077-1-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4978725301265783253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/modemconf.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index cf0ee8b..e30fce6 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -138,6 +138,10 @@ static struct ofono_modem *create_modem(GKeyFile *keyf=
ile, const char *group)
 		return NULL;
 =

 	modem =3D ofono_modem_create(group, driver);
+	if (!modem) {
+		g_free(driver);
+		return NULL;
+	}
 =

 	for (i =3D 0; setup_helpers[i].driver; i++) {
 		if (!g_strcmp0(driver, setup_helpers[i].driver))
-- =

1.6.6.1


--===============4978725301265783253==--

