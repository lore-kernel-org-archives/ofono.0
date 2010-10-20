Content-Type: multipart/mixed; boundary="===============2737985367801160006=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/2] voicecall: document voicecall driver methods
Date: Wed, 20 Oct 2010 18:54:04 +0300
Message-ID: <1287590045-23710-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2737985367801160006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 include/voicecall.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index 2356fcf..6fd75ec 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -67,6 +67,7 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 	void (*answer)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
+	/* Release active, alerting, dialing, or incoming calls */
 	void (*hangup_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
 	void (*hangup_all)(struct ofono_voicecall *vc,
@@ -75,8 +76,13 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 	void (*release_all_held)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
+	/* Release incoming or waiting calls */
 	void (*set_udub)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Release active, alerting, dialing, or incoming calls
+	 * and answer the waiting call.
+	 */
 	void (*release_all_active)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
 	void (*release_specific)(struct ofono_voicecall *vc, int id,
-- =

1.7.1


--===============2737985367801160006==--

