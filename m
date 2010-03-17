Content-Type: multipart/mixed; boundary="===============1111987448538574638=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/11] Add G_AT_SERVER_RESULT_EXT_ERROR
Date: Wed, 17 Mar 2010 22:30:38 +0800
Message-ID: <1268836241-4834-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-7-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1111987448538574638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 5e9eb62..6fb78bd 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -43,6 +43,7 @@ enum _GAtServerResult {
 	G_AT_SERVER_RESULT_NO_DIALTONE =3D 6,
 	G_AT_SERVER_RESULT_BUSY =3D 7,
 	G_AT_SERVER_RESULT_NO_ANSWER =3D 8,
+	G_AT_SERVER_RESULT_EXT_ERROR =3D 256,
 };
 =

 typedef enum _GAtServerResult GAtServerResult;
-- =

1.6.6.1


--===============1111987448538574638==--

