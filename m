Content-Type: multipart/mixed; boundary="===============6956152861690055459=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 5/7] include: Add ECNR to handsfree driver
Date: Fri, 19 Apr 2013 14:34:42 -0300
Message-ID: <1366392884-7116-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366392884-7116-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6956152861690055459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch extends the handsfree driver adding echo canceling and noise
reduction callback to allow enabling or disabling this feature in the
audio gateway.
---
 include/handsfree.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/handsfree.h b/include/handsfree.h
index b5e0d5f..16d9be5 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -48,6 +48,9 @@ struct ofono_handsfree_driver {
 	void (*voice_recognition)(struct ofono_handsfree *hf,
 					ofono_bool_t enabled,
 					ofono_handsfree_cb_t cb, void *data);
+	void (*ecnr)(struct ofono_handsfree *hf,
+					ofono_bool_t enabled,
+					ofono_handsfree_cb_t cb, void *data);
 };
 =

 void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
-- =

1.7.11.7


--===============6956152861690055459==--

