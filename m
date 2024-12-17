Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B8188014
	for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427943; cv=none; b=eJw7yXbjQkmcWZU4cqP3xfR4eqcanbCGo6rnqLBogwdRXh8BNtA4SYt9lIYfwxRx/hyphYQDB/yFuubX+5AfT6SdgfwhM+E3kcP/NyNRE21KH5Yja0St1aXZHTzPFySQrI4SysESQ0GSJ9rV+8M7ehJW5OFbsmzwDszf2WWQKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427943; c=relaxed/simple;
	bh=ILZAYwUk/DSCT7EuUJZ2MMDiq7SKf25AU6N/814bC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOadK+r6Qt7iEYjWgHqzyG8/VADOD2YyzpzVSk57DmuqZF8xJKImmukxf4DYx9FOyQbogfcJzv5gbBosiT1yEgQRdEuhBLQpeeKFfhnmva2MeCE9YnxwlJtyJmJUCp0IqKfglXZdlmNCeDUsfyW7dpIPyNr5sALo7UreFR+VCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBDsLYrq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBDsLYrq"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6aee68a57so743453966b.3
        for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734427940; x=1735032740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsc4o1c6jnSv9LOCDTRbPOWWQRnItGG2p5/yupt4Hw=;
        b=JBDsLYrqB0c7EYw/m9y9e+bDYTHKFXlUpPCT9n7zPIq5FcacfehobSCD4LkATikIh2
         nHLxWPmMpV4uyNylJlX2dj9kEhG0lAPSU0SR+1rt+rZZsfAVUtFt0Q81CPwSik5Btg8W
         4DAca6tMNY7/8zVdQYoMmYyFHhcR/EszMFFhRIlqWPDCRj8DDQF7ng65oJvmuwePWHzX
         x2lQFZBccd5JG0GsQ4YVX/wUhSd5btyEvVhVrLM3UuDFYjes/K6X9gQL4zfSJ4rCebJv
         Rh6L/Es4gHlJ04vG678aSynsH4mdTug618x13x0jhhAT/WZ6wdA6cXz5R41nqN6Tsjzg
         ErvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427940; x=1735032740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJsc4o1c6jnSv9LOCDTRbPOWWQRnItGG2p5/yupt4Hw=;
        b=Baqg3SC1elCT0bcuzq9EEX31Pf0Qa4aYx1Ppw5w/661TbmZR6N3y99QsO9DgDVCwC8
         /Hq+RaHF9pTK84lbbx1cZBTNwX2x+0DhwZhjHez02fC6KIUYoGj0kkwgmhs7YtSErszl
         S3BuW5RWwcs7Zvt1h8X3UTPp4ZU+9LMNwOGd4QYeY+CNpcC3JLyUEbvq581BHb+MMCth
         b5xxQwWUAoq0yv7cJowGwosKbg+YOJDtTmC/usxaYlHk/eAm3+Hkk+FG5fnOWg/FFGjC
         fKUVw+wGPm/U5d5E0B5KryoNONZFK2WxtIGiMVhbtee/jYmBfmO8UOuzL9cJ72fez4pR
         90Qg==
X-Gm-Message-State: AOJu0YzkGPAXEsTjXw2ctHHfzXFaNr/2I+iFdoNiEiJ3DZL/U2cFbu8I
	EBkXk1bt9aRn/OkqP3SAi2gnFbVC0FdN9dQtdYI82l9dy0pxI9OqR7goRX+v
X-Gm-Gg: ASbGncsrKiO5nEhcADRRyV+dN1uNu5xJx0t68Btpm0hvMh5+yEbbPAtEUKqraQuOeC/
	CsloaGhvC24BFPfP9Ch01ByrYywGl/vhcLU6mcw9qffblxv+8QWVQwTUX+XgD4ISf/C1Shff6Pg
	yYnq3mT3m/KElBVzNXYRJ37EMQJnLMwwaF9Rc52ZakX5+nbVzypg/ub1cQuQo422CuCXW08vAt1
	h4PzJevwXES5NUhLBMqAkU4ZtMEjDdgf8xHiXT+RReXOuHrvpOrgS0E
X-Google-Smtp-Source: AGHT+IFk5Nw4iBx4Dpijv3Hlv7jq/2dZ1wIkUFSVzvE+pN3ql9rN1BPTTQx0yxN+zRj1TZnZvp2GlA==
X-Received: by 2002:a17:906:2931:b0:aa6:85d0:1486 with SMTP id a640c23a62f3a-aab77ee9688mr1325012666b.54.1734427939240;
        Tue, 17 Dec 2024 01:32:19 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963598b7sm425536566b.101.2024.12.17.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:32:18 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 1/3] util: ensure decode_hex_own_buf is passed a valid buffer
Date: Tue, 17 Dec 2024 11:31:27 +0200
Message-ID: <20241217093207.20636-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/util.c b/src/util.c
index 53d55d7e..bfe46ef2 100644
--- a/src/util.c
+++ b/src/util.c
@@ -3181,6 +3181,9 @@ unsigned char *decode_hex_own_buf(const char *in, long len, long *items_written,
 	char c;
 	unsigned char b;
 
+	if (!buf)
+		return NULL;
+
 	if (len < 0)
 		len = strlen(in);
 
-- 
2.45.2

