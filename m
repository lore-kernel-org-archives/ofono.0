Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067885;
	b=H0zy0lns+6gQwt37SwBOtogS9qU2LX3nfAJGoCAD++LbtzqemDu4202F4bgnVhiLNA3/
	 s8ch1v7hvhaeGJQ64rY7a4Kl35fXFiIjj1FkldR10reslnCEmPFxGmPtgfkbwsaUO7lbQ
	 kNeQoacIk8GVXhFqtcvJTrTuydP/MKVpMbtdimJ7+vPd/cp7kYa6qwt6tq7IFlZ5osANQ
	 Oin/AfQWsQXnX+0MyHL/3x6Wd6l0gKIpDnKXwO5izCEtNiK+qdR45owToHDRkn8n9r+pH
	 Kfo+zbevwJjjhU5wXztnH/1hI7b4xZPujir0UaMdP95jHRVexSZUpWlqOsu70d4H2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8n9eCAAcS++FkSkW/UwUTeH951bQ49xzGQuHOFIXW3U=;
	b=JUQXN3M22eZpZOQarTOUfY6HRjLEancNEPhuVkieww+v1Rd1b5YxKa/F31DHH4RZ0kNq
	 R0UV4lHv1BthvhcEBirFLM1+c91UdO81lj1upxGl25qXkuRumtAXFO+xDvgbCJJQt9z5l
	 52pGhj0RvrKVmG1ylj6NhK01B2dh9X6xZUIfFwSbxhiSZlUxRJv0t71gpqtwGKNZSUqjL
	 PpUz/PJLOFn9fLNK0VnGG1xGcxIDHmHDL5eUtBG3KOPAU0YjepUCr14gaDrIZw7tM/xcK
	 sYG5k2nlaH+0mrMN6D7uiggcd4tsPI83BlYCpA10vQeihJLIvVgJMfRuLFxAWuCXvfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuKvZ6Om;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66135606A33D
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66135606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuKvZ6Om
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso15573925e9.3
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067884; x=1794672684; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8n9eCAAcS++FkSkW/UwUTeH951bQ49xzGQuHOFIXW3U=;
        b=RuKvZ6OmySNUA6w59jNqY1lWHr5aGuqOhO/0fGGcRRZJmYfe0a6gPdu4bx/S3Cx0v5
         CqJdgVqx5Hw5ROgF9FiY7aG+Hb+NEYcAGxoNy8QBpcuFrCX/YRHm15CuNWuBRplv/Wo6
         VIz/8QxklawzBqF2MpQQzQRonJJnujuaV+rwKAyAkH4boto2x3zTFWONQUgC/TKnMUQp
         tmqOHEzMAu/0IGBB8EbUAnGwEm9kHL9X+0RdIAsvSqH8Mr6N4p08R4zoc7OQLBs0GFy5
         RFPZjudSVVBpcOK3ZeA/u8x8db+FwXUnTPgRDNF27TRfc++yEYoPZm9N9HL9tiZOOADO
         uWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067884; x=1794672684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8n9eCAAcS++FkSkW/UwUTeH951bQ49xzGQuHOFIXW3U=;
        b=v+CpZ+QNvM+c7hlRD4lg32K7Bvu5ba7ToKRVtDRv/zsCx4s34HMmBpxbdNOQ/dfamV
         I1tde8zd5x5ZCQiaaGLywQ8r4OCt3FvwonzrdjeOs40y7DzykoJph5Tx5GWlUQFvAueD
         O+eJbo8Ne86x5Qdgh5sWUdbvMniy2tpJnHRr53REGW3LLNmhwcRjrBDvCN6oY4tQF/Wb
         t/q3ZzC+b5O6bQ8wymYLqeyxO7QC+4qsAwZ4toYoOje9H14XIqocGXlu+KSpZtCQ/wDF
         ucNk7xbPTULajX+I0VX6ye990uQ/jQuDnq8pyuWhVDcQW6Xtt12UPnL13O3U6KCQTDw8
         YVTg==
X-Gm-Message-State: APuU4Z9BoUOooop1FaWSa9AXr+nmzdejLWaP7yZ010tI/BccEuO2XHVs
	EqtY3wizC0Gr8Wuoc88D/LjvhiJnWBJ5UdqIomW26YEP7L5s4cWbG5c9AkThtA==
X-Gm-Gg: AYBFou1zY2kKC2Uq/u4VgK2R1+7FWVbqQSWy1yfcDGfvwYDYuZBom8ZNoBHioMH47PA
	6vq/NK3SBxqrB0qi/mdRGSXcx9VKaklKptyAFji6ZWm5yG07/7HgFF5j5Zv3cal+iKzSZMfjANs
	y3Hr/VanOTpSp/pUg9MaqQZU/LiO2KxwY1uD5B5LYCsb2r/ThoNLTwWmV2ywQx320AC3TI8e9Gf
	VnkGCKA+ZTPX/qCJfTxfAZRd+UVxhJFSXAmzHR1we+rK3cbxVoNPoN5gVyBFNeulu+gy0Yf1Dre
	/HN2VkTvQDIo1jrjYL2VYfoVHmR0+YHucPCQ8C6nk+p9B8dOGOeFnaNAB01vF+weSpYoaOTfJIL
	Ec9+1RUo0PdaSZ2JBDm0Y8N+tggB6TeE/2lC36iH2PGVa/Xy1do/6C1WpzOJaQgGXyz7YMVLe+C
	+21d+jFDc0zK76WJwxUeddShi3mpMmlcKxFxXKyAa56W0rm+z+uiYx8CLywbcPuecv9D5rdM55r
	J+6A9Sfd7VTMegPsySPI0Nj7sAtYK9kpshsn8E3SU89n4eD23IdDuS4m821/fk/aqBHqaxM3D1v
	ICim4moWtjnVA+GD4OmdeGQPLoSKg8uyS49tiDiTM++1wHwTEA==
X-Received: by 2002:a05:600c:4444:b0:4a1:cfa7:e968 with SMTP id 5b1f17b1804b1-4b6df9bec76mr97094755e9.21.1794067883533;
        Sat, 07 Nov 2026 08:11:23 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm100834525e9.1.2026.11.07.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:11:23 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmimodem: Fix TLV length validation
Date: Sat,  7 Nov 2026 18:11:04 +0200
Message-Id: <20261107161104.471346-1-ivo.g.dimitrov.75@gmail.com>
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

tlv_get() returned the TLV length from the wire without validating that
it fits within the data actually received. A malicious modem could
report a TLV length exceeding the result buffer, causing callers to
validate against the declared length and subsequently read beyond the
buffer boundary, e.g. in get_msg_list_cb() in the SMS code.

Fixes: ZDI-CAN-28993, ZDI-CAN-26348
Reported-by: Rob Blakely working with Trend Micro Zero Day Initiative
---
 drivers/qmimodem/qmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 4468761a..30f7cfa2 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -915,6 +915,14 @@ static const void *tlv_get(const void *data, uint16_t size,
 		const struct qmi_tlv_hdr *tlv = ptr;
 		uint16_t tlv_length = L_LE16_TO_CPU(tlv->length);
 
+		/*
+		 * The TLV length is provided by the modem and must not
+		 * exceed the data actually received, otherwise the caller
+		 * would read beyond the end of the message buffer.
+		 */
+		if (tlv_length > len - QMI_TLV_HDR_SIZE)
+			return NULL;
+
 		if (tlv->type == type) {
 			if (length)
 				*length = tlv_length;
-- 
2.25.1

