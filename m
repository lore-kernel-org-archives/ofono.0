Content-Type: multipart/mixed; boundary="===============6633904348546797390=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 4/6] api: Remove deregister from modem driver API
Date: Wed, 19 Jan 2011 23:53:53 +0200
Message-ID: <1295474035-7142-5-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6633904348546797390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/netreg.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/netreg.h b/include/netreg.h
index a88301d..26a3442 100644
--- a/include/netreg.h
+++ b/include/netreg.h
@@ -84,8 +84,6 @@ struct ofono_netreg_driver {
 	void (*register_manual)(struct ofono_netreg *netreg,
 				const char *mcc, const char *mnc,
 				ofono_netreg_register_cb_t cb, void *data);
-	void (*deregister)(struct ofono_netreg *netreg,
-			ofono_netreg_register_cb_t cb, void *data);
 	void (*strength)(struct ofono_netreg *netreg,
 			ofono_netreg_strength_cb_t, void *data);
 };
-- =

1.7.1


--===============6633904348546797390==--

