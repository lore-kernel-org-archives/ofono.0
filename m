Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388F15E5C2
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740960; cv=none; b=jKvr7KBCPBGWdUsBva7iO9FzfuWPPCV583CH7EXjwZGikeottL0R/wuj+EoHzwgLEIbVdVl9N/YVB97wCNyDK6EjeIAEggQDFKUlb2Je5hq7XyY1lISOBFhKq5oK45ZNPWcE2W1IMa7znOKvdtF6LD5d2c8k1u/ieIKgyFQl61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740960; c=relaxed/simple;
	bh=/bJIVDzUX2e5StEymqjn7ZCFKph0WNy6h/8JY7C7LB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUO6ZGEEG/YTHrtEjCCs5+jZ8S3Tkts4m6z8zyL9MuiD5wHrGE15ScSBmlxwbg6GI50AZgg3yBPIx8eI6k9JfoJ36piLuXznQ6btRmj4KwzMA/Bt9BM7Ml3ozxwxed5Z+GUr0tJgOHIB2hvQiOYTOkApeYCQCI6gNf6aSAcVDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW/IexrO; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW/IexrO"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24c9f628e71so3037609fac.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740958; x=1719345758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh4nL2Xqu/H5NtYMM7qVpf7I932OuBKzjLpQY+cEmLY=;
        b=QW/IexrOuQtBWRrXS9hY6zRYBNMcG+z5wX/j9FTidqipSVK2tve0RfewJs201tvAD6
         xKMaIR2AJSpjdeARYykZ7erbJV8mVNnB3eNF5IOHTW2tiHSXJJ/ghFLhtiqh60D3i0H4
         FyDCmk5tKAVYDUlVJs+eo1phXeYXjWIxKptvRrFlsn08bb14d76jdvtouehfraJn1v7a
         ItpU3LDEUeg6SaC41EuZz/iaRQOSQtIOpnkbDpIigXbZkNbSLhG7h6L9GGz0Z08IHx76
         HG3qqp5ajhpOj8hAsImtSoH1v/4sNZ5g1SLSDBDDi0w9c4f7PuRStUnrlm03DlXOlgD7
         Ip3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740958; x=1719345758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh4nL2Xqu/H5NtYMM7qVpf7I932OuBKzjLpQY+cEmLY=;
        b=CrTbkhGUUk1wxzRCnI0rbKULZ8yyXGT6F9z/SdKrUBOwtn+Cs8N3aI4CNRxFKZixd0
         Y7jO9OH5AcjnoE1MaKM3PJwZHrxL7MXTDTMa5np+4As9He1yaBdrFY4GicWs11uVQb3B
         jXW8u1ricq7BLN0mR4gkBM+r6LotSvTvi31InvS+Ok7ESxj+JZycxSouxIPpZ/xkh6/t
         qMlOOJcFIEDqQiCQY+YyaaxkouLXC2W71u156TobMMkdWYfMi45UL0c7Zq0cS4DpL2m0
         y6ohAji43nxr5S8Pm5uMm/6k59A3VasPbuEUgEJX87pfU9NoNu2GD9ZseF0Dd02xKTMG
         1mmw==
X-Gm-Message-State: AOJu0Ywz8lb+slSqK0RnT6Bu04DtNkMHfI3M5HCawfG2CskaTLH8I6By
	HifaVfXkoV0EkSFUDBp0ZrrmbETfoaPWlPx4FPcF+z1Vt5679jOlKuV+4Q==
X-Google-Smtp-Source: AGHT+IGH5kdRP1yVlE7OWpDRYbq//G2o0Bk8IOn36Oj2bDxPj7USRapXJhRVfXD8rRrHGEbnocfCgw==
X-Received: by 2002:a05:6870:f114:b0:259:ae42:ae33 with SMTP id 586e51a60fabf-25c94a05cdamr946147fac.24.1718740958144;
        Tue, 18 Jun 2024 13:02:38 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/33] udevng: Use new qrtrqmi driver for MHI and SoC modems
Date: Tue, 18 Jun 2024 15:01:49 -0500
Message-ID: <20240618200231.1129282-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new qrtrqmi driver only supports QRTR based devices, so drop the use
of DeviceProtocol modem attribute.
---
 plugins/udevng.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 0b3b9686166b..5ef0bc253562 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -278,8 +278,7 @@ static int setup_qmi_qrtr(struct modem_info *modem,
 		return -ENOTSUP;
 	}
 
-	ofono_modem_set_driver(modem->modem, "gobi");
-	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qrtr");
+	ofono_modem_set_driver(modem->modem, "qrtrqmi");
 
 	return setup_qmi_netdev(modem, net);
 }
@@ -309,7 +308,7 @@ static gboolean setup_gobi_qrtr_premux(struct modem_info *modem,
 	return TRUE;
 }
 
-static gboolean setup_gobi_qrtr(struct modem_info *modem)
+static gboolean setup_qrtrsoc(struct modem_info *modem)
 {
 	const struct device_info *ipa_info = NULL;
 	int premux_count = 0;
@@ -1798,7 +1797,7 @@ static struct {
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
-	{ "gobiqrtr",	setup_gobi_qrtr		},
+	{ "qrtrsoc",	setup_qrtrsoc		},
 	{ "mhi",	setup_mhi		},
 	{ }
 };
@@ -2487,7 +2486,7 @@ static void check_net_device(struct udev_device *device)
 
 	/* Collect all rmnet devices with this iflink under a common path. */
 	sprintf(path, "/embedded/qrtr/%s", iflink);
-	add_device(path, NULL, "gobiqrtr", NULL, NULL, MODEM_TYPE_EMBEDDED,
+	add_device(path, NULL, "qrtrsoc", NULL, NULL, MODEM_TYPE_EMBEDDED,
 							device, "qrtr");
 }
 
-- 
2.45.0

