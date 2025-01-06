Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7C70830
	for <ofono@lists.linux.dev>; Mon,  6 Jan 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200521; cv=none; b=uinSPmdF69rc0A3dtSTD9IEuqXuWKnZmYo0qxhrVB158QgTC6BHS5dYexcYI28Z8Eiul2XxYNhd3bndW1/wvn+GByCga0dXXF5WBUttMw30F/+M48K7p4zOtoOQcGD1pOQ+FaYmkcsjdwyvDPZ///64uUFM71ommyHtCSoY/Y9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200521; c=relaxed/simple;
	bh=paIU2on/GqN5uufRBtt1hLnphRwJDYQi6yN9I5HB/y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhLPArAa9skpz9IX1Xsp1t438KgqUT0U0ngL0cySwGDNZuzwncHRveujJk/pCGQYVEgySmUNX8MwOgr0Qy6WUPMQBWQImU7pddBRkkinLxBABafWlFyOdJTonHDeObd/gQqtUa0mUcit+g6vJpV2b570TKEVt8LzL2M17hNDvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMa0tUxW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMa0tUxW"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaef00ab172so1642989766b.3
        for <ofono@lists.linux.dev>; Mon, 06 Jan 2025 13:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736200518; x=1736805318; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZENXLLXzRo3tZj2QdIM1bNue7xY+NxcC1en+On19iTQ=;
        b=TMa0tUxWn69N09z/duVaivPvDjnBhm3QKRKUfGzzImktkzA2+tYUKeUDMWCZ/9ECBd
         WyANnwT36JRh0PyXd3oosXBHf+gypwhE54ztF65x11QySh2odJ0dP86/Z1PWbFIF3BbW
         G8eldSUALmeqJoR6My4UQ8JxxbEOhFI3NbhJxTqJXpRf4oceOYYHkkR9xs81pgSctOmP
         7Jx/vHwJPp2WtjEZt9nrSjG8D5Zg5QKv+WT9A8dL4bKJbbaeQgY59ZhXShDNy2L2M2af
         cb9vyruRU6+rtWdHMasgwIN6IJJPVRZCKeRCaAPAFOpEjkZO6P/y84GTidIF51j8gi4P
         djkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200518; x=1736805318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZENXLLXzRo3tZj2QdIM1bNue7xY+NxcC1en+On19iTQ=;
        b=RpvaNJcxzUQpnf8noCwqlo9P1Vz8ZEu5kUpx9I+pO84xDZhvZeSjl347x61nVkbbvo
         i2v3axYGeXPq8+VfkcI9aWa8bCwOq0Pvo4uV+qJZLv9yf5mRNbXwjyudDdr6a5ch6GqJ
         KQqM/A+fn6L73t4grpdFeI0xjFCpUh/h09Zy1kgvxiwmQQLhYkYLE1OlCnZtjgvwgv6e
         7sd7HBmqqqdE7qPUs/uXJvbOgbfv3yT0b7y5fU0DIcSV8bSnbAbGhVx8tELTzRBtSpF2
         z/QjtvX1LZqtECvl46Lv0XkY/azbdWrwVh1hAYNH69I2nfIb1/XWlYycmkJvE2MFrfWw
         0UYw==
X-Gm-Message-State: AOJu0YwfFJRSUG4bsrtEOg6AJONmrx78CVznyMQML4ulb8OUSV9+UH8l
	a115SEfdu4iKXe8VVv1TRc9H5tEBcVwRsThDrohjnLQdlHenD9pzUxtK504AZoM=
X-Gm-Gg: ASbGnctXLdX19XjwvoPTc99qUk1v4TPp57OyY03zxQ7RlDuFgoi4/33rKdW0UVyEf6F
	7KbEhh7cY8j0TPRPlOOeBaSYCbpA+NqPeSicqwm2zd4QUoKYD/s40AmNaqezsAVy/EhqQz6taxD
	uySnwc8HIkPD3SYCyr7PA9AdNTmq+KQJVeAVdFD+qKqSn9gxTRos1h0bLUXvZKUwx16w5uUrxtL
	pfGdaDtcK1ghgG3Rj8JZ4xl/OvdMLq1O72zufackiCwxJ7r
X-Google-Smtp-Source: AGHT+IFABCbGMIOQX62muW28kn+SLbcm+Cc/UCQ4wxd8W2O9BMR/SLLD8B27oAvP/Ixta1Y5gkxU4w==
X-Received: by 2002:a05:6402:2790:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d81de1c241mr150371959a12.28.1736200517934;
        Mon, 06 Jan 2025 13:55:17 -0800 (PST)
Received: from tpt440p.. ([41.84.247.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4206sm2295384466b.117.2025.01.06.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 13:55:16 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] handsfree-audio: use correct signature for GetCards
Date: Mon,  6 Jan 2025 23:53:09 +0200
Message-ID: <20250106215446.14890-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the signature for GetCards to the structure of the dbus container
as found in the am_get_cards function, as well as in the documentation
for the handsfree api.
---
 src/handsfree-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 27d8331a..89b36584 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -813,7 +813,7 @@ static DBusMessage *am_agent_unregister(DBusConnection *conn,
 
 static const GDBusMethodTable am_methods[] = {
 	{ GDBUS_METHOD("GetCards",
-			NULL, GDBUS_ARGS({"cards", "a{oa{sv}}"}),
+			NULL, GDBUS_ARGS({"cards", "a(oa{sv})"}),
 			am_get_cards) } ,
 	{ GDBUS_METHOD("Register",
 			GDBUS_ARGS({"path", "o"}, {"codecs", "ay"}), NULL,
-- 
2.47.1

