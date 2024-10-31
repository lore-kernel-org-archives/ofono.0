Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB591CDA23
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412410; cv=none; b=cIg91DFqmUKqrmrpOxxc5SAH8liV/2vsGMGBL+vWiu3pPhF58RbYEtfUXiqgmn0XKp6A5gGVTOV8+RmuBvZIeSR6FIQuV5vt5WUVOsB/3qZGsUteZHxYqAjwny9sL+Tz2sGbrR9xdh/eqLFsyKY3Z+a0TF2h++40S0Qmopqqt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412410; c=relaxed/simple;
	bh=ymBrO29EQNE22bwAZUP9hexAj7y+kzTIolfa/4NXhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he+/3fUCPCE/YVVIC8elw263YH5mBCa5ogW+ALFdwWcyPBSdEMEqP7Upal3Z+JlMZZnIXJJRZ348/5rB3OtZe2qoqMsICaDOsLXZb5IMsT28VeAyOL5/2riHaqlDwdCxJAwWZP9ERppbSpPXIEvQaMmfUEo9AwilMpQl8Rq+p/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2NmI4BZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2NmI4BZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7180e07185bso566064a34.3
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412404; x=1731017204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XphyHCtUmZAps71O90LdJfKFfRsLf2MdQS1KVa0Cufg=;
        b=O2NmI4BZASLgmEyWpQnhmDvrI7fb9UplOyM+JqqtsLjTu16cZSsI771LS3WuQz4veM
         G+eNYLPp73+ku5PBovBAN/bpuibeNX4ldIMenNyRSRXkDo43cZxu8LKPC6TEcyUn5cbA
         BlOI1kPwmkwuDTXuwnFffwTwrF8Q4o3LzzmiHz0kC5PK/xleRIgvJ/k2y9O8ZL/jAzS2
         +QugS5YcGWMRvUem0JpaZ+gX3YFJ5hjdCMf7VZkD05iiMvJD5egVfjTYASR04SiUdPH/
         ERBxTBtBZHCNJkgQsDzvA3UJ0NWQFktMu9kQRNKL2EOM8tAIvYHOME92MumJ8ad4aRFb
         6h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412404; x=1731017204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XphyHCtUmZAps71O90LdJfKFfRsLf2MdQS1KVa0Cufg=;
        b=Ttc7r5Hp6AzPyHUDzIs0XV/3+oCViZxG/ZULcXTGXSJv3ylqd+tPMX+zokbztKDU2W
         FO40/HJ+emWTFJot2Z89UwGBajZ8U0xIjJ8vHak+p2HhhpaMI8wu4pxjnddjNuc5wr1C
         JCyRM9eSMG+necV9Uk9luQHAUW1TAuD2cQm1v7/RlzBOcpKybARA0oCeAZGZa2KCdVRH
         1sk2ELd1U9J+XdHfiR2R3TPIj9PdKLXVy1zOdjDYAs9Yqt/DFNoJE0xHttJoiIXksKxg
         Q5VmyizhB+l2ztGQjKFKIcBUI49t6GDUX/Eidw6U/Z7ElqCVd0APoLPmedcV9wXVWhpQ
         NRNw==
X-Gm-Message-State: AOJu0YySsbDs6nmdCe1KeL5Rl3ae204Grt5mok9Q7eLB7dDt1jBbqNS/
	gX69LyQwb2OO2WBZ6L8F1orSjPDHbHIDcEeaO45Cy5Oi8/1FmZejF04xZA==
X-Google-Smtp-Source: AGHT+IFczigt0o69ml+IPv6W17XoYmFPelDRR+ZTGK5gq2OJHr4N+51wV97lCSi/bZ0BGvoUCzvymQ==
X-Received: by 2002:a05:6830:6605:b0:718:119:ee15 with SMTP id 46e09a7af769-7186811890cmr21257185a34.10.1730412404142;
        Thu, 31 Oct 2024 15:06:44 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/13] qmimodem: Drop call to ofono_gprs_set_cid_range
Date: Thu, 31 Oct 2024 17:06:14 -0500
Message-ID: <20241031220638.1582166-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent was to set cid range to only support the default profile
number.  However, the gprs-context atom never ended up using cid to
correlate to the underlying profile number.  cid is only used to inform
the core about the context that was disconnected.
---
 drivers/qmimodem/gprs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 547b32059da4..27060f9fba44 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -400,7 +400,6 @@ static void get_default_profile_number_cb(struct qmi_result *result,
 
 	DBG("Default profile index: %hhd", index);
 	data->default_profile = index;
-	ofono_gprs_set_cid_range(gprs, index, index);
 
 	if (set_event_report_request(gprs) >= 0)
 		return;
-- 
2.45.2

