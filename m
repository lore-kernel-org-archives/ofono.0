Content-Type: multipart/mixed; boundary="===============0598771771346665089=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/7] hfpmodem: M16 coding style fix
Date: Sat, 05 Feb 2011 06:29:07 -0800
Message-ID: <1296916151-21778-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0598771771346665089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index f247bea..e5121f4 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -229,7 +229,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
 			enum ofono_disconnect_reason reason;
 =

-			if (vd->local_release & (0x1 << oc->id))
+			if (vd->local_release & (1 << oc->id))
 				reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
 			else
 				reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
-- =

1.7.0.4


--===============0598771771346665089==--

