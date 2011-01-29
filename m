Content-Type: multipart/mixed; boundary="===============7077401976962267651=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] hfpmodem: fix memory leak
Date: Sat, 29 Jan 2011 10:24:12 -0800
Message-ID: <1296325452-7384-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7077401976962267651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/network-registration.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 23852e7..931ab67 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -267,6 +267,8 @@ static void hfp_current_operator(struct ofono_netreg *n=
etreg,
 	if (ok)
 		return;
 =

+	g_free(cbd);
+
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

-- =

1.7.0.4


--===============7077401976962267651==--

