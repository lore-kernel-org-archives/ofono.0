Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A15EE9A
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838577; cv=none; b=scUKiBb026EumNwfjiwSBVqUmkS+trLINKVnmVy2xW57GSl2NeWDaFavyq3+zNnTBoOh+REzgvPX1kiXixK41/ntYbQxWDq0B5VguFp+pFlg3xv9u/uDb1bZVSZgXtyzVe8NmwIMH1EWOvE+KkiOTCXtj+qnTGPiSyBDwY3z+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838577; c=relaxed/simple;
	bh=eJ6nrOIwhi1CPG+9SRHOFoXsGzzUSb0vwkuCql1nRvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxxCV/2p+EsBnJTx4GaxRe/NtkSZn4xb7U21KAktuE9ZYRd97focXcetqD0WhU0nJynOePnc4ujd4+8IcA964c0yPYWAUbwdp8Y3ulHtCSkElidpcvN/shYX+zbYROHIP91pf7LdOJm/RFrTpmIrjIlLivYcmQlvuKuDWf4b/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSLzRjxA; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSLzRjxA"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21922481a2fso3205326fac.0
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707838575; x=1708443375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTxsjo8hIK25nH0xgPFBXvm3G6xa0W1atRTbQwHO/fo=;
        b=MSLzRjxA5WxcL+xzejbhkSkm4ICE7Q+9R0z1TABRLqB49z3lZVjWN1BSCOvd2nQwco
         C075ookR+xO+8nVnGynvJX8gCRKNZKf8MVJAun4zOO72HcduHfeulC8VqwUy2a14x4Ou
         qhKPo/LKwY+o4LlDj5Dy76j68DBdZ+MTdk3FiFuNW+hVJ5bFWnTBCRhDFpvUVKQB2ci2
         7I0pYbBma8cm/5QyhQQ3Kq5LX5CZIunTesmBgh/YfS+Yavw/K0IoKAIvh+cr9cjffaIu
         KUXRhM0zHUy2B39Syf2NiagkWFpOmMEBh6c3GCp5CEIk1qv174W9KBdXQ41Izh17NK1Y
         7lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838575; x=1708443375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTxsjo8hIK25nH0xgPFBXvm3G6xa0W1atRTbQwHO/fo=;
        b=NtyAb8Qa1ccFngc7P/KHdQjTOr3BijQxl8E4Z3FXdyCJ7WWrtxCYtIfN1oC/0PvjKo
         TzfVYJCTb5gZtPz9ycsLz2UxK7z3x/1SNhDPRfoVtwVP72kkAEk8SMjVfGd5/m+BWYzs
         N7bT+civ7do6pS/O1V60cV/id8AElo6mZe3EA8FoP+wNZPwSJNXiGNZ+OSVSJKCbFbFs
         0Ddwglj9zlMO6ckQDEcbF4tC8ZgBwlr5MQ3ZSIRY8e6IhOC5BoxfXSddJZRZcYEvddTS
         Nhy74WlsZPSyBzfv0TSykG1ZHEPnzr/sD2rkZ2K97pCkYbx/NqX3O0BsyPsGryJuRnxy
         6F6w==
X-Gm-Message-State: AOJu0YxH6NPfM4IhMpLzPC8pjDHtywpxRt5izNvf3L3seVsbdILBjX6G
	Z6gxU854Eiin1Dwh1qkGa5zr9cc1qjgFaw7lRHt3DfsmXQUpHlw0Ny7oNtBy
X-Google-Smtp-Source: AGHT+IF7LnCf+FiuUfoyfPlvr6Z6aB+WzkgPQcaBpPvhV8SOCQImviWdYbPeKDhXikJCwYUZAmg/mw==
X-Received: by 2002:a05:6870:d88d:b0:21a:fb2:9e1b with SMTP id oe13-20020a056870d88d00b0021a0fb29e1bmr9822585oac.16.1707838575330;
        Tue, 13 Feb 2024 07:36:15 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx19-20020a056870769300b0021a0f032341sm1861999oab.22.2024.02.13.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:36:15 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] voicecall: Convert use of g_ascii* to ell
Date: Tue, 13 Feb 2024 09:35:10 -0600
Message-ID: <20240213153524.1085649-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213153524.1085649-1-denkenz@gmail.com>
References: <20240213153524.1085649-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/voicecall.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index fcfbfcb24513..6d677a9a7487 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -340,7 +340,7 @@ static int tone_queue(struct ofono_voicecall *vc, const char *tone_str,
 	 * and p for Pause.
 	 */
 	for (i = 0; tone_str[i]; i++)
-		if (!g_ascii_isdigit(tone_str[i]) && tone_str[i] != 'p' &&
+		if (!l_ascii_isdigit(tone_str[i]) && tone_str[i] != 'p' &&
 				tone_str[i] != 'P' && tone_str[i] != '*' &&
 				tone_str[i] != '#' && (tone_str[i] < 'A' ||
 				tone_str[i] > 'D'))
@@ -2196,11 +2196,9 @@ static DBusMessage *manager_tone(DBusConnection *conn,
 	if (len == 0)
 		return __ofono_error_invalid_format(msg);
 
-	tones = g_ascii_strup(in_tones, len);
-
+	tones = l_ascii_strup(in_tones, len);
 	err = tone_queue(vc, tones, tone_callback, vc, NULL);
-
-	g_free(tones);
+	l_free(tones);
 
 	if (err < 0)
 		return __ofono_error_invalid_format(msg);
@@ -3440,7 +3438,7 @@ static void emulator_vts_cb(struct ofono_emulator *em,
 		if (str == NULL)
 			break;
 
-		if (!g_ascii_isdigit(str[0]) && str[0] != '*' &&
+		if (!l_ascii_isdigit(str[0]) && str[0] != '*' &&
 				str[0] != '#' && (str[0] < 'A' || str[0] > 'D'))
 			break;
 
-- 
2.43.0

