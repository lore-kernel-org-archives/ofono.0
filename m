Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F378270
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230074; cv=none; b=V2TIUuEl3u1Xx2JSdiVj9N7iA/Gqr5OmupoVAAr3it1I1jhCpm+AbHgZ4bc7pEJZ+tTSc6EzUwmo02aMFGr4X/FgJ/qZsmt1MJ1mQ6fO4UjTRTG4Q3EovLyB1b4E4/UAYwQeacs7eT3tszfn8c//sz6CHKUOgvNDoUWdXjXBNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230074; c=relaxed/simple;
	bh=Y2VVKKTK/rnOwl4gqjiAvOpaI11f4QqeFvyNkRXzGHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rASlhUY9o8zCXHrf1Z0myWuk87K/qVN2r1w+uKubJhaTbhIacg6069KL9htOxF0Y7kC0jVt3DNA1RFURe1MO/64GWvp2uGeeO0GGzm4IfICDD9gegn4kz7174r0bK/VSn2WobCq/rkuZjRPiAEo5VG1yqXzRZmhrYX/V3ejqeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBUMsavq; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBUMsavq"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21ec3ca9ab9so539183fac.3
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230071; x=1709834871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJq6d2m9G4HpunIJ7Ho76OU9gbVxJv+agHVJAKKuhw4=;
        b=WBUMsavqA3UOJEu8m97x68XYMY2YMYNj0x8pMKYn/cnNXst2nkpfDFeuaRDwGMsmDi
         AkkOZDbBDzhfyILhpiJC+DEFGhEd3/9WkUE3F/T59/bcdrEs6v8d2oub5SoTFiobtfxl
         0bdfNw79KLiWAbKXWjzKbqC97NqN6U0chSwuD+xaPQdwMPZ7WKYGXWsB2L9+HgyGx3Op
         wCypAqVniLBYuKXGBHg+HxqDG+SyR6kUl9XPBThv7OxQP8Q/Ga+KjuVbUuKupyXti77N
         mz2AaGHkPOoscfp5/LAN4v/surrgBmkxr5Wy7xdw5PfbUFqpd78Tv/JLEhdmq6nnooxg
         GLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230071; x=1709834871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJq6d2m9G4HpunIJ7Ho76OU9gbVxJv+agHVJAKKuhw4=;
        b=m8G0lW98EfrFECrpt4OUa+EKwqUrQbJvX0cHqNJd4t/DEVK9eUD9Ch624OIu1xFjBu
         /tSMAB8YyYS+vQPxpvmFydicXV5G0CtYkPBqGIUucq1Xsvj/hIV/20zYwBev8PCg0M6u
         bpUxzfogwpqI4ZBwD0LY0UvQZOjn46ymXmHwYlzulnHwHJfNn5e7ZNufkD3TXBP66A3C
         3yowBkmAqbm/jHp2rSMSs59wAmhB7CkYfL8b+fiv9Jce4JZJ/OREHI9rT6cCOcb/W71g
         zGf9KWHx3CySCMOj90wo0Eg69XF+xT4UbN2FkYSl+I4UOSjb45rU1hSOYZatWs2nD12t
         FiDQ==
X-Gm-Message-State: AOJu0YymUGowOaqGHtTnyLK0UTtDyTTysHiKfLeQ5JNe+Lv0OWGaJENM
	UmLD2Le1oEBOCNha/aOT8NTJlRUmb8mEANjnY7h5K0I6D/1sUQdDIHVzGIVY
X-Google-Smtp-Source: AGHT+IH+4fPcb5mhRHOxlp9LzwEo2D4s4ivCoryh590gehgcjO9TCxiOMAWSDcL4L31+DoT9BTUFQA==
X-Received: by 2002:a05:6870:a2c9:b0:220:8d36:46f0 with SMTP id w9-20020a056870a2c900b002208d3646f0mr2919230oak.11.1709230071340;
        Thu, 29 Feb 2024 10:07:51 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gz14-20020a056870280e00b0022008c33ee0sm549899oab.36.2024.02.29.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:07:51 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] simutil: Make sure set_length on the parent succeeds
Date: Thu, 29 Feb 2024 12:07:36 -0600
Message-ID: <20240229180746.1671015-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229180746.1671015-1-denkenz@gmail.com>
References: <20240229180746.1671015-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/simutil.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index a4a8f8c4b230..543ab9962ef2 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -588,8 +588,9 @@ gboolean ber_tlv_builder_set_length(struct ber_tlv_builder *builder,
 	if (new_pos > builder->max)
 		return FALSE;
 
-	if (builder->parent)
-		ber_tlv_builder_set_length(builder->parent, new_pos);
+	if (builder->parent &&
+			!ber_tlv_builder_set_length(builder->parent, new_pos))
+		return FALSE;
 
 	builder->len = new_len;
 
@@ -730,9 +731,9 @@ gboolean comprehension_tlv_builder_set_length(
 	if (builder->pos + new_ctlv_len > builder->max)
 		return FALSE;
 
-	if (builder->parent)
-		ber_tlv_builder_set_length(builder->parent,
-						builder->pos + new_ctlv_len);
+	if (builder->parent && !ber_tlv_builder_set_length(builder->parent,
+						builder->pos + new_ctlv_len))
+		return FALSE;
 
 	len = MIN(builder->len, new_len);
 	if (len > 0 && new_len_size != len_size)
-- 
2.43.0

