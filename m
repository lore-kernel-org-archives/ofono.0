Content-Type: multipart/mixed; boundary="===============2850909902809897570=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 07/15] include: AG features added to handsfree public api
Date: Thu, 20 Oct 2011 18:38:12 +0200
Message-ID: <1319128700-15841-8-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2850909902809897570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/handsfree.h b/include/handsfree.h
index 4ffd673..4f6cbc0 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -50,6 +50,8 @@ struct ofono_handsfree_driver {
 					ofono_handsfree_cb_t cb, void *data);
 };
 =

+void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
+					unsigned int ag_features);
 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
 						ofono_bool_t enabled);
 void ofono_handsfree_set_voice_recognition(struct ofono_handsfree *hf,
-- =

1.7.6.4


--===============2850909902809897570==--

