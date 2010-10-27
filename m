Content-Type: multipart/mixed; boundary="===============7243935773303432390=="
MIME-Version: 1.0
From: johan.hedberg@gmail.com
Subject: [PATCH] Fix string array memory leaks during plugin loading
Date: Wed, 27 Oct 2010 16:21:05 -0400
Message-ID: <1288210865-20706-1-git-send-email-johan.hedberg@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7243935773303432390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Johan Hedberg <johan.hedberg@nokia.com>

---
 src/plugin.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index 68fe318..7c0652b 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -176,6 +176,9 @@ int __ofono_plugin_init(const char *pattern, const char=
 *exclude)
 		plugin->active =3D TRUE;
 	}
 =

+	g_strfreev(patterns);
+	g_strfreev(excludes);
+
 	return 0;
 }
 =

-- =

1.7.1


--===============7243935773303432390==--

