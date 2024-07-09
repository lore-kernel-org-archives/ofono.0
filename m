Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113E155316
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565452; cv=none; b=q7V1IsYmShcKC+9jWDVuOlJ5huZUZfrdybaNINCwbZ2fkxHAowQEke7Wx136lH/lhb36/8cej2YZx7G7cqjon8mu/VMD8kFqM5lkAhcEkuyfBTrkv2jMhR352T4/rLU+djJBRFT0jF4R6CJ/dTGxlXrjpoEwaq061L4PdpNKN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565452; c=relaxed/simple;
	bh=dffnGkI17qSPW3b25IONLAlEAPrFwVApJ4+yj4idVS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZRnHU+WFXff7JUY/P+CEcm00pJb95kkCfFOWctuIrmSoXRoeOwlUDzJAfLsG86mCCbqGgfYSUWGJMMq7wFevn9JPxHYKDDo1ZGmNbnc+7w6yW8QVgoU2YibL7KzZwmkt4DJJR7mszWEoWH0y+NHzCjc9tbls40M9GJMVmQfQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9x8F7yc; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9x8F7yc"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-381f24d6bc4so22519375ab.2
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565450; x=1721170250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c2JHjrV2CQ00glYH/m2D0yKTwf7Wgj38pYLIWfkVyo=;
        b=G9x8F7ycki5MHLROpz9fwWhoo46tv3kI3J8dRrqinvY6ROoj7Kj5JS+t1MGvY3ZzFg
         U2CgrR+8s5T6PHz4VCl/CPRtiLfs/7a7KCaods9WjJ8CEy88nB5nd0XqMnhi76nfhnL9
         p72WDKJ+e3JCnnuCWirqMhMRwsbEuXyiG1/uWj3MYyp9JJhQLzG8849FQ6+I5+Vo17y+
         +RgVtK2UeHrHVKV7qygGdT0kBK6g0TKVrPlK89I3DhxjKFnXIgMz8LdWfo0bSODG/11h
         Mfo67zskee4Nu4JQSdQyy/duTD6OPzpuAsEY7wqAnpgs5zfUx2RhqtXwMpCYewST3BwL
         aAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565450; x=1721170250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c2JHjrV2CQ00glYH/m2D0yKTwf7Wgj38pYLIWfkVyo=;
        b=T/0XjkX14/pxt/TTWibFxmCg0CxmsROT/pnsxzmBD6oED6aylyW02AUqNsgReSzRm4
         laI5NAisVpzPVB3eahHez8GpLUbMSyfgB3aaGpastT1eENa/mrye34Sv5jQCV6rND3t8
         BmgvwbGqWzxGWo3+FCjp7AHPKyUhpWmnD8SP4kcY2OQO+EDMR6ZEzzG1D1IW17Lcs6Mj
         87MEKim2ifqcfkIzZQqM6sLWmTUXNf32wBL3gl70chGx9qcc+vzhChnD7E+Wlw6uZNgq
         uMC5gm78xhq5DPgh+tK9MgKEX7opzGIEZS4mwtQO6hpdtmqE92iGk2IbI0GKmBs1gCie
         6Lcw==
X-Gm-Message-State: AOJu0Yzn8iWqv6V5DSEn6F69y3nHG6QUlMRy54lzCZdX2Nz6SACuHDOW
	MSBjpJ+zNMY8jWW1PM0pI+wJ+kh1Y3HBQeTRMcb8hSKBpfxbXnMpMRNMxA==
X-Google-Smtp-Source: AGHT+IHcswGz9Mo4UlK2856+Dn+oxy93+XQ5ngEXIzbgAsDNrRZ+4OunTXpmNv6UzNsH17ssQTE/8w==
X-Received: by 2002:a05:6e02:164c:b0:376:2202:a84f with SMTP id e9e14a558f8ab-38a577e8dc9mr49908445ab.15.1720565450545;
        Tue, 09 Jul 2024 15:50:50 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/11] qmi: gprs-context: Declare qmi_service objects using _auto_
Date: Tue,  9 Jul 2024 17:50:23 -0500
Message-ID: <20240709225047.1427626-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709225047.1427626-1-denkenz@gmail.com>
References: <20240709225047.1427626-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies the error paths slightly.
---
 drivers/qmimodem/gprs-context.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 3c18476142ea..7d13889bf603 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -554,7 +554,8 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 					unsigned int vendor, va_list args)
 {
 	int mux_id = va_arg(args, int);
-	struct qmi_service *wds = va_arg(args, struct qmi_service *);
+	_auto_(qmi_service_free) struct qmi_service *wds =
+					va_arg(args, struct qmi_service *);
 	struct gprs_context_data *data;
 
 	DBG("");
@@ -562,14 +563,12 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 	if (mux_id != -1) {
 		int r = qmi_gprs_context_bind_mux(gc, wds, mux_id);
 
-		if (r < 0) {
-			qmi_service_free(wds);
+		if (r < 0)
 			return r;
-		}
 	}
 
 	data = l_new(struct gprs_context_data, 1);
-	data->wds = wds;
+	data->wds = l_steal_ptr(wds);
 	data->mux_id = mux_id;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
-- 
2.45.2

