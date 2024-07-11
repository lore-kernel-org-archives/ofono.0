Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9284047
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716580; cv=none; b=NSFqmWCR+UXF5hOiBCOVsGo6Bc2LAbkNWPJk4lmGeBqxCtmJKIORE0jJJkyQSRO86c6YZRvzXITqYFI/azcGSwsyhFTrChNHhEaK+5i2fYC/ygl0RGfF2Iir0DnJv6NDhPPZugUcCXaAh3StSzQUpsUpYWkFiz7dD+EVCh0FY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716580; c=relaxed/simple;
	bh=v0v7zU7SfV5hf7UJ7ywGy/Wso6ZtVANjHh6GDJxnbp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dvt+p890QzgmbYB9cX4R7AzIepxOzGgiIrG6jP6grGY+AXo5NtXB6Td4EWKQ8z0HgDLVME/orLjiz+WH49hooBOoMkfFukYDnl8gdEohgC41lcEba9Z+/IcnjWmdzBYvz2RgiBy8+7J/VekwJZ9XE0l5PFb4IHsNjtV/86pGl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPtnxgPC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPtnxgPC"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7036815bde7so607443a34.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716578; x=1721321378; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiE7/RanaIDCqOfIBMI4yOLghOxvZGR+2aVfftt5bCU=;
        b=fPtnxgPCOfuTueprG0ev4npsSOl/CdJ+S2ZPeRRAGWPkoGWmgzIl05fEGphuL4oGY7
         QcNoPaKoZOdqv+g/j58IVZ0V0vUF7VM1spXX34OAAgohg1D9RSDJLqA0muMNEXZc0ylD
         VbVDpL4AyQUA2Gyyo/gJ/YxjyRt3uAqzn+6DGU0Qw2yLBGzPXIHcodMc8HYHdr4GUQ9Y
         4OqLNJXb0j1Y7au2/Dir6v1v4Auj3qD8uzhPo6UATS95hrhTT8HDR1qVic2LIkrUO8Y9
         HEfG2RpD3s3PtAFsCWjn7poat0A7Colw7JeT9Ncm0XJC5wZejhH24K9P429kZyAdIEgN
         28Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716578; x=1721321378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiE7/RanaIDCqOfIBMI4yOLghOxvZGR+2aVfftt5bCU=;
        b=XNh00aOSdA8pmjLIyI69gyzND6K84WVa7r/PBfAqmqodxP3oZg5lxytO39IJ+uLN3K
         68T9CATMw7eJyznrSDvJ0KJkqb8rggjZjIM1JGz15vT014JeP8/urtEgYB3qe76mCk0d
         f/BWUZ3Ez4ijgtO7cGf0p5/LT/bLIdYJ1BmLDcwyWw8a92rkNzuzSkImfP17Kg3UdNEd
         Kgw5p8SiYdv82vhs7jEhxxFCyFHBr7bmTzebbVsKGcgzdiLKl6f2KsbfUWzZgUIihElt
         /ub2LMJ3Gli+WWTIXeju7OZWXuO147rXXEF/Eyw6ssbhTJajmI/ZTkHEILgIY7BaNLEv
         kJGw==
X-Gm-Message-State: AOJu0YxhMgGltUsxO6pInYAedrlkCNfCQtqVMm6zFBNyjyrgQ4srRKaS
	NqY93TepqPh27r9msgSqZRYE4oAyoF8+8ejjzjXyXILkr3FEPMnzws1ZjQ==
X-Google-Smtp-Source: AGHT+IEB/jtCj3jy9DC2bxqZl+7npsNUq+8sosMWXe5BL0NgHrbkCcyaHjZln62i3XgP15XPxTDbAQ==
X-Received: by 2002:a05:6830:4d1:b0:704:470d:638a with SMTP id 46e09a7af769-704470d68abmr8375938a34.3.1720716578107;
        Thu, 11 Jul 2024 09:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/11] gobi: Limit number of premultiplexed contexts to 4
Date: Thu, 11 Jul 2024 11:49:23 -0500
Message-ID: <20240711164936.1688973-1-denkenz@gmail.com>
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

