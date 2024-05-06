Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C215B995
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032691; cv=none; b=Roo7vESYgH2ceYr0J9xajPCtP9JmolRPE411kVJeTepUWGagwB9LR6k+K7F8pJ6BAHOO7j4FuJhbDV6iJoRRtfIzOSRL3eEdKCVGtOAKatz9uqzIi2P6HmKmUV9aGGgOp9kCSSGKSgtBZR9/mbd7pPj/lA/kPTKqdLJ2bzaSY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032691; c=relaxed/simple;
	bh=OaeFjocujl7in4tYx4myFtQ/NKp5Uw6nPMofcNLZ7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiDVfEgznMjqUVqITiq1IhK7eqwGHOWJJG9OEMoW/LQCAee9fHrUnKx/qXlscAxCutLyplr2a7ZOk+uZrCqzDEHHejNxtWf6KYRcaT79g4qPKJOyCvqr9U4BAx+0jeQNTSKYiLFjbo2cgWl6dWxx+pD3IpJRvk6jbWkwvH9N5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gap14Q3L; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gap14Q3L"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b206b78b47so827361eaf.2
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715032689; x=1715637489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzoQTka9ikZkJsgGRty2DPEw6KSUgOn234UT0oIM600=;
        b=gap14Q3LO4sGj7n35MAwQWGbuxQWyR247deMBoDNP8eqRANO7Va5ma3LxtalyrNmjy
         87Nb+sKp5sDDH+W23ip9cIiE7ffG4WFs/3gffB62lAvl22ld+NAlE1e39J6xwb/YkMPF
         7NMPi3qUlyuKNXULaYsigrxVjVl2FwHB/Qdir13LRYSGN4lt7z9Pbmw56d+GQ/oXikXw
         Rmy0gyBowBGTL7SDwe9QuI9s1s7RI8doTM+MlWA5ozjCQceqNXN2tPmZA2kUXSUiC3hr
         z1EUFp3Bhuju0Nk5r30cCZhnDVFbLZCX4bIXdGvWZrvVj+4/zm9EjMhGFFsaw5rXcf63
         JusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032689; x=1715637489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzoQTka9ikZkJsgGRty2DPEw6KSUgOn234UT0oIM600=;
        b=dsvirAIkLz8RIBIEfvPH8I4sOXgCjjFMOYPe/aV/xUzy3pfycvKBxzBepttcACKB9Z
         wszd6FwvOVyFv44jJn+2FgUd4wn3yyEndvY0WrGUiA2xXX6FV2rHMyoFWToEcNvkloow
         Nac7dcuIlwmQRSXmkxyVg4B8Je8iKMZp5FGN8DyVrG+iz77qvbiDy+/GW8jevA8q896K
         2eRQ+46bFhZeR//h7eZCeoNt3olb3HxeZPe3tC7qnR5kIVSyw7Mg3k2WZ/V2scdzDj42
         4BgSG8GoPQbC42noL/9aEnrc5EUBwb6FRgopYNutVtp2fu5rQFpDFSEbV5eFkd0F0DrB
         aH6A==
X-Gm-Message-State: AOJu0YwXjpYb/Ppc0UG0TE9/F27lqLfL6wpVtSik+cj4CUxPZLABiyIy
	bLgBTZUGGFIe24mIaDOFSumW3ntAunUftrJ3gEWk0f2qP2GKTFQQoW/AOw==
X-Google-Smtp-Source: AGHT+IEMUQigLGusX3FjKtLqXhdRyseT0zoNbuvUxtA1DK9qYOWzj4qCsfWZAltK+gzB/AtsehF5/A==
X-Received: by 2002:a05:6820:2a08:b0:5b2:2b9:a503 with SMTP id dr8-20020a0568202a0800b005b202b9a503mr5873336oob.1.1715032689373;
        Mon, 06 May 2024 14:58:09 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2128102oob.15.2024.05.06.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:58:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 5/8] qmi: gprs: Remove magic number use
Date: Mon,  6 May 2024 16:57:59 -0500
Message-ID: <20240506215804.57124-5-denkenz@gmail.com>
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

---
 drivers/qmimodem/gprs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index fce975def9c2..2a0d52317cbb 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -70,6 +70,7 @@ static bool extract_ss_info(struct qmi_result *result, int *status, int *tech)
 
 static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t PARAM_APN = 0x10;
 	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
 	char *apn = NULL;
@@ -83,7 +84,7 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 	}
 
 	/* APN */
-	apn = qmi_result_get_string(result, 0x10);
+	apn = qmi_result_get_string(result, PARAM_APN);
 	if (!apn) {
 		DBG("Default profile has no APN setting");
 		goto noapn;
-- 
2.45.0

