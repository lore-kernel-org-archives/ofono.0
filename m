Content-Type: multipart/mixed; boundary="===============7298267911501466835=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] hfpmodem: Fix g_at_chat leak
Date: Thu, 04 Aug 2011 14:48:02 +0200
Message-ID: <1312462082-16808-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7298267911501466835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/call-volume.c          |    1 +
 drivers/hfpmodem/network-registration.c |    1 +
 drivers/hfpmodem/voicecall.c            |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index df83657..c0c4869 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -206,6 +206,7 @@ static void hfp_call_volume_remove(struct ofono_call_vo=
lume *cv)
 =

 	ofono_call_volume_set_data(cv, NULL);
 =

+	g_at_chat_unref(vd->chat);
 	g_free(vd);
 }
 =

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 7d26424..6703885 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -331,6 +331,7 @@ static void hfp_netreg_remove(struct ofono_netreg *netr=
eg)
 =

 	ofono_netreg_set_data(netreg, NULL);
 =

+	g_at_chat_unref(nd->chat);
 	g_free(nd);
 }
 =

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 3c49870..9903db0 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1166,6 +1166,7 @@ static void hfp_voicecall_remove(struct ofono_voiceca=
ll *vc)
 =

 	ofono_voicecall_set_data(vc, NULL);
 =

+	g_at_chat_unref(vd->chat);
 	g_free(vd);
 }
 =

-- =

1.7.1


--===============7298267911501466835==--

