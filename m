Content-Type: multipart/mixed; boundary="===============8250265183547627267=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 5/7] include: Add EchoCancelingNoiseReduction to handsfree
 driver
Date: Tue, 23 Apr 2013 14:21:41 -0300
Message-ID: <1366737703-26883-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366737703-26883-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8250265183547627267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch extends the handsfree driver adding echo canceling and noise
reduction callback to allow disabling this feature in the audio gateway.
---
 include/handsfree.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/handsfree.h b/include/handsfree.h
index b5e0d5f..dde7000 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -48,6 +48,8 @@ struct ofono_handsfree_driver {
 	void (*voice_recognition)(struct ofono_handsfree *hf,
 					ofono_bool_t enabled,
 					ofono_handsfree_cb_t cb, void *data);
+	void (*disable_nrec)(struct ofono_handsfree *hf,
+					ofono_handsfree_cb_t cb, void *data);
 };
 =

 void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
-- =

1.7.11.7


--===============8250265183547627267==--

