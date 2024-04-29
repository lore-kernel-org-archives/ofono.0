Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE178288A
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406255; cv=none; b=XQGdF4v9CxEO/BMswWaEAw6rY0cW2to2f8rihGObqD3B/AxHeVosJrXzu9ki/peWf93iI3lsVH1Eti5Bb+DnHinOS4O4C+RbQJe5PF0bdrJb701MnicCOktbebK0Ql4dYtxRK6EcAw/XPrhqO0/IdHrgZGs9ffMboTnbvaRGQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406255; c=relaxed/simple;
	bh=uliAgvjhsAMzYZC0t7Pa1a1e6Md9IR252MVQ77hako0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRxO/Ok/k1QrtGX8fWuJv1ABD4jA0p+XaaLt0GyTnzPstJmIun97EFrW1F9VaEf5Pq72FLcKLP+0pJUPm76g1i1A974le70yWLh9uWZoO/woZZ1D068xG6B0SnyUqyyQZxBgxGAIV1sAwXwvb7vajzidcdw2+Um8yKDl3Nr7jQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE1Gdapf; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE1Gdapf"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c8641b41e7so850349b6e.3
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406253; x=1715011053; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XVJbL8UZouE2EyL/H28wnWIf+TCjgp/mCRYks9znNY=;
        b=OE1GdapfFzRLxaZntQJRL46QWa8Tbuamc6sfzVAONUEVQrqoc02yHTEINjL5DT0Trb
         cnO2PhjCfmC+oaK7iJY0vUNndmWSvZHHDreIaVdU7Uxly4Vpx4gN4AdIc4ZIwGpRi7gf
         rmurRS7D0rIwgOM6X1sLFYrLnA4kZ5e/Off+a6YLXs4MvCP7DJkHcFfwqDhnHI2Oz51v
         IeSm4kQeH5f9+ZSihpCFlAg+2cXdJdFUDKkbA3by2YCUvKYTeTA42VhCoQRRLIh/rO7v
         EC7sV2UrwrtVrnT6v+xQ+8uVUytdypoxQzLWDELTxg5rp/4NFcjsqDBofaaIKWHgUnet
         k4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406253; x=1715011053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XVJbL8UZouE2EyL/H28wnWIf+TCjgp/mCRYks9znNY=;
        b=sOjRunuRaO9UslYkM3kbX6UtHebLUj5hoITz2va+G8zh7SMDRRNAtDgaz2oI3eNQ0D
         E1X0f/k6q+KjCiB7Sh8Rhbr1RrbH6QXe5a8KjvRgRC+nidULC2B62mUae/r2AzXi3JDy
         nl6GFCH69VVj/QhzawOtYsqr82Ybbgnm7EUJAmCpM2bATjdSORhSvkEIQrbd9EG/IUnU
         0aXbnRgYUW/oYcrcuLRSyezCRA3ZbWfovMh5GIL50Iez97H9xeSw3rlpGJh38yugKJOf
         4keLq2R17NaJM8lEOCAevCvQrOc4uHzy9PK5Xis81a5rEFFUFG+637LzrGpBTLiPJokL
         DKCw==
X-Gm-Message-State: AOJu0YwVSDnjCHVSuGwhkcEyf5nRLWOgorMiY1p95Ew/s/hmq15p/rvS
	zn+azhxJk5o1LgbjO6gw8YfNco5b2EQJmN/cUaaMlizM60flrXo6zcuB+g==
X-Google-Smtp-Source: AGHT+IEgj6AYtzVNjvz187L3jmlCxwGo13xg5o47yG/eUAb3Hzugce83kh2cEFTWp+awMPK3ksGEEg==
X-Received: by 2002:a05:6808:1912:b0:3c7:49c2:e364 with SMTP id bf18-20020a056808191200b003c749c2e364mr332310oib.11.1714406253008;
        Mon, 29 Apr 2024 08:57:33 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bf29-20020a056808191d00b003c7443c0efasm3117820oib.1.2024.04.29.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:32 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] udevng: Support Quectel RM502Q
Date: Mon, 29 Apr 2024 10:56:58 -0500
Message-ID: <20240429155726.51479-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429155726.51479-1-denkenz@gmail.com>
References: <20240429155726.51479-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[37312.033140] usb 4-1: New USB device found, idVendor=2c7c, idProduct=0800, bcdDevice= 4.14
[37312.033149] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[37312.033151] usb 4-1: Product: RM502Q-AE
[37312.033153] usb 4-1: Manufacturer: Quectel
---
 plugins/udevng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1aa9f2e4b4b0..b9d115f16b7d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2053,6 +2053,9 @@ static struct {
 	{ "quectelqmi",	"qcserial",	"2c7c", "0195"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
+	{ "quectelqmi", "qmi_wwan",	"2c7c", "0800"	},
+	{ "quectelqmi", "qcserial",	"2c7c", "0800"	},
+	{ "quectelqmi", "option",	"2c7c", "0800"	},
 	{ "quectelqmi", "qmi_wwan_q",	"2c7c", "0452"	},
 	{ "ublox",	"cdc_acm",	"1546", "1010"	},
 	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
-- 
2.44.0

