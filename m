Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54771D3566
	for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427955; cv=none; b=uzimJ8dy2cNv2eg+GIqupuzMOT7UzjaNWgP7OCBZUHbMx05PkMpLyOFfhrytHZkc2my3h2AeaC03eY1mF0mJ9jF5CAJbrhvWf/8H7BZx6fZKj+tvejJyziB5oakwdTGgjTLFuDqONax3P6z/Sc/Xs0pcLSUzYANWk7I3AKMGRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427955; c=relaxed/simple;
	bh=sNKVwUxBtVO443p6ZuI6VwL+m/3+CDvSVAyQaGWEyZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8gzU3TFQ7U78WAz17Sio/Ydpjyxe0lwnfhF97TqOtMN/VJXbt8yyXxJz1ADvYCF7TEXwAgVOE2iKNgoEav7M+5+5fgIuauSPhKeIJrsMF9cFrBYxnio4Loo6M3rhqVen3l5Zs9GvviYxlFSm1C0LTQxQhKXz2Leyl6ETiCkIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxJgxvHi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxJgxvHi"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa543c4db92so1018019466b.0
        for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 01:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734427952; x=1735032752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVTAlOWE2gy7iO+wRGunLYX4/k4U17fbbGbvELSH9mg=;
        b=TxJgxvHiO6K4UswB0UoEyQsDgfZ6E5v3hZh590YFi7mGBES6/jCEovQjUKpmbr3+k8
         PQKFnoPcrJRj3xmcD5NSJePHS+rhr870bJAW75Zjg536KbvGF6atujrJfUylwYfkJUPH
         fmqp4t3qY2ZNTuPXRwlFJXDw1xQTr+Geg2428mBukSdVxIfXNDOPnZPXRGnGry0IP8g5
         9OxiA0S/uuLy9n2dLBfUmk36mba0WzzL3NVM0aR3g60niayCgXrnGpYlpG+XtszN9RYt
         XwOhWi0q2/CzMStoap4Fwso8wmT/oKAdxBGOXacO/EHOy6guGclVVE9zJlFsUKw7x/n+
         FbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427952; x=1735032752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVTAlOWE2gy7iO+wRGunLYX4/k4U17fbbGbvELSH9mg=;
        b=p8fAF9jjw96MY64EAMRofv3nj2PrJpbqET7+O9N3X8S3kJB3/WMK0+d5ArZvwIdmqo
         98IkThJ70lTds4zDUZuZhU6clH4/Wt+C1/M/r/ocYnwZjLp5tVLMaVAU6bb2UX0nnJ+J
         QTNT2QIVSv7NrQ8gQp0uR9cILjc/bYfQzLzzF8gV4Y+3H7b6E100X19lFTCDrQLCy84G
         /5BHBCI1lCHiBp9x2TMsZvlQTv+avr1ySZmpj/r0VGViFsO2FXUl482BtxbMDpKFNSAu
         MXz24Rk9UXAOcNdjjisvn75N+egZPpD6DaYWZN9zTb1Gw14pvYKa3/0bkYmQ/6bRj6SK
         siHQ==
X-Gm-Message-State: AOJu0YysDweARG+fT1NRmwBKZss0ikWLrlDDbI++UKXVuy1FzAUGzgs5
	qeSef4pYwSbrd11qV924q6x2+Q6BDv5ZKE5hIrBZK+wPtCv/Q/eKdeGuI5LC
X-Gm-Gg: ASbGncvHvec6rzgFqANMzIpzwl6R1GYsY/H5aXfNqMwNreknP/5ayal4zL1lHesmCLs
	HBSQ8QcYS1r91roXOAryUSbGPu6NbsFMZygq6TG9NCgj4ccklUTUT2FTczIUrfeH/fZPxvPD7uo
	eitcObE5h4ppb5+/xNHD3TbhUkBX9+jLIW6Y1LNk8XU9FmsGoSiVbKSd+FHw4G48TlnxXsHe0Bu
	JM/szNKbA9hQRng+HwdaxPRdfiuPdXVF8DtrJHhs2romR9F3kIe7biC
X-Google-Smtp-Source: AGHT+IEp8t6cA2AiZOuj07JFqi+dD4loRhEJHH56LcVCSQEeqgPg6q8Cy099jodAKf011cTJv/T/sw==
X-Received: by 2002:a17:907:7809:b0:aa6:c169:4e21 with SMTP id a640c23a62f3a-aab778c1445mr1289759066b.6.1734427951864;
        Tue, 17 Dec 2024 01:32:31 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963598b7sm425536566b.101.2024.12.17.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:32:31 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 3/3] ussd: ensure ussd content fits in buffers
Date: Tue, 17 Dec 2024 11:31:29 +0200
Message-ID: <20241217093207.20636-3-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217093207.20636-1-absicsz@gmail.com>
References: <20241217093207.20636-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: CVE-2024-7539
---
 drivers/atmodem/ussd.c      | 5 ++++-
 drivers/huaweimodem/ussd.c  | 5 ++++-
 drivers/speedupmodem/ussd.c | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 32a9fe91..59dd2e59 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -93,7 +93,7 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	const char *content;
 	int dcs;
 	enum sms_charset charset;
-	unsigned char msg[160];
+	unsigned char msg[160] = {0};
 	const unsigned char *msg_ptr = NULL;
 	long msg_len;
 
@@ -113,6 +113,9 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	if (!g_at_result_iter_next_number(&iter, &dcs))
 		dcs = 0;
 
+	if (strlen(content) > sizeof(msg) * 2)
+		goto out;
+
 	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset, NULL, NULL, NULL)) {
 		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
 		status = 4; /* Not supported */
diff --git a/drivers/huaweimodem/ussd.c b/drivers/huaweimodem/ussd.c
index 5e1c9078..3d165c87 100644
--- a/drivers/huaweimodem/ussd.c
+++ b/drivers/huaweimodem/ussd.c
@@ -38,7 +38,7 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	int status;
 	int dcs = 0;
 	const char *content;
-	unsigned char msg[160];
+	unsigned char msg[160] = {0};
 	const unsigned char *msg_ptr = NULL;
 	long msg_len;
 
@@ -55,6 +55,9 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 
 	g_at_result_iter_next_number(&iter, &dcs);
 
+	if (strlen(content) > sizeof(msg) * 2)
+		goto out;
+
 	msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
 
 out:
diff --git a/drivers/speedupmodem/ussd.c b/drivers/speedupmodem/ussd.c
index aafa4bc9..a5efde0c 100644
--- a/drivers/speedupmodem/ussd.c
+++ b/drivers/speedupmodem/ussd.c
@@ -37,7 +37,7 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	int status;
 	int dcs = 0;
 	const char *content;
-	unsigned char msg[160];
+	unsigned char msg[160] = {0};
 	const unsigned char *msg_ptr = NULL;
 	long msg_len;
 
@@ -54,6 +54,9 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 
 	g_at_result_iter_next_number(&iter, &dcs);
 
+	if (strlen(content) > sizeof(msg) * 2)
+		goto out;
+
 	msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
 
 out:
-- 
2.45.2

