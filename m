Content-Type: multipart/mixed; boundary="===============7410138063201498014=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] gprs-context: fix set ipv4 netmask for rilmodem
Date: Mon, 18 Apr 2016 20:45:07 +0530
Message-ID: <1460992507-31437-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7410138063201498014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/gprs-context.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index f0a687d..2bc6445 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -275,6 +275,7 @@ static void ril_setup_data_call_cb(struct ril_msg *mess=
age, gpointer user_data)
 	if (raw_addrs) {
 		char **ip_addrs =3D g_strsplit(raw_addrs, " ", 3);
 		char **split_ip_addr;
+		char *netmask;
 =

 		if (ip_addrs =3D=3D NULL || g_strv_length(ip_addrs) =3D=3D 0) {
 			g_strfreev(ip_addrs);
@@ -292,6 +293,9 @@ static void ril_setup_data_call_cb(struct ril_msg *mess=
age, gpointer user_data)
 		 * explicitly strip any prefix after calculating the netmask
 		 */
 		split_ip_addr =3D g_strsplit(ip_addrs[0], "/", 2);
+
+		netmask =3D ril_util_get_netmask(ip_addrs[0]);
+
 		g_strfreev(ip_addrs);
 =

 		if (split_ip_addr =3D=3D NULL ||
@@ -300,8 +304,7 @@ static void ril_setup_data_call_cb(struct ril_msg *mess=
age, gpointer user_data)
 			goto error_free;
 		}
 =

-		ofono_gprs_context_set_ipv4_netmask(gc,
-					ril_util_get_netmask(split_ip_addr[0]));
+		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
 =

 		ofono_gprs_context_set_ipv4_address(gc, split_ip_addr[0], TRUE);
 	}
-- =

1.9.1


--===============7410138063201498014==--

