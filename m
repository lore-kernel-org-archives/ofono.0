Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AA15B57D
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032690; cv=none; b=RDkFKtwSsXL1OoF5S1ThSSF3aSliq8WJh147q1DCw1L4SjgwXFdarZ5QkxXC8rNGcI/IJlm/QboIUZz1Uh7mox0pWjG2qM3FlTC5jwA6KtLkxajHueFYsznDQqy9D1i5hEG9vglqDOpmgNRjo9kpMK+ERrwwWnMaC4DK9BKL3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032690; c=relaxed/simple;
	bh=lINYXOGbLTHSvwwokATBhpzuGvJk/brwcirFVxlEZdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkBoSVUkX5rz0IMMKOjQNhI00bU01dvXMT+9c0mw1S9HVCstT+MAAEZz3PWY2NTsD+EX19/EipiCGGNBeIAxxraoiDXjlRhhbr34jgVtePUM0ZrTCsgRiix5dSO79M/cnkHEvdFv3DrvN4w3CmGRcjxEm9b8PViMNWkCDoiAT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i49F6Imv; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i49F6Imv"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b2054d51e4so1035693eaf.0
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032688; x=1715637488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI0hSvO6xGJrJjnSr6uGeOWfJJ9YqrBHn9aso4OqzVY=;
        b=i49F6ImvdTi8Vo3RjP05msXMVhn/6knhIVphxPeu9IoWceQjxI+99uDLUbXwXE5/TM
         t9vuN0hhzGwUKrkMRdaujdeItZDvL73KI4JqCsvU+R9oH5DWde681JV97fXRel5zYtmd
         VXhxkOVDrjgAoPji6cWh0kOeqG5aRqK8GdmzSSaVOWadIphcn3iRZEZOe8f2DnkRj/o5
         hOnV3UKXPVXfNn8e2/FF7YtV8vB55sudapwLpap4cAupkax//S/4e1yILsQhR7pLSNz/
         Sri2/rvGM7vFEWjA4e0q7LYTCS34ksmp2sXym5RkH6ZjxZhfr3ZGxJqu0UssLOmAWwKv
         SL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032688; x=1715637488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI0hSvO6xGJrJjnSr6uGeOWfJJ9YqrBHn9aso4OqzVY=;
        b=ay4gnrt1ySKN0LfyNfrdcf1LAX14gS9TCn8cyw+tMF6aNeRiBXvdduEXSzBUuVNIlC
         /YsZiNsnZIDyggL0aEuvG3YzWJfLyCcUs9x+PSy9M22rVCbHUSExotFJttedkNi4/dv+
         HrIgNgDK9F8jcX8+sW4Mw4Mx6KTnnVWbM4tG42kKckaeB1Yptbcb7OHg9dpYED+2rUQ+
         nzUER4zaDdlYM+rik3UxLA9p400xzwdhmzuTCH54VIRUrME7gdaWpJdzbYo1wcQbnluM
         2/6HLVg2FWIKciW75yxG7E5CkytABKHc5DhL8VrONUV2F5gFwigjGBzkKOUFQ8aSveQ+
         0IaA==
X-Gm-Message-State: AOJu0YxIj2vkbNSHPOC7Hw/YFTolOmAZW/a+iqDemUWpk8GY44I1Dccz
	T3GmamOzU9KCTwI+cRVReXWO5f4rmBcNxJzbUmTPn8yVC1pexBfN+L+0Ug==
X-Google-Smtp-Source: AGHT+IF3/74LqsLcx0fwzOJJ4jlQG3bcL/6GhUMXLWM/9gRbvW8wYYfYUJ822/+uQzs2iqKLxRR3iw==
X-Received: by 2002:a4a:aa41:0:b0:5aa:67ac:856f with SMTP id y1-20020a4aaa41000000b005aa67ac856fmr10159696oom.4.1715032688430;
        Mon, 06 May 2024 14:58:08 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 4/8] qmi: gprs: Remove IP Support Type parsing
Date: Mon,  6 May 2024 16:57:58 -0500
Message-ID: <20240506215804.57124-4-denkenz@gmail.com>
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

This code was only used to print a message to log.  Remove it for now.
The IP type will actually be used by gprs-context driver to determine
whether IPv4, IPv6 or Dual IP family interface should be activated.
---
 drivers/qmimodem/gprs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 3ee0ce36307c..fce975def9c2 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -74,7 +74,6 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
 	char *apn = NULL;
 	uint16_t error;
-	uint8_t iptype;
 
 	DBG("");
 
@@ -90,9 +89,6 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 		goto noapn;
 	}
 
-	if (qmi_result_get_uint8(result, 0x11, &iptype))
-		ofono_info("LTE attach IP type: %hhd", iptype);
-
 	ofono_gprs_cid_activated(gprs, data->default_profile, apn);
 	l_free(apn);
 
-- 
2.45.0

