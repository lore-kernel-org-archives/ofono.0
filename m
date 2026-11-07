Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067969;
	b=IF+QBNmVuxfSzWZptxX5VFUXYG6xzmzJf/PQ7bTGfesiJEmUgTnHscXe4iz7Qnx6dnyA
	 aswh5gJeo4aRCdGyX5Dkr4Qxaw7zMibbhteaejmPGjW4hE6/5QyDEnsQZZnvZX/DB/tKC
	 PcVHTVs6J3+4b0yZRqDrGfciA5p7F1L9cLh7ycs64doqemuJ2cGT809XNDBCaeZp5a/f3
	 enhcxDBu+rUok0hUT/O6RS7tPPWgbUDPwNULmLAb7lsvnaRudTnZSErKHQbs3jz1PhxO8
	 b/PqA3gpLZmvt4H/PGZ12uC+qANXTciElF3hPjzl708EYi5rxANW31Gsv209GDbPjGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=i+DnTJmmpUtAWDSZ+VhFUd6I6t2q/L8OwN+c/vQpbzY=;
	b=Q6xCYpwzcAHpKaCuOHuwJrgFfHch30p8177tUarm5KQ4wROU7Sq9FZkMDvv1EK9C+Nvy
	 RzpGFXnAYM5wutq/PcB26s7gytR1l6BW4mz+hq7JrtXJxWmsgBnPuelTJr1lf4s354T4C
	 +Dd6TFsEBeM7vXvdbknNuMpxQv6IA/pvEq1D/lK5fdcdp0S73yElPjC+rEdjR2DzfHZ+X
	 s24IJ5oh843udmJeNgT23SKOkcoz1u8xQ//BoxI81GpHO0xJ/oMfePSG6yPOmtP/b9CSe
	 N4Toy3Ej62AWQMRe2RcqjYgPoPH1cyuJ0QwcO/BrZog082TGF1sT0MDAU4mVIOc6UDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Phvefk0Y;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF7606A330
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CF7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Phvefk0Y
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d05d51553so9623825e9.2
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067967; x=1794672767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+DnTJmmpUtAWDSZ+VhFUd6I6t2q/L8OwN+c/vQpbzY=;
        b=Phvefk0YQ7vUIwNNYbd1PaPjQLCoBbDzMGatfmmB/R3pQNyWi6Cd2WQt4AXICNcOb/
         RX3+Ax5VEDAYRjghPd3cz7pEnmtDO3ipJwWWIBD3i7+CsrOaaEaihalQArdGxVDsxTua
         YpzSi1ai7/KwpjBtaO9EFsYXwIm1kzxINHsa2FizO2NO4NL6o/1SjcXlkowkEKZEMU0b
         hwWdMluQkVAcWHPt61nFbRbsbijMJww5URgigSEHiwZWlSdmGPHsQ4PtWDlvf7thzUiM
         z/B7wdrivF5Z0yTuQd7Wev4BxmBSFM7HgED8ePBbN8yCx9R3rA3BrQNVudHdWr76L9wK
         0lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067967; x=1794672767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+DnTJmmpUtAWDSZ+VhFUd6I6t2q/L8OwN+c/vQpbzY=;
        b=qFS64BQhQ8jXKF8qJJ4H/cH/Yi+HigrD3tibCARsQWZh94zopsnn1SJwRqSrpDdWl+
         Qe7YNAAid13FDbE8DwYw4SA2DijghdQogIPGVlFjQqrtfY1ohw750g4YYtZtjNryVs4h
         fjlwSgqSyLdl0Q0oOWRqrbheBcIxTBefrz6jrtwAIPQUK4HFdS6R1j5W1ISG1HN4+3Mv
         Z4EQuicGyxM61dKhmSk/sV+p9JA8wALLy840y+/nNeLMIs7N92OM6bdRvQ2x2HGTKAIN
         k41/IkcnfBV7u5a2A5B388S5SK30YCd9ITFjdLFX3EY/1qOJH7GU1SLQK1LuvRYMg5ZC
         oRxw==
X-Gm-Message-State: APuU4Z/P5fO+9djxlrurtmN2zx2hDu8SqId6/ajjK/Gx5c6lXjvRucvf
	hpS/wHrVgwOjTm9r/9LEORtntAARoV499M746DG/YnIu0Gg1cioCtD+VsxkJZg==
X-Gm-Gg: AYBFou1N4ubs2p9ghOC6Xh/7pDE3q/7GEOaO6ImdgNzd37yY4MFlOpcLAAlkLi46DGy
	fNUbm140d9XIdptxTNcZwQ8cLd/SiQls069PhC7X/J6Ge4289492sLFdtC+dANdSYtnUKhU2Awh
	1g2XmJIjGlKUsuGIxu4aoehCZcLbgmq5boUpOt2GT/xwZQo4OkpjTpbCF6r7kkoIUvAO47Zg6dY
	auX0dW0y5aBL87ARszECop/RDzWNPi2NU71zVnYO0L7D0xGRqoXq8bQLdelLiE+4Xel71L7kVyZ
	LJmJm4SBcjJpokPAFqinTntmmeL9oujzTBs2Ln0kWLIjUwvtw1urjanaH+g0PtfMVpMiY3Dl2IE
	VoSAmbtrhTVW2Cs1IwKoXHp0cHedJkEmryGdYU07zLgVANG0O5dth62wELXNTQvjyKItriMdlhZ
	Qf9M9lkH68FsgYJVzmnhSPIl04CIxW78zSXUplGOfWPqS5bMVpXkFBGL/76zGVEjr4wjYT5vMAn
	q0vIm4r7UT6aiK6qaPdkRMUQd0tJvl74X+O+DxNvvwBMW8Gem3TqLabpAMPOBxTcnj1DSvft0IF
	oAz/QtrF/TGTD2Vj7WlsZEKL0UuPHIyZgS66ThNG7/SiI3oTqw==
X-Received: by 2002:a05:600c:1d06:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4b6e0172757mr105471105e9.25.1794067966666;
        Sat, 07 Nov 2026 08:12:46 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1b64esm82771615e9.13.2026.11.07.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:12:46 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmimodem: Fix possible stack-based buffer overflow
Date: Sat,  7 Nov 2026 18:11:32 +0200
Message-Id: <20261107161132.471409-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMSC address length reported by the modem in a GET_SMSC_ADDR
response is not validated against the size of the destination buffer,
allowing a malicious modem to overflow the 81-byte stack buffer in
get_smsc_addr_cb().  Validate the declared length against the TLV
payload and truncate the copy to the maximum phone-number length,
after the international prefix has been stripped.

Fixes: ZDI-CAN-30142
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/qmimodem/sms.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 39a4bb3f..f10334d9 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -40,6 +40,8 @@ static void get_smsc_addr_cb(struct qmi_result *result, void *user_data)
 	struct ofono_phone_number sca;
 	const struct qmi_wms_result_smsc_addr *smsc;
 	uint16_t len;
+	uint8_t addr_len;
+	const char *addr;
 
 	DBG("");
 
@@ -54,21 +56,29 @@ static void get_smsc_addr_cb(struct qmi_result *result, void *user_data)
 		return;
 	}
 
-	if (!smsc->addr_len) {
+	if (len < sizeof(*smsc) || !smsc->addr_len ||
+			smsc->addr_len > len - sizeof(*smsc)) {
 		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 		return;
 	}
 
-	if (smsc->addr[0] == '+') {
-		strncpy(sca.number, smsc->addr + 1, smsc->addr_len - 1);
-		sca.number[smsc->addr_len - 1] = '\0';
+	addr = smsc->addr;
+	addr_len = smsc->addr_len;
+
+	if (*addr == '+') {
+		addr++;
+		addr_len--;
 		sca.type = 145;
 	} else {
-		strncpy(sca.number, smsc->addr, smsc->addr_len);
-		sca.number[smsc->addr_len] = '\0';
 		sca.type = 129;
 	}
 
+	if (addr_len > sizeof(sca.number) - 1)
+		addr_len = sizeof(sca.number) - 1;
+
+	strncpy(sca.number, addr, addr_len);
+	sca.number[addr_len] = '\0';
+
 	CALLBACK_WITH_SUCCESS(cb, &sca, cbd->data);
 }
 
-- 
2.25.1

