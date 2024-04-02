Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBF3234
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097062; cv=none; b=jkWMNTqqOtItqUGStf0itkOlJEA0lNAQfMoaKBiqMD5YHCO9hU15m8Ut3eZrr0QXrgaDLLu3CZgnvcvMtMyXWewnd7B7WMdOJGFzdeI8ckdNIeBW0W5IpBod0UAn2kgubkZnEIpX4iciAQSFn6cyOiRsipwuqJT50se6STDxk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097062; c=relaxed/simple;
	bh=IXf7Td7dakoDdaJxiHvJavMN42z6RyPBX+lN1+zJAfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZMirRRBHJW3fVcUmaniK2c6Ew/NOwEeNm/BT6KTNkdigSF3YyLVZC59fybLEP34UILKQoIMkGkH+xJU5Bo0BZRBBf6DvIHwPGE3P/qKZuhK50eUnkMDzen1YGaUfw4vnQ0lqbQJ9kBz1HWWCk5+fl6ymiPV+LF6fMgzNMNzuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma9qE3pK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma9qE3pK"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a56710cdccso2731152eaf.3
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097060; x=1712701860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWe+PUC/DUb/AqF6ebHjXINhmuIh08yUnFE+XOqSRwc=;
        b=Ma9qE3pKYVBHYJt3nj2GF9et85QWU9Mu+CBPA7U2PnRUvALjNIcI86QwGFtCzAp4Ck
         Ikw7D8RtHQngl0EJg9fa6YrtDm2kMsMtGAopbWR7NwVCkZ+kePYHHqWlvgteQbeUVcPy
         tXVDMhj9/zRVluFujHUSvd93BJVUJBN86AgrKxKeAJ8r8/xaAwKXAKWKVayEC8W249fn
         VKP1HFbjZWxoVSOcMpWYxnN8ZfL2QlZzLUizHwP/0gPV2c+hN98LlXH6UPdGCZWsWRX2
         YogVefyi2dxeDPzdY9nOlc+MAdPXBRXzXlQARo/OEpDqOPCkcmfBLxFl7mSF77/79ypu
         TAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097060; x=1712701860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWe+PUC/DUb/AqF6ebHjXINhmuIh08yUnFE+XOqSRwc=;
        b=j4riOrFPIRFZMs3AR/sji/WG0F+S1FTdeBD5jMAQWd9ID/NsZR5W/pNAlii6Kgy/j8
         9WPnbIaNwWyycG/rmGdo7reI8Za0+CCdpXTwWdLiBSOxRA+DeRjc8EizFjwEiFzUWHWc
         xN24g4WMT0USmaeYFHcBEo+EkRb6cMvyvMu2Mo/7lf2dMqodw1dLFeGCv3Jv5f5JlT0n
         pHGfUQbIiEuyDgYUcouTrb2o2NRMcC+zW3me2zhTcztHqV31gUdjGmVwN02WuPQapuX6
         kONs3mENdLZ5cZ2g1p5e9zHGsVRpjRxWyzlqjdg0tejMqJg7OZ0pCu/Bpd5s1M+bW9Pr
         wCjQ==
X-Gm-Message-State: AOJu0Yx4p/01rWskkuJu7W5oYJ3f6Q9hNASl4DnPEIqWUeCim2XOkJMY
	++/YO1wk8DE86witUBtH4JRWudpr6oYnPZfky/mJII6/RMJ3Kfn7hrSEGh+n
X-Google-Smtp-Source: AGHT+IFGMtIIpBcjENdmqk2vzIlXYy8MyuLKTgKeY4SfJpc9AaTSjpxSFe5LiHyVB6VXAYggUttdcw==
X-Received: by 2002:a05:6820:1e17:b0:5a5:1f92:ba2b with SMTP id dh23-20020a0568201e1700b005a51f92ba2bmr13221220oob.2.1712097059935;
        Tue, 02 Apr 2024 15:30:59 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:30:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/13] data: Remove outdated T-mobile settings
Date: Tue,  2 Apr 2024 17:30:30 -0500
Message-ID: <20240402223054.2819526-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 data/provision.json | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index e55ecc6f8d67..80abd78e6507 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14229,41 +14229,6 @@
           "internet"
         ]
       },
-      {
-        "name": "Internet/WebConnect",
-        "apn": "epc.tmobile.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Web2Go/t-zones",
-        "apn": "wap.voicestream.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Internet (old)",
-        "apn": "internet2.voicestream.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Internet with VPN (old)",
-        "apn": "internet3.voicestream.com",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "Broadband",
-        "apn": "mobilenet",
-        "type": [
-          "internet"
-        ]
-      },
       {
         "name": "IoT",
         "apn": "iot.t-mobile.com",
-- 
2.43.0

