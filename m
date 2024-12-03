Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1727E0E8
	for <ofono@lists.linux.dev>; Tue,  3 Dec 2024 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255059; cv=none; b=oAFOOhIiEdrprNMH1Nawx7pZJrcTgaqfzDis7znHy6cE/Luxnq++ysZaeQZSgJzznYhN0eUFd0vdwfyujl8Fi2kFdTEY1RDwiX1k+K48O/mr88dRPTuw2FaIzbaZNhxlGCb8wiOn4vtY9qp5eovudOITuTjVGhKfhWRIQ9z3Kfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255059; c=relaxed/simple;
	bh=IRIL/GOKQvcgbvEiU8d4wrLR9iKQNogzDGPLAMiqcu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZCYyh7ZpuVItR4QenRoc1eL3ZhUyVOaYzXN6d6NN3UfjYWEdeSM3WxFhMAMM9wOGdPfHx6Zt1sNvxGsEc1XMwsRXN1xydcM9C70dfhp0Xc4QEZJXuIVm2W4lA8n2SfLCdzomaWU+MRR7uNCL5KGB/It1iamfBTHQRJYM//nTzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy0MJZBZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy0MJZBZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a10588f3so38918855e9.1
        for <ofono@lists.linux.dev>; Tue, 03 Dec 2024 11:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255056; x=1733859856; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1iyTjOnk3TKGPqT2lEip6M3QDnQ9cCVcCLqXorjjOHk=;
        b=fy0MJZBZ5LmPUPLiL3gPr88KIck+VWx0s5tKegCwFtfUUhGDkJNJYjfVJXwitGN4Yu
         PXGDsPAhBsC7w07XoZHZDhy23FQlyiPtVM5sidH3VBQQsGb4eGXpxWG6URciFhvMsoFA
         2Lu4tw+wQ5/gjVuNxUVXyoo3bQHpaJqKXidgpa+i47tNB6Cd82hYDe/EtI4+VfX7jJIt
         kXUwQVgOb3HpsPz8Q2JEd3sad1AsuEvv+VKtocUtjkTrS652B/PRal89XaeQ/xQkwy+5
         IkxfqPHzjIBp7GOvyQELmvaWiPHh6LNYm4x4l+xcb5gz0yCkhGMR0WmV2D1JZRb0zyDj
         JLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255056; x=1733859856;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iyTjOnk3TKGPqT2lEip6M3QDnQ9cCVcCLqXorjjOHk=;
        b=M+mRBxl1EEGDEs5ThPvsXyM4znO2bCpX5Nv1R4TEi44tbcJHLk79AUawySPToYzfEd
         lpT2s7NYhUO73HTq5Ft/va1QDjyjWw5JzwYaxBvnJbBVfjDNDLP3DETPWwRHnvAm8fIy
         Vu6lHMkctIaDwHz0pxmAjmB27pRwywhtpHowoLDWhtBESOGRHWnrTfaL9k3s4Q0Vs1rN
         PPR3lh/LvTqCryIPdI6x7MOuYq1rnG5lwLjHKHVMGzZFdY78PrLGHHtDNa38/OnyGtue
         jta3K2XflRNarYR1iC79afL+WCJUtWbej6AZrNqD4HC74iXrX06Tztt5BxXoMcPyiHcn
         mvoA==
X-Gm-Message-State: AOJu0YwOZoNoD9ajPnK/SPAgDwJPcmDLBPwOaeg9+PcNegA7RYcI+NjC
	0w3vng1MR/a/TGbS4Xs25R+5kjCY9HWFKgx1ddy1O+rrpOjkoGcGq+3+EQ==
X-Gm-Gg: ASbGnctHRMTQpdlnitwT7oJhuWHWt+Xx6279pFvez5XXaa7MZJQWyD7vBvAdNnLTVks
	IXObxuqtM8eW1PV9QO50QIoZOgvmDn+0KdHYP1/c+txXxMklB/fx41vIN8GzFRV2swQCLWh0ilz
	uA0MyIPyOwPMfpm+zYmy2RYlrHh8pg04a3y0aZZan0dsKLr2u/bw9W0JsIQxM12n9jTjOVl/UjP
	jZGXZsn11JRZsRW+kXTrUO/04+bXnudwBKDZADah6CC0rkxP6ox41934y5xXb/4FhbRIZWO
X-Google-Smtp-Source: AGHT+IG02zSh45hUjSbsh+Il9EtOOeII2OlRte5iDcQebAj0zUa/7sVf45ip+t97qX+SNC8Rr4OqBA==
X-Received: by 2002:a05:600c:1c0b:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-434d3fa01demr14372175e9.8.1733255055495;
        Tue, 03 Dec 2024 11:44:15 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bec1sm204553455e9.5.2024.12.03.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 11:44:15 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 4/4] Fix CVE-2024-7546
Date: Tue,  3 Dec 2024 21:43:52 +0200
Message-Id: <20241203194352.25514-4-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
References: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 src/stkutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/stkutil.c b/src/stkutil.c
index b6d4b537..c8497c4c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1769,6 +1769,10 @@ static bool parse_dataobj_frame_layout(struct comprehension_tlv_iter *iter,
 
 	fl->layout = data[0];
 	fl->len = len - 1;
+
+	if (fl->len > sizeof(fl->size))
+		return false;
+
 	memcpy(fl->size, data + 1, fl->len);
 
 	return true;
-- 
2.17.1

