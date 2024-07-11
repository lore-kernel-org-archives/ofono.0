Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82316B743
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716424; cv=none; b=h+RBzTD+TNXsCM44jPDomfjHXRNElObvXsmTpFgX5Nk7MBbiO2/+OslR89eCbf/ySRRUTxqVqG+1838KzzlntKvbo8L7K39Eg7GFW6KWt08gMpNeU1y9R0nuoBOiG5oM++3qVTeKovCYMmB8hQtctS88pRgAai+uHV8zAk0airk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716424; c=relaxed/simple;
	bh=0UKrj6psPpqKrHfsfXGzVkrlHHzbsnYn0x2SxeReDmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH8L3Ezz/VbZoV/wsBaAVGlHBPju6HMz2psvCoF3WsQ3T6P5iSjw0x70eUOVf2JlUxhSsOxHSJaTeHT5cOMSXEIiIDOgvrHZZ1ugIfR3s+JeIrGmIqOne4rvzlnLlJwvPlIyLtP6DWd4Kr5tRppfUMC7xkBtzzh3gFJjlK15Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niU4lR/m; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niU4lR/m"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so53862139f.0
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716422; x=1721321222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs8F02vWqEf3iOs19nUa1+NSb0ZJzw+ofar/3zu1nbw=;
        b=niU4lR/mRZHXv9m0lXvNId7a+JeY419Dyps0B0tUTKJGvwLUIlA5r2rgAi6CG0HVL5
         udfr/rUi6M3zDQuHXM36f8T/2zV0Jb6hTucVLaQe0fzK5c9DKkqRWRBtlwh4jHF2radA
         KQl2gF8ng/KQWCZSNuoDd2aQz8hBR/BvV4h1pTKIGRSVRdIHDDe483Rk+fQMnxNzmuqR
         3Cpk9Me3HPmTUoY7zT9tPu1qpWNPbfrpzhE4aboViJJnzzgzTQ46AD609uc1p/IXCvNY
         JVN1hEz7vGVuDU85SJKvTxzsOeZQ0Ttck1j1hkvyzov4rMkb/wioXeyf/z8564fVZN4/
         4gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716422; x=1721321222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs8F02vWqEf3iOs19nUa1+NSb0ZJzw+ofar/3zu1nbw=;
        b=T8QHItYZXNKeTwobD/KRaYzV+Jy9UsJ1e/PJIFai8D6T7gJEdsQkYxIl+LE4MLTnlf
         3yLVEEDQmuWkv3+Xnwwpr6hhd0DepJs6gaVwniNxPIwXYPwdFSIz19bzqTyFKDwR278I
         UWA74XxxNZIfyQqzUAiifdQLi9dP+hLLDKacMnwCtNYWhHp2I/FumFAdeibPhRIMrSDs
         vN1tRxGUnM5mwdBkHXaGG8q0up99e8+lLAt9h0S3TNjOizAGI68zEmkL+G8s+TFNa1IF
         yuOBKz0l2vk9WOFhp8HEH8rADJqX50URmvWAbn+wTObAJSyvNYJOX51nRayC1npt9ODo
         NOPg==
X-Gm-Message-State: AOJu0YwyzBNHPHhAYWkz9iydp/8QZVyu5MU3fbmZ02ymugA+Nn7+Voxf
	KOBxg4wMKXEDPPpETLhRFXFPT0fDhfMe7SMrwpdSA7fFGI4IDvVu18byyg==
X-Google-Smtp-Source: AGHT+IHNH/7nYM72jvkRQKC4oHZDjUYJjneG37y4KC9nbnI4maODlFdqZeFUPKl6OHu1j36ixtuRWA==
X-Received: by 2002:a5e:870f:0:b0:804:4024:cd14 with SMTP id ca18e2360f4ac-8044024ce46mr572130139f.21.1720716421823;
        Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/11] qmi: gprs-context: Remove parsing of unused TLVs
Date: Thu, 11 Jul 2024 11:46:26 -0500
Message-ID: <20240711164654.1688558-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The information from these TLVs is currently unused and only printed to
debug output.  Same can be accomplished using an external sniffer.
Remove this code until the information in these TLVs is needed for
something.
---
 drivers/qmimodem/gprs-context.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 5582a8052c0b..f29f10720710 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -173,29 +173,17 @@ static void get_settings_ipv4(struct ofono_gprs_context *gc,
 
 static void get_settings_cb(struct qmi_result *result, void *user_data)
 {
-	static const uint8_t RESULT_PDP_TYPE = 0x11;	/* uint8 */
-	static const uint8_t RESULT_APN = 0x14;		/* string */
 	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
-	uint8_t pdp_type, ip_family;
-	char *apn;
+	uint8_t ip_family;
 
 	DBG("");
 
 	if (qmi_result_set_error(result, NULL))
 		goto done;
 
-	apn = qmi_result_get_string(result, RESULT_APN);
-	if (apn) {
-		DBG("APN: %s", apn);
-		l_free(apn);
-	}
-
-	if (qmi_result_get_uint8(result, RESULT_PDP_TYPE, &pdp_type))
-		DBG("PDP type %d", pdp_type);
-
 	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family)) {
 		ofono_error("No IP family in results");
 		goto done;
-- 
2.45.2

