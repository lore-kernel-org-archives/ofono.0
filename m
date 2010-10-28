Content-Type: multipart/mixed; boundary="===============6686817223313595491=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 1/4] stemodem: Add rtnl header file.
Date: Thu, 28 Oct 2010 16:03:58 +0200
Message-ID: <1288274641-4216-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6686817223313595491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Add new asynchronous rtnl interface for creating and deleting
CAIF Network interfaces.

Creation takes struct rtnl_req_param as input containing
ip type (v4/v6), channel id etc. The result is returned in
struct rtnl_rsp_param containing the interface name and
interface index.

---
 drivers/stemodem/rtnl.h |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 drivers/stemodem/rtnl.h

diff --git a/drivers/stemodem/rtnl.h b/drivers/stemodem/rtnl.h
new file mode 100644
index 0000000..566452b
--- /dev/null
+++ b/drivers/stemodem/rtnl.h
@@ -0,0 +1,41 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+struct rtnl_rsp_param {
+	int result;
+	gpointer user_data;
+	char ifname[IF_NAMESIZE];
+	int  ifindex;
+};
+
+struct rtnl_req_param {
+	void (*callback)(struct rtnl_rsp_param *param);
+	gpointer user_data;
+	int type;
+	int conn_id;
+	gboolean loop_enabled;
+};
+
+extern int rtnl_create_caif_interface(struct rtnl_req_param *req);
+extern int rtnl_delete_caif_interface(int ifid);
+
+extern int rtnl_init(void);
+extern void rtnl_exit(void);
+
-- =

1.6.3.3


--===============6686817223313595491==--

