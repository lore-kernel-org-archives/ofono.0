Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B006E5E4
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633010; cv=none; b=Nk9gPCBVQJ/RTJ1hjTDE0TqQ/bTOXNNH/Ktjq21412sCQpCm6+mPTkPlbvJSaX0q7SuzDjCm17YgEIrGTcnBRXxU7YkgV7ji8JvUwdUrXw0aQEKftOrtPJ2H4HphqSty/3hdsP8lqdF2g9wJamViU8y+ZEBwor6JiwHzkG7abng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633010; c=relaxed/simple;
	bh=7M/32TCdpz/4zpM2Qn4RWfPA2A2jDsXh39DyFSrVgjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc90mv4TpgyiSeDAJt6/+NG6X421hw+IisEmP/IyRv+4U1Cc4tLN2+CBxpUPvUOEmtNNFtHpycjGdfuyiS/HayrANkQrbopfiTTimjv7iGjRFOE9dJKSmuWYp9GQYi9T640hD2AojfWdhyqPdk+g3knS4f/vpJgPTSlp4HcINRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkE4ZUmY; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkE4ZUmY"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a027fda5aeso119580eaf.1
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 12:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633008; x=1709237808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBy/eykTh1+KPm82aBg9OrTIXpz0pLXbS7OyGJP5L6g=;
        b=AkE4ZUmYb+plolFermMnfeFMvwnccgmAR/aNFqYRhB++x18OIzvAZE9JlZTevkm911
         5rawAzB8BEMfxMEV0bqj5lhmQXPEfstn42BlfJo1ZWptxNJJDpGA7ZmLI+V2QrcOdjF4
         1S7NcLTqpIiS/vI7pz/muGYKpYTEk+wtyOjd7mN6BUMJ1fAOHjzabxIMhTaPX+bewSAZ
         M3TeE9q0EsM/g33lH0RYtvk8E1hWmOM9BaU9N3pNP/AS57LyBGccolOWPUbpfjf0EWhj
         nFmDruCcEh5d8NZRdxtR6eEWpDptymS5tFHGBBJLpeSI5xLRh4ebwltNaOa4fSiJbSjr
         Mexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633008; x=1709237808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBy/eykTh1+KPm82aBg9OrTIXpz0pLXbS7OyGJP5L6g=;
        b=JzJ/ha6Do3lf/DyJHngbeevbXJYYSMu3zVkR+Q/9CYChSIJx7u4IZWqJNZxE0/1eoQ
         Sj9/37E+P6x8riAXSbfsscfJh2kVeNMKARze9Yk2fDsRGho3vSuZiu/sv1fNQWOZWCmd
         UxIgbLo3E+JyidPk0dnRLwDE4QAqlTqZBCcTDHS96weqosbFWrDH6xiIjbwzLpPVVEQo
         Y1x6978qXVsiUIbna6w7tsGbBdGo/ebAnr8Q7vpZ+/HJ0NQ6usvo3gK007W34qs9nM51
         h5lNzOoKIJG2a3uai2oG3Xs1ooUx7ByLFN2Zse7BRYw1AwSUcUkhEuTIb8yuOJeXmmQ3
         SfTw==
X-Gm-Message-State: AOJu0YyO49AJqrFOWF/h/v26iswP8JSpHxRk+OajAvH5vlk8YSYKkUk7
	5FEnRd9s7mH6GSpP3ezjoVMRHrVcpIaSI9pCDt2PwGd1nvAi3aVuafnGZ9F8
X-Google-Smtp-Source: AGHT+IGYr6h2IVHl01485lO74GzH9f6zskCL5w9IiUH9//Ht1kXWlAzPkrStIGHsc6HyuaFKq+UdBw==
X-Received: by 2002:a4a:d285:0:b0:59f:8466:5748 with SMTP id h5-20020a4ad285000000b0059f84665748mr85011oos.0.1708633007877;
        Thu, 22 Feb 2024 12:16:47 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id k1-20020a4a9101000000b0059a14309a29sm2472353oog.16.2024.02.22.12.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:16:47 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] gobi: heed the qmi_device_discover return
Date: Thu, 22 Feb 2024 14:15:43 -0600
Message-ID: <20240222201559.1293947-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222201559.1293947-1-denkenz@gmail.com>
References: <20240222201559.1293947-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If qmi_device_discover attempt fails, fail right away.
---
 plugins/gobi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 2b29afbefdbe..c4e63b7b464f 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -423,6 +423,7 @@ static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	const char *device;
+	int r;
 
 	DBG("%p", modem);
 
@@ -437,9 +438,11 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
 
-	qmi_device_discover(data->device, discover_cb, modem, NULL);
+	r = qmi_device_discover(data->device, discover_cb, modem, NULL);
+	if (!r)
+		return -EINPROGRESS;
 
-	return -EINPROGRESS;
+	return r;
 }
 
 static void power_disable_cb(struct qmi_result *result, void *user_data)
-- 
2.43.0

