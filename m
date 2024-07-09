Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7954155316
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565451; cv=none; b=VuJlSwwJc/4v1YiWIKxGLc6+aNu8jdoZW/7uIE1b1/ZUYZw+JpCLYrgs260KW9kg1Z889L9z4uFW/Enh4c47FS0Y7hW9oWaL9+3NYJAnYwWm7WTkHcup10lNXjlGqsYKZZfcVkC2m0gMnZ+fTc78Wu5UNzx7x7neQphglFXOn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565451; c=relaxed/simple;
	bh=v0v7zU7SfV5hf7UJ7ywGy/Wso6ZtVANjHh6GDJxnbp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzX4qqfcxkALBR2MV0uF5NdqHV5eK2gGKGnKaCwe47/g6vxTB/0q1OArjnhSrG55U9rAWM4rlht8v7A2Z6MI9WRvY6lZ1aYpRivPt8XEV9P5k+i0gDSeZlIl+K4MqSer4etrPYgPPkdMTjBHhELuZ6PQi7e7moNIHZrSSfGrWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgwgTFt0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgwgTFt0"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-38b1ce72526so3889555ab.0
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565449; x=1721170249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiE7/RanaIDCqOfIBMI4yOLghOxvZGR+2aVfftt5bCU=;
        b=EgwgTFt0zh9g4P9nCyIkIq9b2gcsBafUZ9I18DTHVDi9ZDDHfNsw95ArdzCZxFN722
         xbjasvhWpXU2bHnBVNQ9YG63b3ALavEOoz80m1geulbfYi8HdmrJhFbiJgXUS3lsChz1
         KM/+vWPSEriBHBeXeBeeGJVZ0ZsaV3EKz7PKh9AaKzBbXlzL63P/FqeuCNZ2rT3F+JGx
         EEjEpU3P8CsCcdNo4S91AbbO6pN0XxmsPIr2fS6iXjw9bBjoGlltxHfgWB6y66L6SfCU
         d7uU2zuo38BDOBwX4jPPeo6xn5h0VwmTq3ic2y71QwzPCg/sQso57jWi2oiVAbvgQmG7
         lbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565449; x=1721170249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiE7/RanaIDCqOfIBMI4yOLghOxvZGR+2aVfftt5bCU=;
        b=QnG7iGFjg6kDE5AZMfhIWN8d//350cIBQ3ffvAGgU2DFDl832FItkSVup+Y7SaS2ic
         istrgwALJb0rPNgKdFSZSA9GP42kje5ov0p6JaW3QR37TaE11sjJFU4yoIMT/6zle9ud
         blZuKvssGweQvf3C5yaWzp9BY4P/wNixWKJrc+oeJu0hmf4Us1daeTmdrWug6LiwVnVN
         RPbNfoINRv60lZs9D4RLtR6lMLMU5WZAx5+ygmsCZqF+b/mqUJEZyy48/Jp9LyOmI35n
         hmKtokF02HdLRgw++wy5cLU3Q4ctt4TnSuE2v0edeocmBv+nXYzLdK/atCEWXDS6TdpF
         PWKg==
X-Gm-Message-State: AOJu0Ywf2BLEGSeidKp8OJYCWj4iQw1MbNfwn8yezVHZkDBG7Ehfppbv
	ZR6PZlqoEOOaMepdqAVh/L+GKX07q9PnokQ5CguQE8CWmURIOFFEMboTCQ==
X-Google-Smtp-Source: AGHT+IEdJaa4e0PFunwwn9ZmFGQtoB1VbJWHjFCTDO8EVjyS9aJOlRME3Ga4vd5AIzhsPz0sxVnxjA==
X-Received: by 2002:a05:6e02:1547:b0:374:6e8f:c760 with SMTP id e9e14a558f8ab-38a59d923dcmr44136545ab.20.1720565448658;
        Tue, 09 Jul 2024 15:50:48 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/11] gobi: Limit number of premultiplexed contexts to 4
Date: Tue,  9 Jul 2024 17:50:20 -0500
Message-ID: <20240709225047.1427626-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4 was chosen somewhat arbitrarily, but it is the maximum that the
qmi_wwan_q driver can support out of the box.  The only limit is the
number of clients under QMI.  Two WDS clients are typically required for
each active context, one for IPv4 and one for IPv6.  The total number of
clients cannot exceed 255 (uint8).
---
 plugins/gobi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 88e4c7fc4887..b6df849de47e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -55,6 +55,8 @@
 #define GOBI_VOICE	(1 << 6)
 #define GOBI_WDA	(1 << 7)
 
+#define MAX_CONTEXTS 4
+
 struct service_request {
 	struct qmi_service **member;
 	uint32_t service_type;
@@ -75,6 +77,7 @@ struct gobi_data {
 	int num_service_requests;
 	unsigned long features;
 	unsigned int discover_attempts;
+	uint8_t n_premux;
 	uint8_t oper_mode;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
@@ -124,6 +127,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	const char *ifname;
 	int ifindex;
 	const char *bus;
+	int n_premux;
 
 	DBG("%p", modem);
 
@@ -132,10 +136,11 @@ static int gobi_probe(struct ofono_modem *modem)
 	ifname = ofono_modem_get_string(modem, "NetworkInterface");
 	ifindex = ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	bus = ofono_modem_get_string(modem, "Bus");
+	n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
 
 	DBG("net: %s[%s](%d) %s", ifname, if_driver, ifindex, bus);
 
-	if (!if_driver || !ifname || !ifindex || !bus)
+	if (!if_driver || !ifname || !ifindex || !bus || n_premux < 0)
 		return -EPROTO;
 
 	data = l_new(struct gobi_data, 1);
@@ -145,6 +150,13 @@ static int gobi_probe(struct ofono_modem *modem)
 	else if (!strcmp(if_driver, "qmi_wwan"))
 		data->using_qmi_wwan = true;
 
+	if (n_premux > MAX_CONTEXTS) {
+		l_warn("NumPremuxInterfaces > %d, limiting to %d",
+				MAX_CONTEXTS, MAX_CONTEXTS);
+		n_premux = MAX_CONTEXTS;
+	}
+
+	data->n_premux = n_premux;
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	l_strlcpy(data->main_net_name,
@@ -753,7 +765,6 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 static void gobi_setup_gprs(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	int n_premux = ofono_modem_get_integer(modem, "NumPremuxInterfaces");
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	const char *interface;
@@ -770,7 +781,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	}
 
 	/* Simple case of 802.3 interface, no QMAP */
-	if (n_premux == 0) {
+	if (data->n_premux == 0) {
 		interface = ofono_modem_get_string(modem, "NetworkInterface");
 
 		gc = ofono_gprs_context_create(modem, 0, "qmimodem", -1,
@@ -793,7 +804,7 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 		ofono_modem_get_integer(modem, "MaxAggregationSize");
 	DBG("max_aggregation_size: %u", data->max_aggregation_size);
 
-	for (i = 0; i < n_premux; i++) {
+	for (i = 0; i < data->n_premux; i++) {
 		int mux_id;
 
 		sprintf(buf, "PremuxInterface%dMuxId", i + 1);
-- 
2.45.2

