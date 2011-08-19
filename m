Content-Type: multipart/mixed; boundary="===============1582294822744506896=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] try to re-attach GPRS after auto detached
Date: Fri, 19 Aug 2011 17:51:11 +0800
Message-ID: <1313747471-8397-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1582294822744506896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After receive "NW DETACH"/"ME DETACH" unsolicited message, try to re-attach
according current registration status. If it is not allowed, re-attach
action will be triggered when registration status changed.

---
 src/gprs.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index acbfa56..11dcc06 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2089,11 +2089,7 @@ void ofono_gprs_detached_notify(struct ofono_gprs *g=
prs)
 	gprs->driver_attached =3D FALSE;
 	gprs_attached_update(gprs);
 =

-	/*
-	 * TODO: The network forced a detach, we should wait for some time
-	 * and try to re-attach.  This might also be related to a suspend
-	 * event while voicecall is active.
-	 */
+	gprs_netreg_update(gprs);
 }
 =

 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
-- =

1.7.5


--===============1582294822744506896==--

