Content-Type: multipart/mixed; boundary="===============1348059051599297098=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 3/6] atutil: Add logic for cgcontrdp to get address and netmask
Date: Fri, 01 Sep 2017 11:23:02 +0530
Message-ID: <1504245182-17949-3-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1504245182-17949-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1348059051599297098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 1487348..1067f20 100644
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
@@ -614,3 +615,46 @@ void at_util_sim_state_query_free(struct at_util_sim_s=
tate_query *req)
 =

 	g_free(req);
 }
+
+/*
+ * CGCONTRDP returns addr + netmask in the same string in the form
+ * of "a.b.c.d.m.m.m.m" for IPv4.
+ * TODO: Add logic for IPv6.
+ */
+int at_util_set_address_and_netmask(const char *addrnetmask, char *address,
+					char *netmask)
+{
+	char *dup =3D strdup(addrnetmask);
+	char *s =3D dup;
+
+	const char *addr =3D s;
+	const char *net =3D NULL;
+
+	int ret =3D -EINVAL;
+	int i;
+
+	/* Count 7 dots for ipv4, less or more means error. */
+	for (i =3D 0; i < 8; i++, s++) {
+		s =3D strchr(s, '.');
+
+		if (!s)
+			break;
+
+		if (i =3D=3D 3) {
+			/* set netmask ptr and break the string */
+			net =3D s + 1;
+			s[0] =3D 0;
+		}
+	}
+
+	if (i =3D=3D 7) {
+		strncpy(address, addr, strlen(addr));
+		strncpy(netmask, net, strlen(net));
+
+		ret =3D 0;
+	}
+
+	free(dup);
+
+	return ret;
+}
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 5cb88b7..cc8fc52 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -83,6 +83,9 @@ struct at_util_sim_state_query *at_util_sim_state_query_n=
ew(GAtChat *chat,
 						GDestroyNotify destroy);
 void at_util_sim_state_query_free(struct at_util_sim_state_query *req);
 =

+int at_util_set_address_and_netmask(const char *addrnetmask, char *address,
+						char *netmask);
+
 struct cb_data {
 	void *cb;
 	void *data;
-- =

1.9.1


--===============1348059051599297098==--

