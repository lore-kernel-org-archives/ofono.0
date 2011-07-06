Content-Type: multipart/mixed; boundary="===============4036554028224930741=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 1/4] include: Add driver api for user confirmation
Date: Wed, 06 Jul 2011 03:06:10 -0700
Message-ID: <1309946773-7747-2-git-send-email-jeevaka.badrappan@linux.intel.com>
In-Reply-To: <1309946773-7747-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4036554028224930741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/stk.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/stk.h b/include/stk.h
index c276c84..9a63917 100644
--- a/include/stk.h
+++ b/include/stk.h
@@ -47,6 +47,7 @@ struct ofono_stk_driver {
 	void (*terminal_response)(struct ofono_stk *stk,
 					int length, const unsigned char *resp,
 					ofono_stk_generic_cb_t cb, void *data);
+	void (*user_confirmation)(struct ofono_stk *stk, gboolean confirm);
 };
 =

 int ofono_stk_driver_register(const struct ofono_stk_driver *d);
-- =

1.7.4.1


--===============4036554028224930741==--

