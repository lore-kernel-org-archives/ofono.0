Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E01350DE
	for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130849; cv=none; b=mZCMTfNyuGia6N1BBgA+G5ZwbTluOs1HUcjtIPWW0YITEZJk+PCc/fGG6rUbcrXWNZA5zyjnKIsZfXZRJo0BlgR8+DoxV9htunJCDBY0J6b5a9X5X4RhLLtJwz8FBobe+dc1KG0JwbM0O83CQoz+hmouKAECqMysnGll1VNhfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130849; c=relaxed/simple;
	bh=sQ1l2Der8D5kxlRBkfOoOgOyteEr+bW7WySeHdBycZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozZ0VwuRAhrvIVD5bjE4en9i3O6MqHewQ6PNm9gyC89h/Ey0+xPuXAtL1V8CNxtl6lpdeClQk6RG/eY0ww/wSbSOX3ywkNj22PmVyHZLAxeG9zZnpWbVS8x5do4+8I+r7EHe2J551Ram+NPjSs8fiGgFjzwjwI8p2wZZcCfZS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWus4FP1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWus4FP1"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd67e9d6ceso3741901b6e.3
        for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 13:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130847; x=1706735647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWzySUIZgdMwRyadTX/o9ThHpMkrhHI1ib7TqArzy+A=;
        b=kWus4FP1L1uyZOtmI8hMqmRl2pcORWj26rJfTkiDkGCzkxTeK26NLQ4uU74ttRKo95
         pNa6XbLkr8HBhQMtj0yVyR8vBKfH7IZPCvvzUe2pPHIap9lE4obKiWd2HNBWGm5m++Kw
         OzpXQYLRaWNe27U4bqdz2WsX0H117/3dzuEHMKw/5BnwOB5v2M3/LsEs/t0z5lg9mw6i
         0coatFLuEYHVs4yNqck9/OjsX9EM9xLKE7eFG0qsXqbtL+8Auzzbx7JdrVJpfVnQ+at+
         HnHZggCyLu8KefKe7bZh0O6Is41nz01b/AGvSeccoLEa+TBiPMPm9DMMKDHJwFQNa1l4
         2jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130847; x=1706735647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWzySUIZgdMwRyadTX/o9ThHpMkrhHI1ib7TqArzy+A=;
        b=rOdGllfuw0tO+glS5O4h826qY+8kMKNccT6ex8jxT8NHJaRANHuSfepjcGn2FRKJ7s
         SUcUqfIJUX/j9LPWqpg9Lp6o8iA5sOhU+qODqo2266i0yfFcYzEDAw9yCEL54/bOjPPO
         cUxfWF5iZpULOCb3BjjD9zf+QeLHDQ+XzFvvtcPFCsH9mBrdWmeANxQ/G2Vmq2dPyrTe
         pAPQ3dZ7f7VHE31jR2Y72CleLowDOZP3KsAs+RqWQ1+uYGTOP+tboTC4DkOcjGQkt2WB
         VL6UwFWwf9CYT7T7P1CoxLGRow7oealF4r0qzlBiEXVBgRxGFPlM7PFbTgXZWE0cX8+c
         lrnw==
X-Gm-Message-State: AOJu0YyFezHJsMcuc+L8zs70dbuLYTXA7GRuXPJKpIVj5WbwUHyMYrNj
	d5I7IRoGapCLDyCQBj80lrIbZy03d6VD7Qskrt6F+Lj7KNFd8mq0mtvYD9XU
X-Google-Smtp-Source: AGHT+IGiyPIu8tIaNI0vqTdDAz9V6DydfZzitJbqdtFuS8YYj8XOCeWrCTiwxNGui3A4OLAD9f7o6g==
X-Received: by 2002:a05:6808:f13:b0:3bd:bf47:d635 with SMTP id m19-20020a0568080f1300b003bdbf47d635mr2495611oiw.41.1706130847263;
        Wed, 24 Jan 2024 13:14:07 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id t27-20020a0568080b3b00b003bdac23eb89sm2003318oij.34.2024.01.24.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:14:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/4] gprs: Add some additional context types
Date: Wed, 24 Jan 2024 15:13:01 -0600
Message-ID: <20240124211317.611706-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124211317.611706-1-denkenz@gmail.com>
References: <20240124211317.611706-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These context types are currently unused, but supported by the
provisioning database.  Add them to the enumeration and update some
utility functions to handle them.

In the case of SUPL, the context type can now be set via D-Bus API.  IA
context types will be handled specially by lte atom.
---
 include/gprs-context.h |  2 ++
 src/gprs.c             | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 81055d89..5d5f0be1 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -37,6 +37,8 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_MMS		= 0x0002,
 	OFONO_GPRS_CONTEXT_TYPE_WAP		= 0x0004,
 	OFONO_GPRS_CONTEXT_TYPE_IMS		= 0x0008,
+	OFONO_GPRS_CONTEXT_TYPE_SUPL		= 0x0010,
+	OFONO_GPRS_CONTEXT_TYPE_IA		= 0x0020,
 };
 
 struct ofono_gprs_primary_context {
diff --git a/src/gprs.c b/src/gprs.c
index f8b6fd3c..7b681d85 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -177,6 +177,10 @@ static const char *gprs_context_default_name(enum ofono_gprs_context_type type)
 		return "WAP";
 	case OFONO_GPRS_CONTEXT_TYPE_IMS:
 		return "IMS";
+	case OFONO_GPRS_CONTEXT_TYPE_SUPL:
+		return "SUPL";
+	case OFONO_GPRS_CONTEXT_TYPE_IA:
+		return "Initial Attach";
 	}
 
 	return NULL;
@@ -196,6 +200,10 @@ static const char *gprs_context_type_to_string(
 		return "wap";
 	case OFONO_GPRS_CONTEXT_TYPE_IMS:
 		return "ims";
+	case OFONO_GPRS_CONTEXT_TYPE_SUPL:
+		return "supl";
+	case OFONO_GPRS_CONTEXT_TYPE_IA:
+		return "ia";
 	}
 
 	return NULL;
@@ -216,6 +224,9 @@ static gboolean gprs_context_string_to_type(const char *str,
 	} else if (g_str_equal(str, "ims")) {
 		*out = OFONO_GPRS_CONTEXT_TYPE_IMS;
 		return TRUE;
+	} else if (g_str_equal(str, "supl")) {
+		*out = OFONO_GPRS_CONTEXT_TYPE_SUPL;
+		return TRUE;
 	}
 
 	return FALSE;
-- 
2.43.0

