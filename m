Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EC1DBB0C
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203001; cv=none; b=YRfeEj9XhPzWGb4yj34AzO0083CJqmgholYekNO+oNpP2q4IWSh7lJczToi1TAQoQ/GumtQsG95avcJ0UsVTThxjIcBqf+Ro35c8pracH1hBmZTdtq1yGXG606nSLF86IrPLc0pIQhTztRM1OaZexbFhOFX1LFA5NXRzwPvbHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203001; c=relaxed/simple;
	bh=+56cwjOCGqAJQ6m6XG5yU9SuwexjNDh8KBphcx+vT6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB552rSJNKBNfToqeH+Cw7splhm5cqnb7hozM5HN5szdZxhwngXgBxVhGZajD5iUPjiH0idO6rurlorUnlXJMzBnl63Bg0e4qDWLYfP3oS26uR+gmNWCXG+9r+5FcLqZ2m5UOL83VBz6W9OZd0YFWiZxcg8raqHcdiB75DoeIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byt1Q8Zj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byt1Q8Zj"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2965e65ce89so692420fac.3
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202999; x=1732807799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WAvHTKoCbo/9lNNRfkJ6qV4t0tbUTtEBytA+LmA3UQ=;
        b=Byt1Q8ZjLBCTGcqVRQWkvR8ZHVUU/wn3rmt8Y7tqvAtGqF0wZuM/rHfdTd1iUqMlKk
         yxjHt7YJCZi53dhV1H2pgnVp39PNJNy/TLQ6DyvlwrGfKDxxOAmOZQinRRTPYz6NGy3E
         HtbNsuX+ovEqq6SdTTK3xlIdyDGZjGOCbJrm/3khGZrMtpsogZxvPeCIhIOG1HsS8HS3
         rac4M2l8jZLI2duVk0KlJtqssh4UJOpbfJcZTRu0xQebsxILOD6kk3bMECXW9QW5/WBE
         irduLm1FsL8RPLmEAybh+B9Gd3jyrFbdaUvXaP6v+8yDRizxW0nVzzmJj8LB+WPZp5HM
         zEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202999; x=1732807799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WAvHTKoCbo/9lNNRfkJ6qV4t0tbUTtEBytA+LmA3UQ=;
        b=VcFPuC4j+r1ORBidKWqTd5T0lLtnxfv/GzXV57nZajR1zKEE+fl1WpxDT/voTZdG3K
         kO19BT7CAjVNc/S6lXbfvupddwN99UYqezr1sXZYevKUSkW08Ntjkcx8zNHsoM4zKtay
         aC7IY7T+cCyszyP0FgUVJSwFW53EMwC7iNqby4Jq+xCMG5yuDXBaSGNETTQcDXlX6whF
         kiSHxNSm3b5HpURteht6CrWlhOsMPTO/BqI5EWxLmwh1um1SB/x2N4wDZBRLUkw7jZgg
         /kJchgr17ZLfF70ZgpCA3UhFjioG+aDbxwPwebm9M55ovauP437dwdtwD1XADOICy5/j
         jpfg==
X-Gm-Message-State: AOJu0Yyb9BszV0xtWKL7TTmwjVu974obKqKlRvnwxbQL1FbOLju7SWMy
	hAT/lPOsvavqZahb2IRmZQExgZGoP2T0dE7HXWYW33NnKXouw15wnglCJQ==
X-Gm-Gg: ASbGncvfQNGEtnbpULrxai6noxaMtN/CWNVIvls/wYI5Hdq7Inlt4io1ddKaVITxUbv
	ZNXPFLRrhcQk+19Vj/iY7Xyw0ne87gymlDlqVR/GTryTEPaDsCb8vL3qzabdJFvqLMCFbr+JHBh
	R2ZYq7sqg8kvsLRkryPuqyv9D4iU3WvPsVP+tF2D5P22boTVjMAMrWCIdTxXLjDtaCkw6NxZyIN
	wNNSVc2/S8cUyWVwBHSs+4XlSSH7VarJZqcyiDUc4FJU86X7jT/y2coHq0LvLAwCESQ4xoYPgZv
	/UX9znbI4bB7qLaSTSrTp3X8
X-Google-Smtp-Source: AGHT+IGZTskXidZLEMM+sVPDkQxTnsrwVeWw/3WIXAqL1cBQdV/y+I/OLmta2I3FOWgmyfHpPwMKmA==
X-Received: by 2002:a05:6871:3429:b0:296:e365:d169 with SMTP id 586e51a60fabf-296e366292dmr6027227fac.8.1732202999032;
        Thu, 21 Nov 2024 07:29:59 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:58 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/10] qmimodem: wds: Add qmi_wds_ip_support_from_ofono
Date: Thu, 21 Nov 2024 09:29:37 -0600
Message-ID: <20241121152949.56962-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152949.56962-1-denkenz@gmail.com>
References: <20241121152949.56962-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used to convert from ofono context type enumeration to
QMI IP support enumeration reported by Get LTE Attach Parameters.
---
 drivers/qmimodem/wds.c | 14 ++++++++++++++
 drivers/qmimodem/wds.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/qmimodem/wds.c b/drivers/qmimodem/wds.c
index ced0c5e5308d..07c96d4fdc58 100644
--- a/drivers/qmimodem/wds.c
+++ b/drivers/qmimodem/wds.c
@@ -43,6 +43,20 @@ int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto)
 	return -ENOENT;
 }
 
+int qmi_wds_ip_support_from_ofono(enum ofono_gprs_proto proto)
+{
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IP:
+		return QMI_WDS_IP_SUPPORT_IPV4;
+	case OFONO_GPRS_PROTO_IPV6:
+		return QMI_WDS_IP_SUPPORT_IPV6;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return QMI_WDS_IP_SUPPORT_IPV4V6;
+	}
+
+	return -ENOENT;
+}
+
 int qmi_wds_parse_data_system_status(const void *dss, uint16_t len)
 {
 	const size_t network_info_size = sizeof(uint8_t) + 2 * sizeof(uint32_t);
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 64a18aa6d86e..9343d1f83665 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -155,6 +155,7 @@ enum qmi_wds_command {
 
 int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method);
 int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto);
+int qmi_wds_ip_support_from_ofono(enum ofono_gprs_proto proto);
 
 int qmi_wds_parse_data_system_status(const void *dss, uint16_t len);
 int qmi_wds_parse_extended_data_bearer_technology(const void *edbt,
-- 
2.47.0

