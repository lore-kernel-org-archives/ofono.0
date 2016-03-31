Content-Type: multipart/mixed; boundary="===============0486880679217706495=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] devinfo: Add support of IMEISV
Date: Thu, 31 Mar 2016 13:02:45 +0530
Message-ID: <1459409565-1823-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0486880679217706495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/devinfo.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/devinfo.h b/include/devinfo.h
index a9acce9..9d1834f 100644
--- a/include/devinfo.h
+++ b/include/devinfo.h
@@ -46,6 +46,8 @@ struct ofono_devinfo_driver {
 			ofono_devinfo_query_cb_t cb, void *data);
 	void (*query_revision)(struct ofono_devinfo *info,
 			ofono_devinfo_query_cb_t cb, void *data);
+	void (*query_svn)(struct ofono_devinfo *info,
+			ofono_devinfo_query_cb_t cb, void *data);
 };
 =

 int ofono_devinfo_driver_register(const struct ofono_devinfo_driver *d);
-- =

1.9.1


--===============0486880679217706495==--

