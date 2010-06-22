Content-Type: multipart/mixed; boundary="===============8515068751841572647=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/8] mbmmodem: Cancel running command on *STKEND.
Date: Tue, 22 Jun 2010 13:20:50 +0200
Message-ID: <1277205651-29369-7-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8515068751841572647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/stk.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index 77bd7b5..53b5adf 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -179,6 +179,14 @@ static void stkn_notify(GAtResult *result, gpointer us=
er_data)
 =

 static void stkend_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_stk *stk =3D user_data;
+
+	/* Seems to be used by the modem and/or cards to indicate
+	 * that we have taken too long to respond to a command, but
+	 * does not invalidate current application state, such as
+	 * main menu (?)
+	 */
+	ofono_stk_proactive_command_cancel(stk);
 }
 =

 static void mbm_stkc_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.7.1.86.g0e460.dirty


--===============8515068751841572647==--

