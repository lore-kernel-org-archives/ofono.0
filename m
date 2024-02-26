Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08414008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918654; cv=none; b=WGwiHkDYcWCM3lDO6DV/8iRq0F9CXr3R8tu9n7zd1t4AmR6iLHv+XW+wHHYfVSqc9K4VVmm1NYrljIaA5cI4W8mJSVbfU+gCaMh2v0P3KVCTIjf7g13qFWDGpwWPc5igb0/m6B0GKFbIXRxRm9rDzFvoBv0HnCLM20TXeNGeWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918654; c=relaxed/simple;
	bh=pmXUpmJL0WjCROdBkmZeDlYHEe0AvPHhS8xNUDT1Pi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/MNZCsaid6v9nYvEyhIZa/Agme1nTK/mt/vIuRHMif9gvqNLJrufCd+mLVXd4LzloFXZUMCMry51YD9W7ZMlq53PnYWbQzK+7+IYdDQ69d8yy8GBYMvG0u+ycjP36R5wOcg6GrDvz15n/3PKp4H4fabbvMX3hKZNs7mQn1xbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me2JSAB+; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me2JSAB+"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c1a172e46bso320295b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918652; x=1709523452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r56Qipg9e1CjBWEjDS+aIR96yI5YLGLmK0sYuF2RKOQ=;
        b=Me2JSAB+WodZxKC1kRWw2kq4JP7wfCOzPhBG45IM02X2bPJ9f80co0lNqhFe90uny6
         JuAC5r+0ulYPHLTHEg7f9CowMlOTE34xzn+2AmQn6ckb8bcICWDKfWPtPD9K/jkJUp1w
         EA50AeX0lBxanBmYxs4diK5yZ4Gg8+ohm8WV9CQKZNBaww/F9QqO3N5ht+F/G1jSIOLY
         tf+es/AD7KO5V5Fiu35/Na0AP9l/En4emn2bqg66APCHh5sUM2JnkjjrIkTVgM0wcDV3
         ImOzWFklWs4zWAVhbVagFFjzAY7Ybg5ZXJg+iAWfBY6NsQR9VISDxXsa+2N55V9GUqUF
         GH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918652; x=1709523452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r56Qipg9e1CjBWEjDS+aIR96yI5YLGLmK0sYuF2RKOQ=;
        b=oFg/oskCrGLVDeR10mI3NJwJIy4m6fM3QpTW5ii0yqTHOzdQbnqcRsxWYBQHcbdYmY
         Wzp3M1eKs+RXFIyAZUBZ/SrDpNKBSekkPQ9jcQDbubdWx341Mj2QBZ1rA6UvkLf03++V
         YDMSMzzqGWji/4Vo3gvT4xefSr5Siodu46oYQeRzdqtglzd/raz+ogZxWacCtYOEOzSt
         rNjTNu5kfDYG8JPifypwS+9MZcNOGqpSNCJ9DqwgIQ3WpgWDwCPlaUDNJkf9uHQPtZgc
         I+qYaJdEAxHUHAfC06hGS2szMPxwg42Vset49waYO18gmOAakX4BkH2iL7Nv1NrmDwKQ
         zhqg==
X-Gm-Message-State: AOJu0YyYjh5+4ipO0IqqRYEV3TfVDH4kBRJAZuSPGW7MXVHJLQkwoa1J
	c3AvU1O0rafIr7YEPISuqEWWWXBSCYb0KIWqD5HsctHBXOphEaKLkwPZFOQm
X-Google-Smtp-Source: AGHT+IHnP/WUlC0UaJWrfO4POFawOHGKSWjVDeWZZa8A2030Mql5I4b8b0lIBqMuqcuSbJP7eAnzQQ==
X-Received: by 2002:a05:6808:3a0d:b0:3c1:83e8:4e99 with SMTP id gr13-20020a0568083a0d00b003c183e84e99mr11839344oib.32.1708918652084;
        Sun, 25 Feb 2024 19:37:32 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:31 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/22] sim-auth: Remove g_strdup_printf use
Date: Sun, 25 Feb 2024 21:36:52 -0600
Message-ID: <20240226033724.1460079-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_strdup_printf
---
 src/sim-auth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index 6dab52eeebde..679343263a09 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -138,7 +138,7 @@ static void sim_auth_unregister(struct ofono_atom *atom)
 	struct ofono_sim_auth *sa = __ofono_atom_get_data(atom);
 
 	free_apps(sa);
-	g_free(sa->nai);
+	l_free(sa->nai);
 
 	if (sa->pending) {
 		__ofono_dbus_pending_reply(&sa->pending->msg,
@@ -671,8 +671,8 @@ static char *build_nai(const char *imsi)
 		memcpy(mnc + 1, imsi + 3, 2);
 	}
 
-	nai = g_strdup_printf("%s@ims.mnc%.3s.mcc%.3s.3gppnetwork.org",
-			imsi, mnc, mcc);
+	nai = l_strdup_printf("%s@ims.mnc%.3s.mcc%.3s.3gppnetwork.org",
+				imsi, mnc, mcc);
 
 	return nai;
 }
@@ -751,7 +751,7 @@ loop_end:
 	if (!__ofono_sim_get_impi(sa->sim))
 		sa->nai = build_nai(ofono_sim_get_imsi(sa->sim));
 	else
-		sa->nai = g_strdup(__ofono_sim_get_impi(sa->sim));
+		sa->nai = l_strdup(__ofono_sim_get_impi(sa->sim));
 
 	g_dbus_register_interface(conn, path,
 			OFONO_SIM_AUTHENTICATION_INTERFACE,
-- 
2.43.0

