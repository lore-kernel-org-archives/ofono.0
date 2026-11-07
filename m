Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068115;
	b=yRd63tCArHuxTo9cQCmSGYephswQppw26I7jO4oRxKOZZNtlMlASbRDKQy6hI5OQz0zU
	 bShinmcba9YF1DwUQoP2RLg+O+SLRQF676sDPxqNPz18kdW69HwHycXRUsR3cN5YgzQMO
	 9T8kXSFfw+yCvrQ8O7WPvU8dbl5pjrbwJyg8uzwukvkTVmxNzs/Vp0dohDmGYW10/ejG3
	 Pvw12lthOb9Q8ldNV1bCcKROojaP+vRdQscYMIAyV56b7Xf2d88KOqCk4qaxSE+mjrj6l
	 bIOev+5Nq/UVvaAu+taLbhJQq5CkHJicvcbKC6UlE8BEGMOWoMNr8j6m2+Nv+X5ukkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OY0JohdAFDNYxEcjBvgmZEDQp0DApnudL0NGxgT07qQ=;
	b=sc6Cny9lpMiZwFUZE0FqLCqRKOyyUpMJz+daQe/C5E8qCC5yKJ2hOTkh/lIBNF9asm3x
	 U25sYmCCch/0UZ19sOP53eVYt3MqFTiVCrXMB9kkEWA6v+EsBJ9wL3vBCl8SYbWjcDtOE
	 E9SLdAZ8HN7/sSJmTLJ+5/Zt8LMIE8T4GutH23x+Jeq5JU3HfvPDLcpvIExFEzAoWcB6D
	 kOUnNGJP4ANS1S+2ndKgTQ5xAK+5Oon+06vRM1ENREpAI2TIBXZkk12UbIPBsHZEFtJem
	 5y4GNTlkgRvZTfeM3T5Yq4f9h74ZjdTJ4xzjlK0vDRTDQER4gu9j+1NL9PbbL3fDJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKa5HjPU;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B77606AC14
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B77606AC14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKa5HjPU
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4910b863b84so292517f8f.0
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068113; x=1794672913; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OY0JohdAFDNYxEcjBvgmZEDQp0DApnudL0NGxgT07qQ=;
        b=zKa5HjPUyrl2Sd2vP+wSISv9kJdvlQHB+dUyLCHfnKpAsgZN6XkmcYjK5AgtACMqAr
         IcYACznge8hoFm/jaqj0SOHSdLEQAQaf0d8WQCAsRz6avv+M5ZIzMt6+W/NFpDDn2ws+
         s3CuwVswAAnbxJErT+TRvqKs+ssOF2U99lsl8hMrf7gl6o3XrZ4ARZIAeq5EelYnCSR+
         OZmcmE91ifrcqzB2IKZtPL8zj4jAf5ymuBuFXsnv7+6iwtttvW36LqWIMAD+rKf2tzpg
         DeeHbQQVoZoNJMqqakYtLrmDYE8wjEN7Xom7NPj0EKBdEsc53OMaguZ6fRttvacLrbsl
         US8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068113; x=1794672913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OY0JohdAFDNYxEcjBvgmZEDQp0DApnudL0NGxgT07qQ=;
        b=o8Hn66EVIaR8coRTySQQaWK6Uy6SMUiPIFdz166DSKcG+pHpmaF6yrHMwmYi2niP1L
         bBLAn+XWVcEfiNtaePKTko1ahfh0mNqeDz/Iy1aLVpp49vqRePsgbxmMhuNBu/9VUZ93
         T7EZhV3pHosoUd2VcipsjWOOtpjTcXs0aSuGyJGfNwZP0e2ICzJM3m205h6DzPO5FaJA
         NaNs8ODGQji6nrkObNLUqnalH2xZHapaoarM6RJGvmVN3pknJMxUh9AP0SwMjfxegJmL
         oSbWkFZulRjKi21krY8jr9gjHrdh8oeujpptj25a+DAvVIbTOlSOZrl8XDmjzAFPFGWs
         5inw==
X-Gm-Message-State: APuU4Z80ig5rS4s2RmGxrkkflRfE6xCVAXX5qU4Ason+RKOc3nJEdV9o
	uAFNg6ZumJpdZibEuNU+mjHQftEMmAGiTAbGGQ+9nPRLr0NlwHMyc14OwRjHYg==
X-Gm-Gg: AYBFou3dIhcFXjf1a+ERX1iS2V6ySuRPt7g/HpNRMVZZ/mkdS0tkvUxw7T6hUju7kge
	pESgE1nA0sGb+V9rBnDDEY1OtSLAhKKkfXIRQ4SXpSVTrfz6rYKGeVBPVsJ6M0PEgGOFBcSvR+W
	2j9PDq6JjAhd0OzIhnsm24ZpNHLjBtSkkeFqNFh+WdnGu36X16IGMDIpI89y3jDas36lD0xyRdt
	EZeaj1mMtqGIL9xayU0S2VzShEXn30R0g2g16H9kyAzDqEG+RUlnvJw3eo2JtA99snP+/Ubhsqe
	eNr/ZKapB0f3/JB5dgUSrEvyVc4iwF84ghlo54PGEopSokdQ0e2SOrqUt3a6UwNhPF2RZFMyaaG
	RtvDJgezce5tj7nwNOENI50ZPef6KqLge0xinju+kO2IsbAIaxFo2jHNq/RRf8TioMHJ8iyJtKJ
	TK5v5VJ+VEzwB6yl9FtfwtR+gF4fWmH60oGuOLpzMbpPa/sogn+pxOiXJk0WOz6HBD+e95bMBgJ
	vbIWe+3Zlxk16gY8gYW/2Pi1LbIb3ZNr9zT4Rw527jzctGIB4RRzj1nCvhNX9WsCl/MK8MBvhPe
	plS+k6etJXhd8wc7aZouVt5f9MQvI13IcuSr6h05glqiujlLQLA=
X-Received: by 2002:a05:6000:2dc3:b0:48e:7475:fe7b with SMTP id ffacd0b85a97d-49422f09dc3mr4054259f8f.6.1794068113123;
        Sat, 07 Nov 2026 08:15:13 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4932901d9c9sm9170932f8f.59.2026.11.07.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:10 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmimodem: Fix possible heap-based buffer overflow
Date: Sat,  7 Nov 2026 18:13:11 +0200
Message-Id: <20261107161311.471507-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The operator description length reported by the modem in a NAS network
scan result is not validated against the size of the destination
buffer, allowing a malicious modem to overflow the heap-allocated
operator list in scan_nets_cb().  Validate each network entry against
the actual TLV length and truncate the description copy to the maximum
operator-name length.

Fixes: ZDI-CAN-30144
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/qmimodem/network-registration.c | 32 +++++++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index 3c9df0c1..8d9bdeea 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -306,16 +306,33 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 
 	netlist = ptr;
 
+	if (len < sizeof(netlist->count)) {
+		CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+		return;
+	}
+
 	num = L_LE16_TO_CPU(netlist->count);
 	DBG("found %d operators", num);
-	offset = 2;
+	offset = sizeof(netlist->count);
 
 	list = l_new(struct ofono_network_operator, num);
 
 	for (i = 0; i < num; i++) {
 		const struct qmi_nas_network_info *netinfo = ptr + offset;
-		uint16_t mcc = L_LE16_TO_CPU(netinfo->mcc);
-		uint16_t mnc = L_LE16_TO_CPU(netinfo->mnc);
+		uint16_t mcc;
+		uint16_t mnc;
+		uint8_t desc_len;
+
+		if (offset + sizeof(*netinfo) > len ||
+				offset + sizeof(*netinfo) +
+						netinfo->desc_len > len) {
+			l_free(list);
+			CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+			return;
+		}
+
+		mcc = L_LE16_TO_CPU(netinfo->mcc);
+		mnc = L_LE16_TO_CPU(netinfo->mnc);
 
 		if (mcc > 999)
 			mcc = 999;
@@ -325,8 +342,13 @@ static void scan_nets_cb(struct qmi_result *result, void *user_data)
 
 		snprintf(list[i].mcc, OFONO_MAX_MCC_LENGTH + 1, "%03d", mcc);
 		snprintf(list[i].mnc, OFONO_MAX_MNC_LENGTH + 1, "%03d", mnc);
-		strncpy(list[i].name, netinfo->desc, netinfo->desc_len);
-		list[i].name[netinfo->desc_len] = '\0';
+
+		desc_len = netinfo->desc_len;
+		if (desc_len > sizeof(list[i].name) - 1)
+			desc_len = sizeof(list[i].name) - 1;
+
+		strncpy(list[i].name, netinfo->desc, desc_len);
+		list[i].name[desc_len] = '\0';
 
 		if (netinfo->status & 0x10)
 			list[i].status = 3;
-- 
2.25.1

