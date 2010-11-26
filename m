Content-Type: multipart/mixed; boundary="===============0360121454209736302=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] call-volume: Remove extra line at EOF
Date: Fri, 26 Nov 2010 12:59:38 -0800
Message-ID: <1290805178-5904-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0360121454209736302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-volume.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/call-volume.c b/src/call-volume.c
index 3c172ce..6411467 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -430,4 +430,3 @@ void *ofono_call_volume_get_data(struct ofono_call_volu=
me *cv)
 {
 	return cv->driver_data;
 }
-
-- =

1.7.0.4


--===============0360121454209736302==--

