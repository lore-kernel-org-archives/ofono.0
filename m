Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD651C4F
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122161; cv=none; b=cx70wRcxGU2fk6HU2FMYZIn/eIkPCGJqXZ76p3OCs14+Qy7/DC+fON/cd5jD8a8xAv4ErWFYfB3VA+A6L0G7Z4pVRemgIikGTvai1/ejiSWqB5VJiwtTq7BneZRy4mm98thl3vbdi/d3SWEMyLkq4IXifCa7CnqyxKYZb24BhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122161; c=relaxed/simple;
	bh=biO0vb9/BuYWdOKBrZeZO+0e+XU5XceqX5G2CW9jOWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkc4dI7dwSq1UgegCL/R1ttoGobTL7Bv0OFTjJI3wKuHmT3AbcpaHJ6M8TDJHHyGcc1mjbqd5PIBPyqEZ5eP7b1iRbRau3vo+p6LBMmySp9INaxMv0bz8LDwgN+adM9iwsDfLItcDAIiCnQK9BcE8EighKRdcg/rIxhHPJJuHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acYDg9Td; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acYDg9Td"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6ad82cf17so1232211a34.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122159; x=1711726959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TfHiSW3eeJJvsnn2GJBhNZPGTm7drQ43Cvv3SrTLm0=;
        b=acYDg9TdPuesEjnLCPD2mKn3tcypvFWvKCWaT6A9XEwuoLPZfm1CkLTXsN2SArRbj9
         ckdQeyAujdRSceZUwTwkmZf+I2czB2ZQ6OTWuft/LLGxO7XfiQFOFC/9bgVsbA/G2TiZ
         AGiXs9aEohNQ9MPeoUsEV8+T3h9lQRXehA1kX8VI7WXwAWy12MciYonJqC6dSx1cwkDA
         fyDnKGi58vs5sA2ylqZqS8gxiYmPmIUmKIf5F2hMdVSLhsc+8+tYWpkF+0SlxGtA0iLs
         ht2dazUo10xuOuBQEnVdmWt3IK6CHDh1XqAh+a6T4i5xr1qxcBmqE713e5L7RCEQA5cv
         Xixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122159; x=1711726959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TfHiSW3eeJJvsnn2GJBhNZPGTm7drQ43Cvv3SrTLm0=;
        b=PO8wH6iDuToEEKFT+gT/7OXs7/fZ7wQcIA8vVH6y+N0wz6L2jaD2VtgRzaqtJqJH7E
         Qu9bbTIk8Li+06vc9dc4vRpucGeW1K0Rkif0VGE/S2rKOxtmOY8MH3PXaEwFxXenOl1V
         Gf/AjwTZzrfk4Y9ie7I9B8JuSZBRSa3Y7BzaOeSygbTS19WEnpWfW/isF8w8Amd5cUxS
         2w44vLB8j0V469i0PRZSqTjvmL8V8ndD/fl3QWOP5ZlU4WwBbDJlKh/0P9AwQ+OFfN3h
         6nJ0v54PcJmnAjAlV8Nru7CcdMvh31ekzxKjWnTbLdSGxBOsxynBQthMlsx8IcqiTG26
         Rwig==
X-Gm-Message-State: AOJu0YwcpOi5w1uKp5pWLn6xaJ6Spv9KNMVkPnlc0sTOfr2m3Izt7DuA
	pQPa6ZLruaavfH94bmv6l7sucS6MDktcW+ZD5RT8/UOcu6/7QnDrN2gXF23T
X-Google-Smtp-Source: AGHT+IFeNHrowD+gP0Swk1rfAKz46IPcRDwQscJAGnWgx+3CvtGoHQcBzjUvjGj6DjJ6Kjm0UnQIgA==
X-Received: by 2002:a05:6830:45:b0:6e6:8ec7:85d6 with SMTP id d5-20020a056830004500b006e68ec785d6mr3116410otp.31.1711122159060;
        Fri, 22 Mar 2024 08:42:39 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:38 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/11] doc: Add new Modem.Capabilities property
Date: Fri, 22 Mar 2024 10:42:17 -0500
Message-ID: <20240322154234.2720542-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent of this property is to give an early hint to external
clients, such as ConnMan, about this modem's capabilities such that the
clients can modify their behavior accordingly.  For example, ConnMan
might choose to drive the modem slightly differently if it knows that a
modem is LTE capable.
---
 doc/modem-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index ff9facdce422..69108ab0057d 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -182,3 +182,9 @@ Properties	boolean Powered [readwrite]
 			supported by this modem.
 
 			Possible values are "test", "hfp", "sap" and "hardware".
+
+		array{string} Capabilities [readonly, optional]
+
+			Contains the capabilities of this modem.
+
+			Possible values are "lte".
-- 
2.43.0

