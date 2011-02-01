Content-Type: multipart/mixed; boundary="===============5574354766967372403=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] isimodem: convert dst from hours to seconds
Date: Tue, 01 Feb 2011 13:44:05 +0200
Message-ID: <1296560645-19062-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296560645-19062-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5574354766967372403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/network-registration.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 6518968..8711670 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -704,7 +704,7 @@ static gboolean parse_nettime(GIsiSubBlockIter *iter,
 	if (time->utc & 0x80)
 		info->utcoff *=3D -1;
 =

-	info->dst =3D time->dst !=3D NET_INVALID_TIME ? time->dst : -1;
+	info->dst =3D time->dst !=3D NET_INVALID_TIME ? time->dst * 60 * 60 : -1;
 	return TRUE;
 }
 =

-- =

1.7.0.4


--===============5574354766967372403==--

