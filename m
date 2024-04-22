Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F61CAB8
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822064; cv=none; b=H9+PntO54xmpOTcakwYnP+EoWb0qIJFu6GJiJhPUmlMBMqwn46Djyc0B/Fg1aCen24oB+nE4LLTHDy7dccn0DJrSRnSJwHfa5b+AwX5/wqnoFgnDdGmIvjZ0zsV+4CDgd1cWGLtPxcbMTsqvLQkgvcPJG7Zh4L7EuDcJKZNhZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822064; c=relaxed/simple;
	bh=N27Spih5X2XBxzrcM75p/shgYtqN1/O6KBFRcTClQxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai0BYGObEfzZrkWiboCOGGjNzWrmPSbwip/jTFqsPFcliVRyZpSQc4oDR7/WiDKZYPRUmiJUD8IOAjspIapUEcmUxhWzMMb4ino/9HVtBqjPGFS8B2yRHpkF1nmc+H4hHM/CGxrKi6gZsljmD+uz50Ulp5iM2AgmkqvG8I5NW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy0WAiuf; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy0WAiuf"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22edbef3b4eso1247806fac.3
        for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713822062; x=1714426862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkswOI9JJc/iahK7O6/if/G5cA+J7LeM1RZdMLxnadU=;
        b=Vy0WAiuf1iU/roZaYNVfls4ifj3xaL/2hkSQ32NiSCj3DCq3d9AiesJWjFUfgo9Cgc
         8mc6UMLJaTMRUpbBxusmh7+pOnXc6y+mKVycL0dcyPBXgzB9USpjpTt7UhbEbhSrXmLt
         WAE3NJnYdFcFPNebwj6vOhYlo4SILeFw1gIbBa1jMQzpq+NaVqVwwrSdCkG14VucUuy4
         VIcDQri+uR0XAYDfZBYdNta494NDr66ba2tCQAjoLnF3wS1cJgKysEzH+so9eGRijKte
         wUSyynIBPmbnIm2DpiYmdaUIBlFofXjPGeQk4uHy2cJ3WVnQS6e2GQM37vQH3GwHcn3G
         kWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822062; x=1714426862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkswOI9JJc/iahK7O6/if/G5cA+J7LeM1RZdMLxnadU=;
        b=LWhnCpZPjJuSS7k5GA2YLz3MX1da+vp2P4JmdwmMm1oL+8Yip7iQIXaYy9+lT9eb+1
         4gOcFplPY+kIdjs2RnuDamqTgbicAT50NkYukNEIv2e5vkFmzvzYgykH1p0rdo87u9Ct
         QBmW5m/QzJ9H+sIaZYG/aWnivEq7/+jmkB7ZRlV64718yMwZcypRrBVQr1k1ioIexNIF
         8buVfEpaUUvrO4aD56tkODWYv7o1Z0llQRr9yK4hndH4P3a1O60slT4ppKyG7pGphX8r
         VSChhHQAy3C3ZtNMhSAg0KE8+sCyDCTOT3CIn6DtmAucCkBN9zPkmdMo+U8uqb+K+Qkf
         Od2g==
X-Gm-Message-State: AOJu0Yz/YCdxC4QZDO2nbncvF1uBVAIfKjM4X7JRRDx48DKzNFVeNJjH
	4LiQ34sTmjhc0um2+jP5T1mZu2Qtj1DG73RlW+ODE1MNfGq5ajCnpodAqw==
X-Google-Smtp-Source: AGHT+IHnvva85k9Wrnocbejza7brbC/fRKdhaXyWo3TNFxUDtIES6iX16iaoPIYSfmFk9ws1YO39mg==
X-Received: by 2002:a05:6870:1591:b0:22a:6ce3:d57 with SMTP id j17-20020a056870159100b0022a6ce30d57mr14527440oab.25.1713822062549;
        Mon, 22 Apr 2024 14:41:02 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id xm8-20020a0568709f8800b00239b3c03b8fsm1076122oab.42.2024.04.22.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:41:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] qmi: voicecall: Remove ternary conditional use
Date: Mon, 22 Apr 2024 16:40:45 -0500
Message-ID: <20240422214058.3411417-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422214058.3411417-1-denkenz@gmail.com>
References: <20240422214058.3411417-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code a bit by removing the use of ternary conditional
operation and replace it with a 'remote_number_tlv' variable.  This also
removed a slight coding violation where a mix of spaces and tabs was
used for indentation.
---
 drivers/qmimodem/voicecall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 5afa3a057a71..dcb91c642c0c 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -263,7 +263,6 @@ static void all_call_status_ind(struct qmi_result *result, void *user_data)
 	int i;
 	int offset;
 	uint16_t len;
-	bool status = true;
 	int instance_size;
 	const struct qmi_voice_call_information *call_information;
 	const struct qmi_voice_remote_party_number *remote_party_number;
@@ -275,6 +274,8 @@ static void all_call_status_ind(struct qmi_result *result, void *user_data)
 	static const uint8_t RESULT_CALL_INFO_CALL_INFORMATION = 0x10;
 	static const uint8_t RESULT_CALL_INFO_REMOTE_NUMBER = 0x11;
 
+	uint8_t remote_number_tlv = RESULT_CALL_STATUS_REMOTE_NUMBER;
+
 	DBG("");
 
 	/* mandatory */
@@ -285,7 +286,7 @@ static void all_call_status_ind(struct qmi_result *result, void *user_data)
 		call_information = qmi_result_get(
 			result, RESULT_CALL_INFO_CALL_INFORMATION,
 			&len);
-		status = false;
+		remote_number_tlv = RESULT_CALL_INFO_REMOTE_NUMBER;
 	}
 
 	if (!call_information || len < sizeof(call_information->size)) {
@@ -306,11 +307,7 @@ static void all_call_status_ind(struct qmi_result *result, void *user_data)
 	}
 
 	/* mandatory */
-	remote_party_number = qmi_result_get(
-		result,
-		status ? RESULT_CALL_STATUS_REMOTE_NUMBER :
-			 RESULT_CALL_INFO_REMOTE_NUMBER,
-		&len);
+	remote_party_number = qmi_result_get(result, remote_number_tlv, &len);
 
 	if (!remote_party_number) {
 		DBG("Unable to retrieve remote numbers");
-- 
2.44.0

