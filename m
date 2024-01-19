Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C557880
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698678; cv=none; b=hKMmyatt4mFssFKi+EZ+DNpqI0qLhGJxYZ7Q8UinUQybtaK898XJicagGLrxvQkxR3g7INrqzoXa4nDQBjLWYV8rTAOU7U+SONWvaVlaqxTPglUGsw6tsnSSSjW83WVGTjRC31qoxl4iFl6mPTeQTsLdiaDuCWVxIELDUXHPwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698678; c=relaxed/simple;
	bh=VKS9imeCX2hVfpebIXOpJrJ08hQ2Sj3dg+8+r0dUp44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eokrf8s9AbUJWefPBCIOF1SRX5PCfePRRrEV2tPVO0gxtqc244y6enS4jDVSTEc1pzaAnZ3pWUtKfFXmuSK2V/lwO4qH7z9vy6QCKfYfF3zminYGNtkBGTlY74RAyslQW8n3kQ+6PQmaAxnikVKajFP7KnXmzi4URPmwLIceUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck/njDzH; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck/njDzH"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e0af93fdaaso851601a34.3
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698676; x=1706303476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flYcAywdIwkqY6MNDT407112OOjiHDSQCFW8opnWmpI=;
        b=Ck/njDzHxIycwrSO7gdR+9OppqJYXwtuNbcdBzvFFsP/8lVTwAs2RCfd5wgqY0HhuX
         z/fFNx/V7oFsvZ1Z2t6zeMerMNpVdEbebHnXRQ0vM7eifivWz9rXpWv76gk0P9U9MRUB
         rigcZHiK+9XrVnlNg6MuzCD1S0m2FZvBAVpx+UTzNXTVwR+SfTudS3gZbXJRWcEaA5g4
         KNRgsSwwXFdwy4QzQFXacJpB2+q2XRLeupikHLq5lnIko4+huhLk2V0i3HCbK+5K01AM
         9Ze/rxmleTvsXGAgrIO+aSY/LFHZNXPJbB672DJaiAZAimuln4vUvwC4gry3Xyh/yfgs
         F9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698676; x=1706303476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flYcAywdIwkqY6MNDT407112OOjiHDSQCFW8opnWmpI=;
        b=teloLEL2DlfAGE03IC+h1ZU+DfTd8seAa5Yr0PhRS9lKavHlUXVr9uM1neDReouIuL
         tD+idRkZJZ+O65xydRLRiVbArABsdwY5Z2LEyyMR3Tr7AdN8Z8fOhXr2R76BvSYBO9dM
         JxF439BSqOdGZvOzxwljbTbwLmU+Mu0+42AG//HeCEV5XP4xQ8kSvElGu26gxVASZ2QP
         F5dGTqTjI0Fb0MU+voPBq9KPg4CdM9+SaaZvJuqGgwJwzmiWeOJhnQxJC+EwkwubRhDW
         lyS7jEQZaEwNPJk1v1Y9Ni9Ak1GVmHxe7D9vTxAT3LMg9k+SCLl+eIIzAHhWP5ysvlm6
         br/Q==
X-Gm-Message-State: AOJu0YzimxV0HnM1Alp/AmAh19DeQl8P79L65v3FkEIEUYbv6dfPGwYD
	jIc2ppaSMj8Zu8GIF8cf1eYXgO45s6LLzZThmJrpFf5zekexMeArdvVaAdhB
X-Google-Smtp-Source: AGHT+IHMY6mfPPN3m8X55KVqP1yP2ZgsNkky85q38uJUH5fuUck6aRZ9eRvuAOKabPntUcBT3fqzKg==
X-Received: by 2002:a9d:4b17:0:b0:6e0:d6e9:debe with SMTP id q23-20020a9d4b17000000b006e0d6e9debemr503643otf.32.1705698676116;
        Fri, 19 Jan 2024 13:11:16 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:15 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 14/14] provision: Detect duplicates
Date: Fri, 19 Jan 2024 15:09:50 -0600
Message-ID: <20240119211017.474598-14-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119211017.474598-1-denkenz@gmail.com>
References: <20240119211017.474598-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicate contexts can't really be handled without user intervention, in
which case it is better to fail provisioning entirely.  Most vendors
will choose to ship a custom provisioning database to ensure that
duplicate contexts do not happen for the supported operators.
---
 src/provision.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/provision.c b/src/provision.c
index e419d15c..cd5cf569 100644
--- a/src/provision.c
+++ b/src/provision.c
@@ -25,6 +25,7 @@ bool __ofono_provision_get_settings(const char *mcc,
 	struct ofono_gprs_provision_data *contexts;
 	int r;
 	size_t i;
+	uint32_t type;
 
 	if (mcc == NULL || strlen(mcc) == 0 || mnc == NULL || strlen(mnc) == 0)
 		return false;
@@ -47,6 +48,20 @@ bool __ofono_provision_get_settings(const char *mcc,
 					ap->message_center);
 	}
 
+	/* Make sure there are no duplicates */
+	for (i = 0, type = 0; i < n_contexts; i++) {
+		struct ofono_gprs_provision_data *ap = contexts + i;
+
+		if (type & ap->type) {
+			ofono_warn("Duplicate detected for %s%s, spn: %s",
+					mcc, mnc, spn);
+			l_free(contexts);
+			return false;
+		}
+
+		type |= ap->type;
+	}
+
 	*count = n_contexts;
 	*settings = contexts;
 
-- 
2.43.0

