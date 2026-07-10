Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEC3DCDBC;
	Fri, 10 Jul 2026 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670158; cv=none; b=IR8U2wBrQxJ30kngTC8kJgm4yEl8h7v1CyqJG7y5QfMzuamAUFQLNF8b0p1MZJvyGrUBZ00b1kaC2P/TfpJuih/8h+/LAYGuTkd1ZipN+bemhfCjsmaUla2LxDghM2iE7lzYV+iTnxx2EfMhFEeFtdXxgvC0iJ9zbykXdLLQSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670158; c=relaxed/simple;
	bh=XMM32TQmGhcQpZYrMCkvDBvVP1LFoGU5DLiX20A91/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+IeBRrgUEaQHHJZUFqp+ne8cX2eM7P2yTANLpEBFxcgSChoq04W1UxkBI072h8sUv1miTXhfwN6FSMpg4i+Z5MzSsSjrSR/ENBwtcgN0u+RVraGhm4rURf1rwyqLUfWU0twDL27dM1z3UInDdiq0lF7r8UtntcnYdwr6iOcaqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GuJeenZ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuJeenZ7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dMMs182264;
	Fri, 10 Jul 2026 07:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TothW9MKlIfk3C3GAeZZ1/447cGxI39S5SR
	uSVUfI+Y=; b=GuJeenZ7Ia5Ywpneb0n5RW9PYfGgMlrzZ6VEFE4iqp4j/YR+Uee
	LED/Tif6zn+PSek+wKyUjzIBT2IrhoodVSwbXfVwu+le7EnYE4M5K6DW2HtfiSUH
	0ngfMelZxycfg2pVmw/afS3j+ciWmTtMMxslf7XCiyaKZPZYBTCllornXs5LZmlo
	TL5vzgA+4C+WNzfOcIF7iwU27FN0azFvxBx4MeLvD5jjg0E825sx6wuzcrvj0Rlq
	ct8PxRQpLCUaQ7JTY03LJgmLBufpCEBlflzU0L7SeVYgwywYFd535f1okrEEwOzj
	3h1HgkvaNIkGjS7p9iZ8/iHx9NDs+D75tHg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte21ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:55:54 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A7tqwN021767;
	Fri, 10 Jul 2026 07:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f6u8jq2jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:55:52 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66A7tqA4021761;
	Fri, 10 Jul 2026 07:55:52 GMT
Received: from bt-iot-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 66A7tpJQ021758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:55:52 +0000 (GMT)
Received: by bt-iot-sh03-lnx.qualcomm.com (Postfix, from userid 2385805)
	id 3377F43850; Fri, 10 Jul 2026 15:55:51 +0800 (CST)
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
To: luiz.dentz@gmail.com, denkenz@gmail.com
Cc: ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] gdbus: Skip BLE random-address devices and remove broad match rule
Date: Fri, 10 Jul 2026 15:55:48 +0800
Message-ID: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 48FWhjQD09g5rPSd9fqk_5DYOPGTeJwm
X-Proofpoint-ORIG-GUID: 48FWhjQD09g5rPSd9fqk_5DYOPGTeJwm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX1ObJohWILEC3
 lRUmDEYM6sW1S+jHQCiiit2NtPZISTF6KcttVqp7a6BylRxCkh8tBo52lJyLqksPFvBdfFsEEhC
 sga56qa761D4NLmNj8OzucXW8dsH5LbFvNQp+T81OyMbmNlsNrTeetcYPTCA0HKipaOdoJM7N2G
 PNjvQ7Anxuktw7pHY9VQLQ8ndvVeqEGYL4hP2tb9gnBGeGUKxhfC+AK6M+x4fpQXKVnTCP8nMGZ
 bIdB46mTTs3zQts0YAxwmJBuKcCRSedGhu7XBBZaP/0OybzQLm7tRtJRTIpRNbUdQSNFpM7WlAr
 jrTn93CR+5EIf3DgVxkyZd7ms3WJTj+gf4s/aoI+krMc5Ra04ee9arMK06A1rSEEfeiDkE2ESOM
 aslgY0nR1jPIGTMTI7H8Kt1xv5ikh/iDQQf6mb6kCSr6knwnS85Ftat9gkZRiMHpuPsvuPH83iZ
 bpGJgCy9qBnP/Rmzm8A==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50a58b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=epjkyemPI9OHKLGXjuYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX7oHvqNcivbeB
 MVu+ikRP1mr8sZt2D9Rzi5QV/KKTN79XKujQwwYI2IWUzIldR+mLXdpF9Xi8pRiMDVT09p5WNJx
 bEwuGdLmmsph56inxxNFr5FuTJ/gAlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100074

Two related changes to reduce dbus-daemon load caused by high-rate
BLE advertising signals:

1. In parse_properties(), skip creating a GDBusProxy for Device1
   objects whose AddressType is 'random' (BLE-only devices). Each
   proxy registers a per-device PropertiesChanged watch via
   g_dbus_add_properties_watch(); with hundreds of BLE peripherals
   advertising simultaneously, this results in hundreds of match rules
   and dbus-daemon routing thousands of RSSI PropertiesChanged signals
   per second to ofono, none of which ofono processes. The
   AddressType property is available in the InterfacesAdded dict at
   the time parse_properties() is called, so the check is reliable
   and race-free.

   BR/EDR devices (AddressType='public') are unaffected: their proxies
   are created as before, and the property_changed callback continues
   to receive Paired and ServicesResolved updates needed for HFP/HSP.

2. In g_dbus_client_new_full(), remove the broad
   type='signal',sender=<service>,path_namespace=<path> match rule.
   This rule was the sole feeder for the signal_func path in
   message_filter(). ofono never calls g_dbus_client_set_signal_watch()
   so signal_func is always NULL; the broad rule therefore served no
   purpose and caused dbus-daemon to route every bluetoothd signal
   (including all BLE PropertiesChanged) to ofono.

   InterfacesAdded and InterfacesRemoved are already covered by the
   precise watches registered via g_dbus_add_signal_watch() earlier in
   g_dbus_client_new_full(), so no functionality is lost.

Together these two changes prevent dbus-daemon from routing BLE
advertising PropertiesChanged signals to ofono entirely, eliminating
the dbus-daemon memory growth and bluetoothd socket backpressure seen
after hours of BLE scanning.

Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
---
 gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 48711ae8..dd3c17f9 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client, const char *path,
 	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
 		return;
 
+	/*
+	 * Skip BLE devices (AddressType='random') to avoid registering a
+	 * per-device PropertiesChanged watch for every advertising BLE
+	 * peripheral. ofono only needs BR/EDR devices for HFP/HSP; the
+	 * high-rate RSSI PropertiesChanged signals from BLE scanners cause
+	 * dbus-daemon memory bloat and socket backpressure in bluetoothd.
+	 *
+	 * The AddressType property is present in the InterfacesAdded dict
+	 * (iter) at this point, so it can be checked before proxy_new().
+	 */
+	if (g_str_equal(interface, "org.bluez.Device1") == TRUE) {
+		DBusMessageIter props, entry;
+		DBusMessageIter copy = *iter;
+
+		if (dbus_message_iter_get_arg_type(&copy) == DBUS_TYPE_ARRAY) {
+			dbus_message_iter_recurse(&copy, &props);
+			while (dbus_message_iter_get_arg_type(&props) ==
+						DBUS_TYPE_DICT_ENTRY) {
+				const char *key;
+				dbus_message_iter_recurse(&props, &entry);
+				dbus_message_iter_get_basic(&entry, &key);
+				if (g_str_equal(key, "AddressType") == TRUE) {
+					DBusMessageIter var;
+					const char *addr_type;
+					dbus_message_iter_next(&entry);
+					dbus_message_iter_recurse(&entry, &var);
+					dbus_message_iter_get_basic(&var,
+								&addr_type);
+					if (g_str_equal(addr_type,
+							"random") == TRUE)
+						return;
+					break;
+				}
+				dbus_message_iter_next(&props);
+			}
+		}
+	}
+
 	proxy = proxy_lookup(client, path, interface);
 	if (proxy) {
 		update_properties(proxy, iter, FALSE);
@@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
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
-- 
2.43.0

