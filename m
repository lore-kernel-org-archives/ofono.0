Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDE15B98E
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032693; cv=none; b=OLGBfkZ5uX6ddQHf+GDNOONJd9q9bh54LLBHPinlQ/QWZNfUDNIB+exLHJNfkJYNm5d7gK36/68UVfKm7NPtjMO4hoYVmVEESVWRbkA7XtKATbTMsZscLoWeuUgOndgS29z8BTqp8d0OXIrto4irXXr9PguC6qiMhncSNjN0ibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032693; c=relaxed/simple;
	bh=vfmPdbCFuX5OfVIYp7dZ7aoRSEr3WV1BeBepJ95sl1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uanwfOBTQkNdGSB0O1NPyA7Anlbj4WRZvC3evF5y7IN5/nhygJwwGXlyxYxgD3kRoCAvv5usyY4rGWrBC+7+v7fjjYLNGUwIQAfy6saEcF34J87mmOUSmSnpiYIMLGIzN6JkVZyeRr7yKo4qpFHKEY7z/xu5nUXwgFs57ibWZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/ZqMxOJ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/ZqMxOJ"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so1774145eaf.1
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032691; x=1715637491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yezz1QzPICQ6CPdtRMH3SXqKohdJsC/65gfQ71jQVGc=;
        b=J/ZqMxOJTnWHAcWeoCmXzcJ6hmRSd8wOrZfiKowwS3aoylC6HlputORAbQEqsBPKL3
         JjyRRzmjPskhboTVsM0zGt6SKiZazXnAf3Dk6bTfjp4dlWWdQSzMsXaIqltjml9lbcLx
         DDc8vCtfZf4u2+0iVmE4Xt1a6ERcsseGFhcCCBTR4b4H6wsj9xvaQGdPR6vmIFrn08wx
         VcUT+ap5cGrcIJ+FcJakGehAwAxuVH0wiljiooA9TH2m13/25rgnGWN8hEO9qKrrx44T
         4n5g+pPs7Fo7O4/4vpBkaB3PfwlvUzKd3hjdFb699YkyxWQKuvrjymH+bcjJqWm3wnQL
         C4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032691; x=1715637491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yezz1QzPICQ6CPdtRMH3SXqKohdJsC/65gfQ71jQVGc=;
        b=FX3+YP2cM5DTuEOT/rotouOlzaG38JJQLtWsEfPH1JrVdjh/bxXyvNhtxK0OAmmmgI
         eSF3MCHj13q9cn1E8fS5FFJRxVyxbrxLTqLj/QX8quQg28ef3bTb173NiGIQ0to8x7di
         BvmKErQcLgyaPogvAK2xa/IYD6d50SrEXQggDqDEg5qHnyvJeSpkQNYhFITBXvT+zl27
         uJnewqswMvAi2Elk6QFoscwaXEWsUpNfRbcDPJsAwkoOpDkax/lhqnCYFlPBn/o3Sie+
         WexnX5x8o0Xh6RqRoFOiARmcLwT2NZ62PLqBy5HU0jl7ycf6qsceLLQsVmfdVgZwNpxJ
         8NNg==
X-Gm-Message-State: AOJu0YxK9bqUoDIef0MJXCeAmJI0WaNLWz4wF/C4Y5eJycmjRY9Mt6/5
	7roc2kA5lfXJNp6CUDpkdgFJiMCkzAJ7UlEx/Y/ZPDr1nMw6lk8td9S3gw==
X-Google-Smtp-Source: AGHT+IGe/cpxuRuArNBxlWQkaqHaLdNcYdEzl6euJaPoXI3BtToZPTYprs1aaS17cL3BiW0PFb2JiA==
X-Received: by 2002:a4a:d07:0:b0:5af:739f:1b83 with SMTP id 7-20020a4a0d07000000b005af739f1b83mr11554455oob.0.1715032690824;
        Mon, 06 May 2024 14:58:10 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:10 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 7/8] qmi: gprs-context: Parse IPv6 context settings
Date: Mon,  6 May 2024 16:58:01 -0500
Message-ID: <20240506215804.57124-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506215804.57124-1-denkenz@gmail.com>
References: <20240506215804.57124-1-denkenz@gmail.com>
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
index 99d42e7b5e1f..21ef1237758e 100644
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
+	if (tlv && len == sizeof(struct in6_addr)) {
+		const struct in6_addr *dns1 = tlv;
+
+		inet_ntop(AF_INET6, dns1, dns1str, sizeof(dns1str));
+		dns[0] = dns1str;
+	}
+
+	tlv = qmi_result_get(result, RESULT_SECONDARY_DNS, &len);
+	if (tlv && len == sizeof(struct in6_addr)) {
+		const struct in6_addr *dns2 = tlv;
+
+		inet_ntop(AF_INET6, dns2, dns2str, sizeof(dns2str));
+		dns[1] = dns2str;
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

