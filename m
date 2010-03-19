Content-Type: multipart/mixed; boundary="===============7390062284352103330=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/10] Fix do not emit error if extended error has emitted
Date: Fri, 19 Mar 2010 17:44:46 +0800
Message-ID: <1268991888-17279-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-8-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7390062284352103330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 1ffc2c3..9683fa3 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -165,6 +165,10 @@ static void g_at_server_send_final(GAtServer *server, =
GAtServerResult result)
 	char r =3D v250.s4;
 	unsigned int len;
 =

+	/* Do not emit error if extended error has already been emitted */
+	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
+		return;
+
 	if (v250.quiet)
 		return;
 =

-- =

1.6.6.1


--===============7390062284352103330==--

