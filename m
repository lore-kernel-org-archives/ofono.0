Content-Type: multipart/mixed; boundary="===============1975182311597996137=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Clarify voicecall driver hold_all_active() semantics.
Date: Fri, 14 Jan 2011 17:16:11 +0200
Message-ID: <1295018171-2299-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1975182311597996137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 include/voicecall.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index e37d73b..f3c2bf4 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -76,7 +76,8 @@ struct ofono_voicecall_driver {
 	void (*hangup_all)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
 	/*
-	 * Holds all active and retrieves held or waiting calls, this usually
+	 * Holds all active calls and answers waiting call.  If there is
+	 * no waiting calls, retrieves held call.  This usually
 	 * corresponds to +CHLD=3D2
 	 */
 	void (*hold_all_active)(struct ofono_voicecall *vc,
-- =

1.7.1


--===============1975182311597996137==--

