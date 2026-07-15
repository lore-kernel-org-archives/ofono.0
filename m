Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4753D75CD;
	Wed, 15 Jul 2026 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106003; cv=none; b=lSjko1/2oysqrQsspOZGV8grFT+pNTL/SM2FIGY3QzU5a+fwYaj+lT1lgRAtzJxajPz00F8yfjBX31KJlQTV1zPwNLBlLjMZNacm15rpcesJWxytl8/JO5wb0353G8IUcm3umKjo8ZwvO6AXxrn1yqHF6pWirdCN9weCg4lbUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106003; c=relaxed/simple;
	bh=+1qISyU6qo1vcai9VfppmUA4ivvsbCgve8CmzvzMLhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFJMmemEqqveABtHcAiIQSd2KawKX1dE3sY+oN+bGZFQtHrkk8vArCTRzeDxWoopz0ls/ezhjLF4HEUiqVf8dZcJ2wM5DKRBQEgJI9lJA0G3ug04hwtcrpoIwrY1KH4iTSifVpNGt9O2VCtS1Z4ceDMF2lAoLqzUt1LnS9lhhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KLPKAKgu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KLPKAKgu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l4Rs2269538;
	Wed, 15 Jul 2026 08:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wAhmP1Pxi0J2gwO3sy6FgLEIBPlAqjvtB/b
	vK260T3o=; b=KLPKAKguCux7lX/R2oBZuqWPrpffuWGAp/3c0x6gr6rmjRPlIYb
	KS9SPosIGC38Z3gMAxrRLf84xyL45wG+N6J+p7P7yL8dDzRpbO7bbsAGx8lGrL7t
	QbezKP/2oXOB7HEUqE5NsYrBp2AZgsn2wQrnzwUtSc7vbHxx4En/q+wVMzlc7vjT
	VON9Vtf/uHkJ3sqW3GQpl5PRtATAFijqswWLpviOXSfKLf1hshsCdv2MuMNg0Xne
	9C+s04LPuBspphqbxF6aejnn5Ba3ipDTffT9YndgBKXcBg/Mi0Be35C7tQV/WZId
	rDKkkjGNZv/reJErf0MT27iVYqAwmBO+znQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mjubr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 08:59:57 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66F8xsMe020100;
	Wed, 15 Jul 2026 08:59:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fbewjerqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 08:59:54 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66F8xsY9020091;
	Wed, 15 Jul 2026 08:59:54 GMT
Received: from bt-iot-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 66F8xswE020089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 08:59:54 +0000 (GMT)
Received: by bt-iot-sh03-lnx.qualcomm.com (Postfix, from userid 2385805)
	id 6CA9243B04; Wed, 15 Jul 2026 16:59:53 +0800 (CST)
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
To: luiz.dentz@gmail.com, denkenz@gmail.com
Cc: ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v2] gdbus: Remove broad match rule and add proxy filter support
Date: Wed, 15 Jul 2026 16:59:50 +0800
Message-ID: <20260715085950.4079331-1-xiuzhuo.shang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4NiBTYWx0ZWRfXybvIn3pe84lG
 VBLM8EIQbFxhweT4q3xkhBG0Or4GCt1WV9Difg/4ls8dc8TtzWjytWlkwJej1PvPdzFPXjCGA6Y
 sH3gpzOdJWpv/cz1Vl4vn1VQnbUQHGQmC7s3HuCD11Uaqk0f9QOfgyN4lKiHoUdxDbffVZ/Oq5D
 13Hil1t4GuI8SmqO7YBDfK7u2/FnPLJpX7KVh3AiQhcpDisZGVhj/JtfKwgqIqOuJk4+HEtDNky
 h0fkEY+/OiVxxFI40nERoGzNbbWbv/gp/3x5S06b7WbedmM9q80DCYjzQrEX5qsxOG87MV8hSDO
 BNbKtelq2FkAPPTmXHDs8QckCT0a3IhwSAyNHKFN8rpAvak3bqrgKkwJ6Ys0U4lqXWGnS2MmzwU
 isAoy/YylIDoTJ/1E8NqcHErI/RJQhxoZ7qaKCWUPhzUsMPOEZwFfBJB09VHQPTwaBuyhlVcbHV
 KBfBgNdPNZYecaPYaLQ==
X-Proofpoint-ORIG-GUID: JahX4u66iUhyr5Z8Ay1Oi5U86pv2rrFm
X-Proofpoint-GUID: JahX4u66iUhyr5Z8Ay1Oi5U86pv2rrFm
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a574c0d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=810EU949uLQ0sYvCpIcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4NiBTYWx0ZWRfXyQgmO3FVVibS
 fMbgQM7+VAjdAKI7hlAOli03Z9DrbWjCKuRhwhXFZY821nJtJF+zCmnv7wVS+WRr27ib+cDB3rl
 8I5vWVUh2R9gauQ4FEFMJnteV30wmQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150086

Problem
-------
On embedded platforms running continuous BLE scanning, bluetoothd
eventually stalls with its D-Bus socket to dbus-daemon full. strace
on a hung bluetoothd shows a repeating pattern:

  sendmsg(7, {org.bluez.Device1 PropertiesChanged}, MSG_NOSIGNAL)
      = -1 EAGAIN (Resource temporarily unavailable)
  ppoll([{fd=7, events=POLLOUT}], 1, {tv_sec=0, tv_nsec=0}) = 0 (Timeout)

fd=7 never becomes writable; bluetoothd's GMainLoop remains stuck
waiting for POLLOUT and cannot dispatch any further D-Bus events,
making the daemon appear hung and unresponsive to commands.

The backpressure chain that causes this:
  1. BLE scanning generates high-rate PropertiesChanged(RSSI) signals
     (~400/s with typical BLE traffic).
  2. ofono's broad path_namespace='/' match rule causes dbus-daemon to
     route all these signals to ofono even though ofono has no use for
     BLE RSSI data.
  3. ofono's single-threaded GLib loop cannot consume them fast enough;
     undelivered messages accumulate inside dbus-daemon (457 MB
     observed after ~3 hours of scanning).
  4. dbus-daemon, busy draining its write queue toward ofono, stops
     reading from bluetoothd's socket in time; bluetoothd's kernel
     send buffer fills up and sendmsg() returns EAGAIN.
  5. With POLLOUT registered on fd=7, bluetoothd's GMainLoop stalls
     and can no longer send D-Bus replies or signals.

Fix
---
Three related changes:

1. Remove the broad type='signal',sender=<svc>,path_namespace=<path>
   match rule from g_dbus_client_new_full(). This rule was the sole
   feeder for the signal_func path in message_filter(). ofono never
   calls g_dbus_client_set_signal_watch() so signal_func is always
   NULL; the broad rule therefore served no purpose and caused
   dbus-daemon to route every bluetoothd signal to ofono.

2. Remove the now-empty match_rules GPtrArray infrastructure
   (field declaration, init, AddMatch loop, RemoveMatch loop, free).
   No match rules are added to this array any more.

3. Add a generic GDBusProxyFilterFunction callback and
   g_dbus_client_set_proxy_filter() API to GDBusClient. The filter
   is called from parse_properties() before proxy_new(), so a FALSE
   return prevents both proxy creation and per-device
   PropertiesChanged watch registration. This keeps all BlueZ-
   specific logic out of the gdbus layer.

   Use this in hfp_hf_bluez5.c to skip Device1 proxies for BLE
   random-address devices: ofono only needs BR/EDR (AddressType=
   'public') devices for HFP/HSP. Skipping BLE proxies prevents
   dbus-daemon from registering per-device PropertiesChanged match
   rules for advertising peripherals and eliminates the remaining
   RSSI signal delivery to ofono.

Together these changes prevent dbus-daemon from routing BLE
advertising signals to ofono, breaking the backpressure chain:
dbus-daemon memory stops growing, its write queue drains, and
bluetoothd's send buffer clears so that sendmsg() no longer returns
EAGAIN and the GMainLoop stall is resolved.

Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
---
Changes in v2:
 - Drop Change 1 (BLE address-type filter in parse_properties()) per
   review feedback; BlueZ-specific logic does not belong in the gdbus
   layer.
 - Add generic GDBusProxyFilterFunction callback and
   g_dbus_client_set_proxy_filter() API to GDBusClient. The filter is
   invoked before proxy_new() so a FALSE return prevents both proxy
   creation and per-device PropertiesChanged watch registration.
 - Use the new filter in hfp_hf_bluez5.c to skip Device1 proxies for
   BLE random-address devices, keeping all BlueZ-specific logic in the
   plugin as suggested.
 - Remove now-empty match_rules GPtrArray infrastructure (field,
   init, AddMatch loop, RemoveMatch loop, free) and unused variables.
 - Link to v1:
   https://lore.kernel.org/ofono/20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com/

 gdbus/client.c          | 45 +++++++++++++++++++++--------------------
 gdbus/gdbus.h           |  8 ++++++++
 plugins/hfp_hf_bluez5.c | 38 ++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 48711ae8..fa2e75c0 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -46,7 +46,6 @@ struct GDBusClient {
 	guint watch;
 	guint added_watch;
 	guint removed_watch;
-	GPtrArray *match_rules;
 	DBusPendingCall *pending_call;
 	DBusPendingCall *get_objects_call;
 	GDBusWatchFunction connect_func;
@@ -61,6 +60,8 @@ struct GDBusClient {
 	GDBusClientFunction ready;
 	void *ready_data;
 	GDBusPropertyFunction property_changed;
+	GDBusProxyFilterFunction proxy_filter;
+	void *filter_user_data;
 	void *user_data;
 	GList *proxy_list;
 };
@@ -943,6 +944,14 @@ static void parse_properties(GDBusClient *client, const char *path,
 		return;
 	}
 
+	if (client->proxy_filter) {
+		DBusMessageIter copy = *iter;
+
+		if (!client->proxy_filter(client, path, interface,
+					&copy, client->filter_user_data))
+			return;
+	}
+
 	proxy = proxy_new(client, path, interface);
 	if (proxy == NULL)
 		return;
@@ -1211,7 +1220,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
 							const char *root_path)
 {
 	GDBusClient *client;
-	unsigned int i;
 
 	if (!connection || !service)
 		return NULL;
@@ -1232,9 +1240,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
 	client->root_path = g_strdup(root_path);
 	client->connected = FALSE;
 
-	client->match_rules = g_ptr_array_sized_new(1);
-	g_ptr_array_set_free_func(client->match_rules, g_free);
-
 	client->watch = g_dbus_add_service_watch(connection, service,
 						service_connect,
 						service_disconnect,
@@ -1255,14 +1260,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
 						"InterfacesRemoved",
 						interfaces_removed,
 						client, NULL);
-	g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
-				"sender='%s',path_namespace='%s'",
-				client->service_name, client->base_path));
-
-	for (i = 0; i < client->match_rules->len; i++) {
-		modify_match(client->dbus_conn, "AddMatch",
-				g_ptr_array_index(client->match_rules, i));
-	}
 
 	return g_dbus_client_ref(client);
 }
@@ -1279,8 +1276,6 @@ GDBusClient *g_dbus_client_ref(GDBusClient *client)
 
 void g_dbus_client_unref(GDBusClient *client)
 {
-	unsigned int i;
-
 	if (client == NULL)
 		return;
 
@@ -1297,13 +1292,6 @@ void g_dbus_client_unref(GDBusClient *client)
 		dbus_pending_call_unref(client->get_objects_call);
 	}
 
-	for (i = 0; i < client->match_rules->len; i++) {
-		modify_match(client->dbus_conn, "RemoveMatch",
-				g_ptr_array_index(client->match_rules, i));
-	}
-
-	g_ptr_array_free(client->match_rules, TRUE);
-
 	dbus_connection_remove_filter(client->dbus_conn,
 						message_filter, client);
 
@@ -1396,3 +1384,16 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
 
 	return TRUE;
 }
+
+gboolean g_dbus_client_set_proxy_filter(GDBusClient *client,
+					GDBusProxyFilterFunction proxy_filter,
+					void *user_data)
+{
+	if (client == NULL)
+		return FALSE;
+
+	client->proxy_filter = proxy_filter;
+	client->filter_user_data = user_data;
+
+	return TRUE;
+}
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d99c2549..cc3c4e16 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -347,6 +347,11 @@ typedef void (* GDBusClientFunction) (GDBusClient *client, void *user_data);
 typedef void (* GDBusProxyFunction) (GDBusProxy *proxy, void *user_data);
 typedef void (* GDBusPropertyFunction) (GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data);
+typedef gboolean (* GDBusProxyFilterFunction) (GDBusClient *client,
+					const char *path,
+					const char *interface,
+					DBusMessageIter *iter,
+					void *user_data);
 
 gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
 			GDBusPropertyFunction function, void *user_data);
@@ -377,6 +382,9 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
 					GDBusProxyFunction proxy_removed,
 					GDBusPropertyFunction property_changed,
 					void *user_data);
+gboolean g_dbus_client_set_proxy_filter(GDBusClient *client,
+					GDBusProxyFilterFunction proxy_filter,
+					void *user_data);
 
 #ifdef __cplusplus
 }
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 5ad1674f..141dc5c4 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -791,6 +791,43 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	device_changed(proxy, path);
 }
 
+static gboolean proxy_filter(GDBusClient *client, const char *path,
+				const char *interface, DBusMessageIter *iter,
+				void *user_data)
+{
+	DBusMessageIter props, entry;
+
+	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) == FALSE)
+		return TRUE;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return TRUE;
+
+	dbus_message_iter_recurse(iter, &props);
+
+	while (dbus_message_iter_get_arg_type(&props) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+
+		dbus_message_iter_recurse(&props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		if (g_str_equal(key, "AddressType") == TRUE) {
+			DBusMessageIter var;
+			const char *addr_type;
+
+			dbus_message_iter_next(&entry);
+			dbus_message_iter_recurse(&entry, &var);
+			dbus_message_iter_get_basic(&var, &addr_type);
+
+			return !g_str_equal(addr_type, "random");
+		}
+
+		dbus_message_iter_next(&props);
+	}
+
+	return TRUE;
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -844,6 +881,7 @@ static int hfp_init(void)
 	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, NULL,
 						property_changed, NULL);
+	g_dbus_client_set_proxy_filter(bluez, proxy_filter, NULL);
 
 	ofono_handsfree_audio_ref();
 
-- 
2.43.0

