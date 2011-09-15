Content-Type: multipart/mixed; boundary="===============4945173019197650550=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 07/12] handsfree: Support for number requests (AT+BINP=1)
Date: Thu, 15 Sep 2011 18:34:38 +0200
Message-ID: <1316104483-13144-8-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4945173019197650550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/handsfree.h b/include/handsfree.h
index cd60975..18c6f26 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -30,11 +30,18 @@ extern "C" {
 =

 struct ofono_handsfree;
 =

+typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *error,
+					const struct ofono_phone_number *number,
+					void *data);
+
 struct ofono_handsfree_driver {
 	const char *name;
 	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
 			void *data);
 	void (*remove)(struct ofono_handsfree *hf);
+	void (*request_phone_number) (struct ofono_handsfree *hf,
+					ofono_handsfree_phone_cb_t cb,
+					void *data);
 };
 =

 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
-- =

1.7.6


--===============4945173019197650550==--

