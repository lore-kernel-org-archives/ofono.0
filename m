Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6325556
	for <ofono@lists.linux.dev>; Thu,  1 Feb 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820303; cv=none; b=RN+Rdb2CtafCEQHEdCh4XjI/zTCtbWJ3tU2FX8xejUYHG5XgYOabysexshSFWUEeEFYdDTwlASeEDJDCVy1UT+W6nUjzjlNZZyRtf/KYRrNEKHcODHV8QvbLgxiHVBj5atSugOMWOutgKyE4+ZeRuBQZ4D1FJkrR2uqCx9xfUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820303; c=relaxed/simple;
	bh=Qx9+Ss7cJaIUhsV5yWZjUe9L+B9G1j3WRIEAT2mJr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JX7SX/Vznw4MFpezqBg4eX7Xd2/WHZIzXkyMn+72Fz2UxrE1swvmHs/wuF8W2fXg4pEO5kxm9NwV112U6gxpdC83cp1+z4GRhvRGBAZimNk/YCQhJgROeLQfUw0AGriyAjJ7l630YVmxiMaOqSfUh9wTPpbrEQKv6GkSVYs2plM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7uOBt0v; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7uOBt0v"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e118da997cso721630a34.3
        for <ofono@lists.linux.dev>; Thu, 01 Feb 2024 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706820300; x=1707425100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zychsjfuReucCx+WlqNv7H+2ecVB9hvPTccaCbi2LYY=;
        b=l7uOBt0v/ZxTU7b3MWtXgCUxdl+J+iqfVDJBFxwRIfXFxtxr5x46WJxW2LfLrWthyr
         NgkJKruE5CAvME9AI90s3CIYk/bHoGoDm5v9RJtqJYMg0x+xGyrtK/Vj8Iw7DQagDjaR
         OcsawJp9SY40h1+fFNrXHhTmPqfamdI/ozO0hMNdCPmL8kcv7Bmhbx3gN2v+rUqdNBHU
         Yba0WYKqNQLJBuZd3DoU4pSBHXZ0wDQbNzzv8MzQHeYlfqq1+hTklI8g6DYwDiOvvJvf
         JqQPUQFQBiriW4Z5ktkFQt+J8MJfL9NjWc9o/rH9BfPmyyXodg4DXDcBNxj2zlcNlQlv
         /fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820300; x=1707425100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zychsjfuReucCx+WlqNv7H+2ecVB9hvPTccaCbi2LYY=;
        b=UeHtIraRA92AnNYlQE5QS5IotZHbaieVjhonEokbYjWlDyFpE/ffiXk2lyt5pVgLWn
         NI/apBvII+aab59Mzb8gSgrjmjQzuwU7ik93I3Xg3JS7tDJK3+EpmHH69Biq44K9gwo/
         W+68+wh1CgssL/BqtZEfNccPe4amVcRO9u4gH/uBg2e+wP41sAIQj78PnIcmvCFRxQXP
         3A5D+CyU528A0YWIykpDai+OGYfrsC1K34bUZL2InuNKbwaxESpiheNiMkNH74ayvbvt
         pvZvmxmNKF6ROf26smzCtG2Vuf0f/Zge8bySca6VcEybKS04PFZIcET3W39+WIjbU/l7
         8vtQ==
X-Gm-Message-State: AOJu0YwRym6Jbo9qjXjdulCwZTakyTJfgGZ/UxZxrjvLBcU4B+L33CDb
	bdouqJNH7t9XprODE8cgBCkzwN+Y82bff2fXu1u6UOU3Z3l+/fyToLI+4EPS
X-Google-Smtp-Source: AGHT+IHHOFBhnRyODF2Buo3UuKYDa7x3ndnav7qvt9tz2qpvcNTSE/6FThqw3BkHAiKRg0PoQUio6w==
X-Received: by 2002:a05:6870:b690:b0:214:7e6b:db26 with SMTP id cy16-20020a056870b69000b002147e6bdb26mr6182566oab.30.1706820300298;
        Thu, 01 Feb 2024 12:45:00 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id os11-20020a0568707d0b00b00218e3695b3asm115907oab.51.2024.02.01.12.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:45:00 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] doc: Remove rule 13 in favor of O3
Date: Thu,  1 Feb 2024 14:44:00 -0600
Message-ID: <20240201204412.951617-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201204412.951617-1-denkenz@gmail.com>
References: <20240201204412.951617-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since oFono is slowly migrating to ell, remove rule M13 and indicate
that rule O3 style is preferred to match the prevalent coding style in
ell.  Many of the newer code additions have already been silently
following these recommendations.  Make them explicit.
---
 doc/coding-style.txt | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 0ec1cd97e8ca..96837f7687eb 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -241,28 +241,6 @@ However if the enum comes from an external header file outside ofono
 we cannot make any assumption of how the enum is defined and this
 rule might not apply.
 
-M13: Check for pointer being NULL
-=================================
-
-When checking if a pointer or a return value is NULL, explicitly compare to
-NULL rather than use the shorter check with "!" operator.
-
-Example:
-1)
-array = g_try_new0(int, 20);
-if (!array)	// Wrong
-	return;
-
-2)
-if (!g_at_chat_get_slave(chat))	// Wrong
-	return -EINVAL;
-
-3)
-array = g_try_new0(int, 20);
-if (array == NULL)	// Correct
-	return;
-
-
 M14: Always use parenthesis with sizeof
 =======================================
 The expression argument to the sizeof operator should always be in
@@ -347,3 +325,19 @@ v = voicecall_create(vc, call);
 v->detect_time = time(NULL);
 DBG("Registering new call: %d", call->id);
 voicecall_dbus_register(v);
+
+O3: Prefer !foo when checking pointers for NULL or boolean values
+=================================================================
+
+When checking if a pointer or a return value is NULL, prefer the negation
+operator form.
+
+Example:
+1)
+array = g_try_new0(int, 2000000);
+if (!array)
+	return -ENOMEM;
+
+2)
+if (!g_at_chat_get_slave(chat))
+	return -EINVAL;
-- 
2.43.0

