Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068505;
	b=UVwQB/uM++kEqqu8E7kB/A56+IDF/1Is0r3fiagXVBIUnzqaNG1LRQkD+wu1EI1pfb+k
	 AluEbHkmrR3mJrMF1jFpyA/Iyqg/T3GmIMAsvug4coZa9XD9uB1PVtPa5kV74kw+NTHiU
	 /nwApz8PzafT3Q3gE6W/JnnNajgdVKPUW57rb8M+DIqOl16XcsU6UC2BgDxXxYnHFBRl5
	 6RO0XZFd38iwvWPsxJyQFuQTmAXS50AG73v1fGb7El4LOiYb/d2b4sUaUTG+6vuX0Gz1D
	 /eniuIQQBi8MSTkNkTgv3dxXb++BNbedRmryhtErrA8FPYUgoQ01OrjELaqD6zfMx5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3wRLEIKXnVQD15onWJvBRb6i3O+kgNLZqxpHT5k057U=;
	b=oM6AfKU+oSuxH6pJ+6+TFQl3hnMGLQ9eJY8dMXF9iR7kz8tcyUXKj5c62RDGx2n0R7Sc
	 Y2EPz1XqwLLTCLSGfrdeMW94mQLlr9S2xJBomDXIlrozqPUZywn8OFov09QSADVa5wkVf
	 5CeZ6uDQ2KXJ8XqSJQCsVuvWC6KlOydV4rugdo7BCYsLflWkSnuBaafRRSKI2ouK0+vPC
	 cybx06s42iFj9NU1jLk1guY/KkdaReYh5HPqh12BWAasndGleH7ksmxGJ8ZJKECB7qzG6
	 iIF0FmsiDvLY0dMkQ1AvAnHClDXB1VkEyzWwyknptv7WXmBP1Uxxas1pjmqyNLR2ZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlqpUx3k;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E6606A32C
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlqpUx3k
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e47347279so921384f8f.1
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068503; x=1794673303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3wRLEIKXnVQD15onWJvBRb6i3O+kgNLZqxpHT5k057U=;
        b=XlqpUx3kKwWnp5urnTsaCdcqGymLRznG4IFy/hp8yHnVDptLaEWr5oMTSR+z+zyW7V
         AG7MYZhLh3Fx/gwGwB35WfQYRS11XT8LNGd5HbIhm3YZT4sVKd805KF0b1l9Q30NlajX
         8c3xSV7UWZ8Aue9gWAsuGCCO+vjblMAZf9Kwp0W1Jo5+AJ0OjNEZHnPSINJgdo2C4OqK
         VeXTebyQCrKmXj5UBy/iZwW5FvE1ke3j0l3SxcIdlTeEu3k1GUkKZvMQKe2TK0fxU8xN
         9GCktAe3/LwihvjmYEQ3Upyw8HdYpMcq+r80hCBIo9cQIC6KQ8U0xgv8uHa11UhckQlY
         Vs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068503; x=1794673303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wRLEIKXnVQD15onWJvBRb6i3O+kgNLZqxpHT5k057U=;
        b=1R94wI0KeIKS1wp+A62lKzkQlpOHQbDafbKkKYohyFwMUUaNAVwTAjuDw/SfIETPJT
         gXFGT/Ci910OAlTWf5I77nmMTrimMKZK4lmuK9KP9wna8XEilc8cPDB7WIN2u8JGS19S
         GZ5ovoI12jDQoWbdFWAg1j2v6GwlCIUhiWLXuosM7vzUIt6+HIMl8SIJuUeRaDBbRt+U
         99VBf3iCZJblIiDXqRWfIZStuOITCSoaPMGapLKHzqITRXlKSql1PKgs9SoV3s92ZyzJ
         9HdN9uHtE4wsbKpAzKsp24u6J5tFKpz4pAt3vxtCDKxkR8DSVG7adNnrYh7Pkb3VjWgC
         KIXA==
X-Gm-Message-State: APuU4Z/xC/x29w7VEJ0Fv4oazbYWxuVApy8yeO2/mkMyOw2LrNnvHeHw
	NcCzGiB3qcE020u+L8jexz//vh9ailha66GA8aGQYUrs4XItocN5+oCWqxS7vw==
X-Gm-Gg: AYBFou1RQLriWWuqt3PpXy+AS/fawQJOiXEodx4I44fiA5WIza87aVtaNvrFKfgPT4N
	6SiuSzlf8o5rce7GSUStrZbRDB961pvnlmrd+HIcQKhkzuJ3UpBIO6lG0yNs9y8s+Y4yoQ3krYp
	Iwyd3MGSpbx+8e88E4b2g3raOzoz4fTiDBdrEiFFMwDjMpTxXPrsAq0YBHIJLnwR90KcVGXbnpp
	2XGmbkkmbHYkk8RSDWBaW3x33EJt7Gj+NH0kCqVKpNGIaNm4Rwfsb+XNCV4oJUcdxPjC+bJ/bUl
	qL864FzT77o8iSgK1biDTvUyeeM+VHwIZ+tn3iRB0sDnXy75v/MjRVHPHgnAOreShOafoWrk8wY
	CEWAmjNdeTsl08ZDXDRTSV/vLRAyYWfp1BS0Ln2P/UpIEIH+KAAX8U/u4egTt2neLLHVMEyGE0H
	mvc6fZpzYggnr6LCrr+XdMMoMKZmfgz18Yyg3iEYuRUqSvKNgA8Rr/7ha67ii0aqafy7nC3k1UI
	6udrgUzk3TbNtSg4CM0gjubROKeb7zER0wSJKvZYAybk/+k7l51thaxyO4UQmvh+zsMYODhj4so
	x5zUqfvZyN7+K1EaQuPnMM0CE6V4BcTUc6ZagHmcUMV6T/qTRu0=
X-Received: by 2002:a05:600c:6095:b0:4a2:167a:c93b with SMTP id 5b1f17b1804b1-4b6dfd98684mr93400645e9.30.1794068502944;
        Sat, 07 Nov 2026 08:21:42 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3283ec3sm73903795e9.12.2026.11.07.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:21:41 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] mbim: Fix possible stack-based buffer overflow
Date: Sat,  7 Nov 2026 18:20:57 +0200
Message-Id: <20261107162057.472255-1-ivo.g.dimitrov.75@gmail.com>
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

When processing stored SMS messages, the PDU bytes were copied into
a fixed-size stack buffer without bounding the copy against the
buffer size, and the declared PDU length was used without validating
it against the actual data.  A malicious modem could overflow the
stack buffer or cause the TPDU length computation to underflow.
Bound the copy, require the declared length to match the data and
reject PDUs whose SCTS length field exceeds the PDU.

Fixes: ZDI-CAN-26297
Reported-by: Trend Micro's Zero Day Initiative
---
 drivers/mbimmodem/sms.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mbimmodem/sms.c b/drivers/mbimmodem/sms.c
index 1f52ef7e..e14a7c7b 100644
--- a/drivers/mbimmodem/sms.c
+++ b/drivers/mbimmodem/sms.c
@@ -227,11 +227,17 @@ static void mbim_parse_sms_read_info(struct mbim_message *message,
 			uint8_t pdu[176];
 			uint32_t tpdu_len;
 
-			while (mbim_message_iter_next_entry(&bytes, pdu + i))
+			while (i < (int)sizeof(pdu) &&
+					mbim_message_iter_next_entry(&bytes,
+								pdu + i))
 				i++;
 
-			tpdu_len = pdu_len - pdu[0] - 1;
-			ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
+			if ((uint32_t)i == pdu_len && pdu_len > 0 &&
+					pdu_len >= pdu[0] + 1) {
+				tpdu_len = pdu_len - pdu[0] - 1;
+				ofono_sms_deliver_notify(sms, pdu, pdu_len,
+							tpdu_len);
+			}
 		}
 
 		mbim_sms_send_delete(sd, index);
-- 
2.25.1

