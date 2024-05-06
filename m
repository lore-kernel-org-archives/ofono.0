Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66315B54F
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028001; cv=none; b=mWQhsb9nsiJOVAoVjoXDcoNm/9qSl7Cy6w+NwxDJfoU3ovATGsiQ5naiqxxT6fbR1tfqydnmGqx3B3yQrLBtC6qsCoPOhRM2NgQAyoagA+GnqHZz4plbcTYf/5K0IWFhhBo76IEXZiNRiJhnG3vf/xZtaFhJmnAqaOwSE7VjiDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028001; c=relaxed/simple;
	bh=Tt1aSqDTUv5Y2PSAfgtLpOu+g3b/5j+as2ygg+5YTek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqMOGW0O7JiXq5G6wxV1ZKcWzgbMwSU+HVeFxpfFdRKr8zz5c6LlQIJ1QMtL+fkegaIr10L9PjB1p74djns9tqDQ8Dm3N97GZgqHCH2hI6CKFBOy86NTk/F3xvAm6TxIT1Yn//VXxJ9lPgICRpdDK4eQUZXICBQFB6qutNs25qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiyJFfgN; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiyJFfgN"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23eff8c9a1dso1380571fac.0
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027999; x=1715632799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4hi2yMVCMFpCThc6x9WbhJtpmYDPcwRS5/mvQxE2ds=;
        b=UiyJFfgNNisYWIAMKKeJoiwr+il4M91KJSS6fQ7dm/G+alGT3ttT5gvkUp5IHoJMz2
         3ZequonZtVohe1dmBFLdXgo8OzLVUnSARlTfCQRMLQA+a7aCa4lJQlAX03VCRXd0Ip6V
         pHxDHL4tcGA8Zh1+2d6/54otzt9V7mVRKW9gjjzw7SN3yzNK88gYILrcyS5EDeldyFhy
         AV4+o0gAwlVTX4UNYns6biQgdSrk7HHaDZy9rTavj4pK8I7Aj7ykyLRme8zG7xvrKR6k
         Hw+4KIQnVtRxrXwhIMIQefkyERepoMz8JlHwhi7e2GnIIcUS7r2DPjEWnIsS7PIfSyKm
         wsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027999; x=1715632799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4hi2yMVCMFpCThc6x9WbhJtpmYDPcwRS5/mvQxE2ds=;
        b=LEBBpNd5t/ZF1zC5iEwEBDdrd7Q8IPhuwcRBXwI1JejTN+ShkuN/vgHXsyEBD1/s/8
         DtPhTkyRz70BxyrXSnQEIxEWeE1lsN5ZCe15fL3nmUKPSZ/ZxhZUzw6vlDfCzQ68gqXf
         PgoUIJB4s5WkgDQ2uFOci2rhneBj6d71Wn4pm3Lbzj2iPCyVRBpwhWub848KFOxVif0d
         WZipTAEv13iBx/4GYJvEGDiGiuwz8chf9+PQgJVsnGxEt3S1KATTCAQDjdUJ8CsD+/kc
         YCT4kOWPNBcWx403BnM8fatjbda9UaNp5pd0LToHhqoJDyvQsiSVV0crI/ZN/4LedX5z
         AWtA==
X-Gm-Message-State: AOJu0YyXsKX9ijo+GcByk0VqmE3umUHoy+JzeGLsEfNVegk7OOHpl8Mn
	PCqmUZ6GaBxXNJowB6XrfO6/emaN+XuzJ935HRZa+bbHScL1Huvy2s7xtw==
X-Google-Smtp-Source: AGHT+IFqtQXzBbOaU+7R5KrYPY1qFDRw5tbGuIhaa94MKzLrIrbmejQ2T2a/ef1q0a2tygwQyK8yJQ==
X-Received: by 2002:a05:6870:8326:b0:23d:417c:675 with SMTP id p38-20020a056870832600b0023d417c0675mr15210719oae.41.1715027999405;
        Mon, 06 May 2024 13:39:59 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/8] qmi: gprs-context: Parse IPv6 context settings
Date: Mon,  6 May 2024 15:39:29 -0500
Message-ID: <20240506203952.55806-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506203952.55806-1-denkenz@gmail.com>
References: <20240506203952.55806-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to get_settings_ipv4, add get_settings_ipv6 function which
will parse the relevant TLVs present when GET_SETTINGS response
indicates IPv6 family is in use.
---
 drivers/qmimodem/gprs-context.c | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 99d42e7b5e1f..8a40f91d7871 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -78,6 +78,63 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 	}
 }
 
+static void get_settings_ipv6(struct ofono_gprs_context *gc,
+					struct qmi_result *result)
+{
+	static const uint8_t RESULT_IP_ADDRESS = 0x25;
+	static const uint8_t RESULT_GATEWAY = 0x26;
+	static const uint8_t RESULT_PRIMARY_DNS = 0x27;
+	static const uint8_t RESULT_SECONDARY_DNS = 0x28;
+	static const uint8_t RESULT_MTU = 0x29;
+	const char *dns[3] = { NULL, NULL, NULL };
+	char dns1str[INET6_ADDRSTRLEN];
+	char dns2str[INET6_ADDRSTRLEN];
+	char ipv6str[INET6_ADDRSTRLEN];
+	const void *tlv;
+	uint16_t len;
+	uint32_t mtu;
+
+	tlv = qmi_result_get(result, RESULT_IP_ADDRESS, &len);
+	if (tlv && len == sizeof(struct in6_addr) + 1) {
+		const struct in6_addr *ip = tlv;
+		uint8_t prefix_len = l_get_u8(ip + 1);
+
+		inet_ntop(AF_INET6, ip, ipv6str, sizeof(ipv6str));
+		ofono_gprs_context_set_ipv6_address(gc, ipv6str);
+		ofono_gprs_context_set_ipv6_prefix_length(gc, prefix_len);
+	}
+
+	tlv = qmi_result_get(result, RESULT_GATEWAY, &len);
+	if (tlv && len == sizeof(struct in6_addr) + 1) {
+		const struct in6_addr *gw = tlv;
+
+		inet_ntop(AF_INET6, gw, ipv6str, sizeof(ipv6str));
+		ofono_gprs_context_set_ipv6_gateway(gc, ipv6str);
+	}
+
+	tlv = qmi_result_get(result, RESULT_PRIMARY_DNS, &len);
+	if (tlv && len == sizeof(struct in6_addr) + 1) {
+		const struct in6_addr *dns1 = tlv;
+
+		inet_ntop(AF_INET6, dns1, dns1str, sizeof(dns1str));
+		dns[0] = dns1str;
+	}
+
+	tlv = qmi_result_get(result, RESULT_SECONDARY_DNS, &len);
+	if (tlv && len == sizeof(struct in6_addr) + 1) {
+		const struct in6_addr *dns2 = tlv;
+
+		inet_ntop(AF_INET6, dns2, dns2str, sizeof(dns2str));
+		dns[0] = dns2str;
+	}
+
+	if (dns[0])
+		ofono_gprs_context_set_ipv6_dns_servers(gc, dns);
+
+	if (qmi_result_get_uint32(result, RESULT_MTU, &mtu))
+		DBG("MTU: %u", mtu);
+}
+
 static void get_settings_ipv4(struct ofono_gprs_context *gc,
 					struct qmi_result *result)
 {
@@ -164,6 +221,7 @@ static void get_settings_cb(struct qmi_result *result, void *user_data)
 		get_settings_ipv4(gc, result);
 		break;
 	case QMI_WDS_IP_FAMILY_IPV6:
+		get_settings_ipv6(gc, result);
 		break;
 	default:
 		break;
-- 
2.45.0

