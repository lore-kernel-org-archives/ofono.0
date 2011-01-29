Content-Type: multipart/mixed; boundary="===============3071128607944981847=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] atmodem: fix memory leak
Date: Sat, 29 Jan 2011 10:21:21 -0800
Message-ID: <1296325281-7224-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3071128607944981847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 819864f..0938998 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -157,6 +157,8 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 				at_crsm_info_cb, cbd, g_free) > 0)
 		return;
 =

+	g_free(cbd);
+
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
 				EF_STATUS_INVALIDATED, data);
 }
-- =

1.7.0.4


--===============3071128607944981847==--

