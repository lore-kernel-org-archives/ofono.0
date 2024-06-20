Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187C1AE0B4
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895116; cv=none; b=X3UE1gJGpIqM5DqSrWLONjQd1KkorXza0qRt8c7afhcf6VlbkmkTNUmMaPTLnsEBbojo6u6yz8ysSb70mYOg11G0BzeZguwnHfTEKrhw5b050yEjn4zliAp+VPBvcPrfasAO9pi8x1IdfJ48yzfHLJZYKh3dsLrYEL3mWYSHCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895116; c=relaxed/simple;
	bh=/bJIVDzUX2e5StEymqjn7ZCFKph0WNy6h/8JY7C7LB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvZhMmivTJqiEGCeVdIuAMa/gS40NdATIOxftlTFphs+fOryS5BV4lWSR1+LaGtgAsuHb/Wa+eloPrmkgbc5SB1vzvBIA62O1dQti0tZPRxEk47It/o3+bf4sNl1BBmv6o8iwcukyccJtSUkAAD/xN4yrLaRnwSKmhg4nKDGX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkhMpT0s; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkhMpT0s"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d21f253a53so425639b6e.2
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895114; x=1719499914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh4nL2Xqu/H5NtYMM7qVpf7I932OuBKzjLpQY+cEmLY=;
        b=gkhMpT0sxW/ZZ90EHk/nESrylDMGcQIeIz7g+4gudgL9sCdO3BxuAgmi11eiFXk38w
         kppxa+Su4LUj3ie5CDH/oOi5JBTbZm0aavS3oc7Nlty0u174e4OKNaW+Ky7xaCT5UHW+
         Q7FoJ+NZ/M65VGSZaQF3KpHYIxHDLzDv4dky+GT5PDCGsrpF1fR7C1KRMPLOmhWP2u/p
         4K4+9UIRHBks+KXkDjGQCQMJxWRd8ugdCqIOp8qwo76AtiV3ke3rDmtCabQlQBFnJcBv
         FU2+9kBb+KiQ9IkSnoEL4RjqY+oX2j2KOBN+aqJHVGAwWZZXdkOqnTQB/DNJJizyrEji
         Ujmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895114; x=1719499914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh4nL2Xqu/H5NtYMM7qVpf7I932OuBKzjLpQY+cEmLY=;
        b=S1m0KXba7ShssoUAJO0E/ikawuuHgSFSfo3RC9m8DYFjdMMi/8CtODnkRHUqeTL8SV
         Eq42IeqSQLe8vxCVRP4Mmy2K7VL0ntnz0vP7I4MwaNJs6WlKKeTg7BKJAJVm+LFDL+T8
         8PDJSlpZnH0r8B8Vehl6ixCReKVx+Lm/+PS/3iWndQ9sWsMwSVSZQd75EpFGR2zgBu8r
         ZXVNskq+gv8icDuV2CqsOzaF5mXdG00mwnmIuGQk0nVMk/ulNwivZSoAv4/StRz8CDng
         whxHfXSPVWW8/AxIcSBsnU5blz2MtS6LbIVSWylzJtIX5P+DPji923XePhvqcRDu97Og
         S0Qg==
X-Gm-Message-State: AOJu0Yx9r6XMIaLD0hLRxm2tqv05JEvGIzRmAyYX7mg4rpaxI2CNcbQC
	LOCdAzkqtRnbBvEMYhJLjmkam+pA7n32NYFZD1/K9lFHvVl6WDkL6Fm1CQ==
X-Google-Smtp-Source: AGHT+IHKFhnK/DATvOmZkHJSz+8h5/tWVGXUXrGBH9mtrgANJPVPKBGMMZ5eamo4B145qEX4TELiFQ==
X-Received: by 2002:a05:6808:220c:b0:3d2:281a:31b1 with SMTP id 5614622812f47-3d51ba9feb3mr6184843b6e.34.1718895113681;
        Thu, 20 Jun 2024 07:51:53 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:53 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 07/33] udevng: Use new qrtrqmi driver for MHI and SoC modems
Date: Thu, 20 Jun 2024 09:50:54 -0500
Message-ID: <20240620145139.1135899-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
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

