Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB310199EA8
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306915; cv=none; b=eND2V3uPaP0i/I6LABQok8z1UNmsrVYhnio+4DI7jY7UTE4Rk8zUXvV1QifGL8iX1t1GDPkIPPetHuQfVdgGKoDMh4NicqjOS1xTD4uN4YY3R8Ow5ZhUdNHXEt3IMVtTNsnwtCQWBN8e1ZczjRbB/e3RTc0W7btAJl2dTA+S76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306915; c=relaxed/simple;
	bh=bxbEpxSkosb8HVM+abnrWY8xedVA/G+uzpZsMapkEVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDXiGnWAwKEM0rd5IfGPfbow42MYwCJcx5NnZxkTNPXoH2oR43yoc1Im6ASwBzW/NjmTjKj3Wx2dYXRahQppy/UeZzacqlyGCoV2JbpOLoyK5vXsjNM+YKj9eRepYaHusAY/Ag5tTQ38sChaKO5Se5OlN8z1h6iIVu2sa0jgISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLbZaYT7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLbZaYT7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385eaecc213so356772f8f.1
        for <ofono@lists.linux.dev>; Wed, 04 Dec 2024 02:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733306912; x=1733911712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTg4zyvFArK2GtakfY+yVOiJGlieNOkE13dls9pcztA=;
        b=hLbZaYT70eCIdYpDtNvyFSykgltSYoOvk2RhsAD8oOpXfLckHQ5o7RrxNNqzHZambw
         diseo5eJ5cnn8meStFPnXwvKe6sNGpduXbMpJB/cDfWfSMcF0fpvwn36Hv+n6lDbfhog
         7tF2EthuGEo7L5ceayieej7bdGTgdBXXQhxoBRCPbccfrZ9pQh6CV80xWRPv5F3HXnKO
         s4UzE7He6uaQGpyQwQRVs4wAv232tGJZrqngO1pP4PZnk4QaJgtsBzudkM5O9ix1QIwr
         4IjO05wXIy3Oim9FtS8cXQMf7uoPQ2GwtrbIS3OtqNgonBf+y140pXgRi+67RQf8eE7G
         /kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306912; x=1733911712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTg4zyvFArK2GtakfY+yVOiJGlieNOkE13dls9pcztA=;
        b=ZJVQN8TA2fOs4GEqBnU4xdAG8G+F08GJEnIDYdaywIA7lXcfhPH+yBdjENHwxqVr26
         yDexup4Ajl2w9+lbe/xFWcBW4Smd1OoK00qIug8XM8gp6Hc7icOE0cuD++unmxL/ZIkP
         /Bx+Zlr7ITFEpQQepx4Ln029xfELRoMdFDeYO2dwYa2IvB4OtoitbyK722dWl8o5TM/E
         UI1KnnP5+9GdsDQqAcTDACkB3J/BViHMabCepTjrdidfJqAf9C3AHLZL1maRSV4uyfn7
         qWgyIYO/8vGbWs78MN+adPZnOD2jquMRusxDFqc+F3cj+yjnYLNPwVq8xq5IKAJK8Kue
         S5Kw==
X-Gm-Message-State: AOJu0YzJdLhgIPsnEPZL0iisSLLdRSLqhBHxi5jzGa9R8TR4wLGGD726
	sj9QDcMgfPwgAx0f6H2V/kOd0vayOoaLPyVM9QBWeg74b/9ZyeF/JQ9Zyw==
X-Gm-Gg: ASbGncv8wM+oSrfpF2mRisJNUyMHlACudYlWjQ0RWajbvgZcBUoms0IbH5G0wBV4SbD
	PsyrMr9MO//836WmP4RNiB4lu1RAdT9Ia/JGMVKZCXQo+jMfyFUYN5IGrfllM8i8qJ4QEW9nJL8
	2EfIvIK1ZffCekYrYN0aWQbWbzBDauXHZ7U2xjgq5kf4A48fZW4MN8fdbMredxaiJUkmn29V2oW
	G2tAc2uG6WV4OzItlfg7nuqgPZwexxTguPgbq1MgDfNlEFlQQ==
X-Google-Smtp-Source: AGHT+IH48AqUQSPyQr73JR9EnARRhLRNuIWUKuO4+GXGE9sP7QgHgx8Lglzn2HjmPoV+I+xdgFH9Eg==
X-Received: by 2002:a5d:47a7:0:b0:382:45db:6a1e with SMTP id ffacd0b85a97d-385fd97edadmr4922752f8f.14.1733306911893;
        Wed, 04 Dec 2024 02:08:31 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f343f293sm7892027f8f.36.2024.12.04.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:08:31 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: ivo.g.dimitrov.75@gmail.com,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] stkutil: ensure data fits in buffer
Date: Wed,  4 Dec 2024 12:07:34 +0200
Message-ID: <20241204100758.4931-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes CVE-2024-7545
---
 src/stkutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/stkutil.c b/src/stkutil.c
index 60cad102..bd261b1c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1916,6 +1916,10 @@ static bool parse_dataobj_mms_content_id(
 
 	data = comprehension_tlv_iter_get_data(iter);
 	mci->len = len;
+
+	if (len > sizeof(mci->id))
+		return false;
+
 	memcpy(mci->id, data, len);
 
 	return true;
-- 
2.45.2

