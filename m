Content-Type: multipart/mixed; boundary="===============2531261000353770332=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/14] mbmmodem: End session on *STKEND.
Date: Wed, 07 Jul 2010 00:38:57 +0200
Message-ID: <1278455949-2823-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2531261000353770332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/stk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index 77bd7b5..613b257 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -179,6 +179,9 @@ static void stkn_notify(GAtResult *result, gpointer use=
r_data)
 =

 static void stkend_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_stk *stk =3D user_data;
+
+	ofono_stk_proactive_session_end_notify(stk);
 }
 =

 static void mbm_stkc_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.7.1.86.g0e460.dirty


--===============2531261000353770332==--

