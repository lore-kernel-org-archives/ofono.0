Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8F16132E
	for <ofono@lists.linux.dev>; Mon,  1 Jul 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847699; cv=none; b=p0fU+e6CZygnIOux77jiFmJ+sVHk8HxncBBE4QeO8p3mmtxDXPQV/edm251f/hyYn8hi2/z111P4OsI+4n8EOuZOB+GAm+aPnvr2jrLpuVN/oym89unFm2c2pPOiqNB6anBW7/+a9zYw5hrmyw/+06+CVmAVMoWPmc+L0owRTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847699; c=relaxed/simple;
	bh=hDuG6az/CDlgNYY4vDQGXPf5XbeQmzcpifDsYUMmBeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjX4lW+RomhoOLnh1RdyIyNSyPHvZp5c8q4a1t0Kb86CXsyrHS0UC5WKbf5P5JkFmdx281LDcXx1dM7YSedx61iAMTqSmWUVwhJcW7HWuz3MXucOfhod760qWB1S+i8Qy7aUCff5UnL+1tBkdPqPP3z62NtA1R3cVnuxWLwKRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PgXyHw9B; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PgXyHw9B"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79c05c19261so188584685a.0
        for <ofono@lists.linux.dev>; Mon, 01 Jul 2024 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1719847696; x=1720452496; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyw7nmPcRlQ8LrDegL8oS2H3/nQU0GgrHw6aZ4AWiQc=;
        b=PgXyHw9B/Yid/oiafMYRC0Q4bcuwJHRKBt7lZP1g9a+qEkpR7XATR5MJY2Jh4zdgua
         jCbgabp4kJA1xmSo8BLHF4wtluCt6ja0/KVTG/phRO2LSYOJZfVlUqO2i6FlRfv0oLSQ
         2hUaU55aGZyd5IYfERCTVU723ai6dpjkrYJIuh5vBrEdiXFuZas8FI4haZ1HryYSrgij
         eDYcu42lJx53yWCSaB/EkftDdYX1gDdyZL5oCsfsskVnIveOwERRVzQVkyjrtNY7rAhg
         sWb2JEPpkvVqMv3HFEMnwXu42Osy02hNeowN0mHAgsxKGdMeSQAfQ7N6qOYs6drsNdH+
         u+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847696; x=1720452496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyw7nmPcRlQ8LrDegL8oS2H3/nQU0GgrHw6aZ4AWiQc=;
        b=SKbk4CFUN/A7tmw1M935uLv2NkX6msndcz3YlRcyyUQLMB6ZwtbgGvX42CQwhkwLe3
         z5MHe8ncAuGSrrY0BN/HM5pXti4ZWIbl8Vg47ijnH2yiqncvOK/ullmI+xqYrUCKLhW0
         7SHS2j8NWEI/XuVhh8OsfpKEkQrk2PUlVXWV6Xx9gVdt3IhsF2iiq7MOgdXw3XnDcP+O
         asWZp9gVQRuwFAJCTDw6vpwTJ35m4aPvietJocodZ2AC6wKoFI9buTEHUs5qiA9vJrCg
         k+SNN9mZcd0aORivQPZ2Txj6aalAIK9mua3NjnOy7F3KEg3jZ5n+9FTjmEvb12w1MFsN
         2Alg==
X-Gm-Message-State: AOJu0YyjdCyCSevmgmBc6vqf97UdApYQhHhX/x/TloipjNR6pt9Pz62Y
	AA7CLm1PEjh6eR/e3iKyah/6C+m7qegmQVixMYNs8iQHx6OFoIeKu8gX6i+qhIRqPVR0LxHDOkD
	vd9kcu0niuVQ3FG/vHOlgQFqSxUicZU6BcDOhFCgTs6aj7iVyhtDXQ5B9CZMD0lEyh/iQEy4aed
	dMCI8n5iidMnQiW+h/8/Zfeo/aMAaW+3YyZ7TwGX5xKf6gcA==
X-Google-Smtp-Source: AGHT+IGQWJDh023jfLQ+boh/Fh2Clwb1nzAQVfz+j/TfFI+ptUCRJS+vOHBxIHtkB3x6CoVQLk0W3w==
X-Received: by 2002:a05:620a:4483:b0:79d:5779:fe72 with SMTP id af79cd13be357-79d7b9b0e78mr789331585a.1.1719847696477;
        Mon, 01 Jul 2024 08:28:16 -0700 (PDT)
Received: from localhost.localdomain ([140.177.136.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69262ab7sm356212085a.26.2024.07.01.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:28:15 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/3] udevng: Remove gps from setup_gobi
Date: Mon,  1 Jul 2024 15:25:51 +0000
Message-ID: <20240701152553.23072-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701152553.23072-1-steve.schrock@getcruise.com>
References: <20240701152553.23072-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even when the gps variable was set, it was not actually used for
anything.
---
 plugins/udevng.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 8e116c6605ea..1c56e2ea62d3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -355,7 +355,6 @@ static gboolean setup_gobi(struct modem_info *modem)
 {
 	const struct device_info *qmi = NULL;
 	const struct device_info *net = NULL;
-	const char *gps = NULL;
 	GSList *list;
 
 	DBG("%s", modem->syspath);
@@ -373,23 +372,12 @@ static gboolean setup_gobi(struct modem_info *modem)
 			qmi = info;
 		else if (g_strcmp0(subsystem, "net") == 0) /* wwan */
 			net = info;
-		else if (g_strcmp0(subsystem, "tty") == 0) {
-			if (g_strcmp0(info->interface, "255/255/255") == 0) {
-				if (g_strcmp0(info->number, "03") == 0)
-					gps = info->devnode; /* gobi */
-			} else if (g_strcmp0(info->interface, "255/0/0") == 0) {
-				if (g_strcmp0(info->number, "01") == 0)
-					gps = info->devnode; /* ec20 */
-				/* ignore the 3rd device second AT/mdm iface */
-			}
-		}
 	}
 
 	if (qmi == NULL || net == NULL)
 		return FALSE;
 
-	DBG("qmi=%s net=%s gps=%s",
-			qmi->devnode, get_ifname(net), gps);
+	DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
 
 	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
-- 
2.43.0

