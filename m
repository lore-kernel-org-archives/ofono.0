Content-Type: multipart/mixed; boundary="===============2311726462108383772=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] examples: fix issue with dst print
Date: Wed, 02 Feb 2011 15:10:46 +0200
Message-ID: <1296652246-11801-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296652246-11801-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311726462108383772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 examples/nettime.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/examples/nettime.c b/examples/nettime.c
index 3843ce2..f586f07 100644
--- a/examples/nettime.c
+++ b/examples/nettime.c
@@ -59,7 +59,7 @@ static void example_nettime_info_received(struct ofono_ne=
ttime_context *context,
 			info->year, info->mon, info->mday, info->hour,
 			info->min, info->sec, info->utcoff > 0 ? '+' : '-',
 			info->utcoff / 3600, (info->utcoff % 3600) / 60,
-			info->dst / 3600);
+			info->dst);
 }
 =

 static struct ofono_nettime_driver example_driver =3D {
-- =

1.7.0.4


--===============2311726462108383772==--

