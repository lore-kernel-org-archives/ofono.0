Content-Type: multipart/mixed; boundary="===============1587442702267110932=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] huawei: do not set timer more than once
Date: Wed, 19 Jan 2011 11:07:43 -0200
Message-ID: <1295442463-7151-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1587442702267110932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a "^SYSINFO" arrives after the timer for query_sim_locked() has been
set up, it'd would set a new timer, signaling a sim state change more
than once.
---
 plugins/huawei.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index d6a9d68..b4b7436 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -289,7 +289,8 @@ static void sysinfo_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		data->sim_poll_timeout =3D g_timeout_add_seconds(2,
 								query_sim_state,
 								modem);
-	} else if (sim_state =3D=3D	HUAWEI_SIM_STATE_INVALID_OR_LOCKED) {
+	} else if (sim_state =3D=3D	HUAWEI_SIM_STATE_INVALID_OR_LOCKED &&
+						!data->sim_poll_timeout) {
 		data->sim_poll_timeout =3D g_timeout_add_seconds(2,
 								query_sim_locked,
 								modem);
-- =

1.7.3.5


--===============1587442702267110932==--

