Content-Type: multipart/mixed; boundary="===============1034168868839854554=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 1/4] atutil: Add logic for cgcontrdp to get address and netmask
Date: Wed, 13 Sep 2017 07:58:41 +0530
Message-ID: <1505269724-19622-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1034168868839854554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 1487348..6f4e8a2 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -27,6 +27,7 @@
 #include <gatchat.h>
 #include <string.h>
 #include <stdlib.h>
+#include <errno.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/log.h>
@@ -614,3 +615,42 @@ void at_util_sim_state_query_free(struct at_util_sim_s=
tate_query *req)
 =

 	g_free(req);
 }
+
+/*
+ * CGCONTRDP returns addr + netmask in the same string in the form
+ * of "a.b.c.d.m.m.m.m" for IPv4.
+ * address/netmask must be able to hold
+ * 255.255.255.255 + null =3D 16 characters
+ */
+int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
+						char *address, char *netmask)
+{
+	const char *s =3D addrnetmask;
+	const char *net =3D NULL;
+
+	int ret =3D -EINVAL;
+	int i;
+
+	/* Count 7 dots for ipv4, less or more means error. */
+	for (i =3D 0; i < 9; i++, s++) {
+		s =3D strchr(s, '.');
+
+		if (!s)
+			break;
+
+		if (i =3D=3D 3) {
+			/* set netmask ptr and break the string */
+			net =3D s + 1;
+		}
+	}
+
+	if (i =3D=3D 7) {
+		memcpy(address, addrnetmask, net - addrnetmask);
+		address[net - addrnetmask - 1] =3D '\0';
+		strcpy(netmask, net);
+
+		ret =3D 0;
+	}
+
+	return ret;
+}
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 5cb88b7..7113a4c 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -83,6 +83,9 @@ struct at_util_sim_state_query *at_util_sim_state_query_n=
ew(GAtChat *chat,
 						GDestroyNotify destroy);
 void at_util_sim_state_query_free(struct at_util_sim_state_query *req);
 =

+int at_util_get_ipv4_address_and_netmask(const char *addrnetmask,
+						char *address, char *netmask);
+
 struct cb_data {
 	void *cb;
 	void *data;
-- =

1.9.1


--===============1034168868839854554==--

