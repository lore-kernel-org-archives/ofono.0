Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074121591E8
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027999; cv=none; b=dYgy3V+wkkGr/Fnwcqu1dONv18HGhmNiJuvPyTwV2Blt8NuSzmALQOryQGnyJQXakROBc8uf2seNJoD2xyOd7R/4pOFKmj3MMW5yqHWJtv+gOA/ZH9LL7EBTMrnAB1/oazoOstMDJQGJWBjSUNewMM14k/pBkmcvOqR7iiJ9XDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027999; c=relaxed/simple;
	bh=lINYXOGbLTHSvwwokATBhpzuGvJk/brwcirFVxlEZdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enlrp7fh+Hb5F74bOXbQ+EQWpkDl+vqobxT9rGp8voBtgUJwrdwJI52C9/zN+V/ZFlf67woJSBobKVRAyFK/oBA5tP77kEg9t0N00fzhpEzuweaVnz88oZ+LM8tBXpYSKNvkNx6sDv/45OTVhlNc6xJ8Tkd+MuKcaep6BAZi1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdzGcCND; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdzGcCND"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23fb052ca41so751521fac.0
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027997; x=1715632797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI0hSvO6xGJrJjnSr6uGeOWfJJ9YqrBHn9aso4OqzVY=;
        b=PdzGcCNDb8e+MB43VW8nzhEpR2d8W4dN3sF7DMx2+25aRsTW7LTMf19OM1vn/1Cvy5
         5FhNJht/BPOqL3vVoZKO8YhZ/liXgcNsVAzJXZQM1F0NSqgC5PjVO9R8JW4Ew/flV95B
         yZuyFlSIs0s8HohXEcP8qB/xlqPuqkFYLAnE+m54GxDIbDzrrQg5V4jOL7T3NkM9ii1e
         D2CeBTYLwfaCVqszGL0odybn8noD1w+spm5+HMvevx/MCgP3XUAAdnye7t/shq+4Yp1+
         9I9XEkCAI/uSvmSL399CQYjdlAX14U8Wh7E2Ud6mYW7rtwMY10DgZ06NfHWvhIpN8wIW
         9zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027997; x=1715632797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI0hSvO6xGJrJjnSr6uGeOWfJJ9YqrBHn9aso4OqzVY=;
        b=YJQJvk2fhDM3wDjdGKAzj5rw/z4EM0GmIQgU6Nmw/OyTagy98rQPrwZtwsSB0z5CZ6
         Rh/9Exjevn3UTR02pKOXyJodvPokRpvg8LGRRst8EYIiue8xwuES6dxHTyEJbQv4C+nq
         uYhtIXO/HI4gC9AfHh4lzBCFz71wgUYFQrmRePgkPOwWOrmbv1NPazJcaG8v7nDnRno3
         kCKyobRfIobY4KXzR8qLt0/m5w2RoSnmzdCCMNFpsHUZT7J+ApdSHiOQpvT6mccN03Dn
         Pow5+UJpWMbjqqRKvjQ6suhL2rQPn2nRF/eEZcZA08+yE44WKfre4VdVSSvwspcrhcHv
         8aFg==
X-Gm-Message-State: AOJu0YxCu4EkBL1h1/Bj2Po1+Ii0Ue8EErP/X3YW0HLvzI1zc4NbQdFn
	duLmRUCUVqvEjL520M2zeC5TcUGm3MZsRPvN8Eqg6/qbiWSj7XhIfTp9kA==
X-Google-Smtp-Source: AGHT+IHaNGgEtXgMmj8i+ohsH7Xb7LtDLMsrFwVma4FqNxT9XjByYk9bgNu1h4NmsOLYiEPYQpAO9g==
X-Received: by 2002:a05:6870:f101:b0:22d:fa53:5695 with SMTP id k1-20020a056870f10100b0022dfa535695mr14185993oac.25.1715027996984;
        Mon, 06 May 2024 13:39:56 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/8] qmi: gprs: Remove IP Support Type parsing
Date: Mon,  6 May 2024 15:39:26 -0500
Message-ID: <20240506203952.55806-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506203952.55806-1-denkenz@gmail.com>
References: <20240506203952.55806-1-denkenz@gmail.com>
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

