Content-Type: multipart/mixed; boundary="===============8812371769883613161=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] include: fix comment on dst value
Date: Wed, 02 Feb 2011 15:10:45 +0200
Message-ID: <1296652246-11801-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8812371769883613161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/types.h b/include/types.h
index 31f2682..d25f409 100644
--- a/include/types.h
+++ b/include/types.h
@@ -105,7 +105,7 @@ struct ofono_network_time {
 	int mday;	/* Day of month [1..31], -1 if unavailable */
 	int mon;	/* Month [1..12], -1 if unavailable */
 	int year;	/* Current year, -1 if unavailable */
-	int dst;	/* Current adjustment, in seconds */
+	int dst;	/* Current adjustment, in hours */
 	int utcoff;	/* Offset from UTC in seconds */
 };
 =

-- =

1.7.0.4


--===============8812371769883613161==--

