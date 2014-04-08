Content-Type: multipart/mixed; boundary="===============2840316454499986479=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH 2/4] include: Add subscriber number to handsfree API
Date: Tue, 08 Apr 2014 09:21:45 +0100
Message-ID: <1396945307-12195-3-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1396945307-12195-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2840316454499986479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/handsfree.h b/include/handsfree.h
index 929fb32..9f4d0e2 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -36,12 +36,18 @@ typedef void (*ofono_handsfree_cb_t)(const struct ofono=
_error *error,
 typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *error,
 					const struct ofono_phone_number *number,
 					void *data);
+typedef void (*ofono_handsfree_cnum_query_cb_t)(const struct ofono_error *=
error,
+				int total,
+				const struct ofono_phone_number *numbers,
+				void *data);
 =

 struct ofono_handsfree_driver {
 	const char *name;
 	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
 			void *data);
 	void (*remove)(struct ofono_handsfree *hf);
+	void (*cnum_query)(struct ofono_handsfree *hf,
+				ofono_handsfree_cnum_query_cb_t cb, void *data);
 	void (*request_phone_number) (struct ofono_handsfree *hf,
 					ofono_handsfree_phone_cb_t cb,
 					void *data);
-- =

1.7.11.7


--===============2840316454499986479==--

