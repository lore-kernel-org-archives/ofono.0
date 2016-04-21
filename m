Content-Type: multipart/mixed; boundary="===============2072087646418932196=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] gprs-context: fix don't use default ipv4 netmask
Date: Thu, 21 Apr 2016 08:33:56 +0530
Message-ID: <1461207836-10093-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2072087646418932196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/gprs-context.c |  3 ++-
 drivers/rilmodem/rilutil.c      | 51 ++++++++++++++++---------------------=
----
 2 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index 2bc6445..1e5f6ed 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -304,7 +304,8 @@ static void ril_setup_data_call_cb(struct ril_msg *mess=
age, gpointer user_data)
 			goto error_free;
 		}
 =

-		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
+		if (netmask)
+			ofono_gprs_context_set_ipv4_netmask(gc, netmask);
 =

 		ofono_gprs_context_set_ipv4_address(gc, split_ip_addr[0], TRUE);
 	}
diff --git a/drivers/rilmodem/rilutil.c b/drivers/rilmodem/rilutil.c
index dc9c3cc..44e5a9c 100644
--- a/drivers/rilmodem/rilutil.c
+++ b/drivers/rilmodem/rilutil.c
@@ -52,39 +52,28 @@ void decode_ril_error(struct ofono_error *error, const =
char *final)
 =

 gchar *ril_util_get_netmask(const gchar *address)
 {
-	char *result;
-
-	if (g_str_has_suffix(address, "/30")) {
-		result =3D PREFIX_30_NETMASK;
-	} else if (g_str_has_suffix(address, "/29")) {
-		result =3D PREFIX_29_NETMASK;
-	} else if (g_str_has_suffix(address, "/28")) {
-		result =3D PREFIX_28_NETMASK;
-	} else if (g_str_has_suffix(address, "/27")) {
-		result =3D PREFIX_27_NETMASK;
-	} else if (g_str_has_suffix(address, "/26")) {
-		result =3D PREFIX_26_NETMASK;
-	} else if (g_str_has_suffix(address, "/25")) {
-		result =3D PREFIX_25_NETMASK;
-	} else if (g_str_has_suffix(address, "/24")) {
-		result =3D PREFIX_24_NETMASK;
-	} else {
-		/*
-		 * This handles the case where the
-		 * Samsung RILD returns an address without
-		 * a prefix, however it explicitly sets a
-		 * /24 netmask ( which isn't returned as
-		 * an attribute of the DATA_CALL.
-		 *
-		 * TODO/OEM: this might need to be quirked
-		 * for specific devices.
-		 */
-		result =3D PREFIX_24_NETMASK;
-	}
+	if (g_str_has_suffix(address, "/30"))
+		return PREFIX_30_NETMASK;
+
+	if (g_str_has_suffix(address, "/29"))
+		return PREFIX_29_NETMASK;
+
+	if (g_str_has_suffix(address, "/28"))
+		return PREFIX_28_NETMASK;
+
+	if (g_str_has_suffix(address, "/27"))
+		return PREFIX_27_NETMASK;
+
+	if (g_str_has_suffix(address, "/26"))
+		return PREFIX_26_NETMASK;
+
+	if (g_str_has_suffix(address, "/25"))
+		return PREFIX_25_NETMASK;
 =

-	DBG("address: %s netmask: %s", address, result);
+	if (g_str_has_suffix(address, "/24"))
+		return PREFIX_24_NETMASK;
 =

-	return result;
+	return NULL;
 }
 =

 void ril_util_build_deactivate_data_call(GRil *gril, struct parcel *rilp,
-- =

1.9.1


--===============2072087646418932196==--

