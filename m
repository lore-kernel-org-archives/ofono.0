Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152C46453
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116594; cv=none; b=X5+qLj7NqASY9zy+2mToGDIG2tZXVKF1GGzw02X2h7zRR+B609shkHv56GNMvRpmDCs3sWzH3UTo2KDBJIXgZi6LRPGgafpAtJ+XnpxvQvlK+ZXSunOA8+Ds3fSkDdYWizgvbaM2P3JB2MsCzFXOQwM/19fsl54/gmWnmhRwLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116594; c=relaxed/simple;
	bh=svGUzHoaR5yP/BFo4XrE1O4VWjuO5JyLktkaHhJ6wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKB//HGP1FfnqUlcVSmje3W3qDnbb2GJqybQd6yPg0s5DnEcL457fvXG4YlbwoaxbDn1n8cjqC2HxHOoW13PftYlPxWQaHaH/ffTG6gEsXu9z3eG5ig8ZOlhJ3+qqwNF8ZuXnvBEUXlWw26p+m6kpbLJ6DnZ2AQq/ndkcGblmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4/q5+Ov; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4/q5+Ov"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a21859a4b8so727224eaf.0
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116592; x=1711721392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVsPuW/g7+EBBvGGprHEy4VCYnfPu3lslt5Y7BuTzaA=;
        b=U4/q5+Ovx+ec4WTHTeCb2BVLdo66kIeC77ys512AaY7yVOs9nrZy4WnM/O2+4shVXE
         tqT6Fg4jKnkxeld+Z7KDf1WoYlqcVDceU3IHUgJ1xl1KALaj2tzO0blHWOicRRH4iXPO
         XoL8RpPhE6yQ5rm4Lsy8qgynO577uO1/5b2I9h/uWSLm9lKRqaxByAg93kpBm9w+OqAn
         q2D987x5C5JE3yrOBS9k4IXsN2SCcKICZve/Y/GcS9ZgFjO6bl3Rd+UeIzDqzC4Tz1l2
         qAdGwkrWrtRYR/hLLmG+GIkQTY6Kx7w3NSLcVYTHJlT4KUIiYybJgmOX2hdt+mMzDXe/
         qU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116592; x=1711721392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVsPuW/g7+EBBvGGprHEy4VCYnfPu3lslt5Y7BuTzaA=;
        b=U+9nDjXxNOlBIWcu4GQ1ckXelJ6eWGFD0GDgr/pJbvZlTy6pZFcwy8amS7R1AbnVxB
         aQh/v3cxlxTLTZLUYfQeoI+Ht+8w9hD1JR/In2WSmmyQmUuIzYWuqYEZuKadEarxcC+R
         0P8/86i+7AjSMkYx9pFh6dTRw2aTfjjs3zEUTI9bAYOZXXZiA10EtwTcvBZPWLL/92CT
         hqFvhl9qt/FfBARLvfS6yeW0sHRc26Kt3l3tBf29YYT3/4gsT/iyRy2CBWP+mnAxj7mN
         TH2wg3kSHwbN0jCd3nzvj01mxgxAeQ77HBAUGSepGjBtya2k5Q9Gb9oPP0L4JNq1ySka
         X1AA==
X-Gm-Message-State: AOJu0YzROEOx4vG0G+wDLky9bz5OmnK/5/Fl5slx7zVPBDh8TY/0wUqK
	RHoHXTyMYuBPR4R3ryNSsDjUUhA/WAR/tZLhybr7BGz7DBcudXNS9kmpgxQp
X-Google-Smtp-Source: AGHT+IGtcJUM6S2FpQWsmWDolCZhu4QcqJHobpJEOjspnx9nEa74FB8kYwsCYYNvsbDQjD8dUstYIg==
X-Received: by 2002:a05:6820:1e01:b0:5a4:b8d6:3be7 with SMTP id dh1-20020a0568201e0100b005a4b8d63be7mr3038709oob.8.1711116592195;
        Fri, 22 Mar 2024 07:09:52 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/11] quectel: Set modem lte capable
Date: Fri, 22 Mar 2024 09:09:12 -0500
Message-ID: <20240322140942.2703042-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322140942.2703042-1-denkenz@gmail.com>
References: <20240322140942.2703042-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/quectel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 69e1ff48729d..18cc33123759 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -648,6 +648,10 @@ static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	}
 
 	data->sim_ready = true;
+
+	if (quectel_model_supports_lte(data->model))
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
 	ofono_modem_set_powered(modem, TRUE);
 }
 
-- 
2.43.0

