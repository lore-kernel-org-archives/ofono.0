Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D132FC01
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918649; cv=none; b=BwIAiC2AX6wCWn7l40zKwOSFaSrVJ3pnWsw1A16aGIkvUeCAhm8KcBhp5b/2vx98EJMRgZaTAb1CKe0t9RoUIRRTOt/JcVUBM8O2fRP2roLxscmM4o9IwwE12CT7vWsS2/kpWzrSNvGlUvt1ZTu4TpE2PX4j86S2Ic7n08eONdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918649; c=relaxed/simple;
	bh=AVuma3fFWaOLDJ4xTdHvaTeX4kveS6whblaBfq+5HRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp+393BPfe54VlbQXAj5IR1RWWzVnvAztUthbaozrfaedit/wgUZYo0fHr/QNorzRqA6Ywl1OqILp7GHpOmp663YUUDlRRi2s4ystllXZ5byT1ZeSndWIyB8J7MqUs6OO32wnJtDrUicNaVcXIfFVnaVlG8e7ymyZzBFMc2u04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLb+9vy+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLb+9vy+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2030164b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918647; x=1709523447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+fiC/+wpjR+AW48KaeKiIJINjclJgupQgWZPNZrqzA=;
        b=HLb+9vy+GfvUT+CmvYY+mGNPJ5b4DcH9wEFgM0wR3I7qtynxy3OgdZr9udPdQF49Ao
         UCm6mS0TWy7ZJA7ERBSJK8hv3wo4CA51IsTAD+P1aAFl3ImVfHY0JEFQNdyyKAV8Z0aA
         NiyLNyc5ke0U0IQDJNjLZA7wHnya7osy8GvJbuNHHUC+MIH/rRnd51j2cTQTJSupXNKb
         TJt60x3i8VPvMR5IzbiG5pTq/udETahR0l8AyiTGwfQ3vTliMZebb8Y1iNfInsyKaNjz
         HRCBm5h4xXhku6gg6I3kQ2PHMkOgV+3XvvKwVB/PVat93/V8QY6oT0ArBVu7xEyKBUTN
         z+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918647; x=1709523447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+fiC/+wpjR+AW48KaeKiIJINjclJgupQgWZPNZrqzA=;
        b=msgSqE2GuTbtL8rSbhYA7MunEqYFHAaDNvLLhe/4EBHlo2/SMqFAUt63EvYyNcxQHB
         UzloKFU/9alg24qmJjVYhhgf6XvY5kQ25LSt0A64ZWwoaDZxkvRV0oEdJiBoqLvejFnL
         uqH5o+EB1d5SNQKzIQUYL0fuVh7tIhAxPtjGrSSLo4edxGnxXfQzD0EAIfGKJal6ud45
         MgOBXKZSn+LuujUdT4zvSzS7aYzB11/LQ+T7qTILRgffR6yKh1+WBLPCWtjMRdqSOQd6
         qrMsQAem0SWls/0o2Wg8d/AtsgUdy/8Gg/GNROAstvAnBAPM4ll4SLSuMqfpzIOU8f9q
         aESw==
X-Gm-Message-State: AOJu0YzyeEYw3pYOpmBCQfBtVUPr5f/1Km3hb9nIBIQOGKPefw69hr5+
	hD7BpDrMdWve1dj42EsUlgiXLmkqdw7pAdhhCcpb6AM+EduEPVL4UH+AKdHu
X-Google-Smtp-Source: AGHT+IFdjfZNq4wzDd7n7HsQ9LlPKKhz741LNVEcrtrQ/zwGEPc4rOHTB7QSqtmrjQWomn375ZAFxQ==
X-Received: by 2002:a05:6808:1403:b0:3c1:4e89:f119 with SMTP id w3-20020a056808140300b003c14e89f119mr7653576oiv.0.1708918647461;
        Sun, 25 Feb 2024 19:37:27 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:27 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/22] network: Remove g_strfreev use
Date: Sun, 25 Feb 2024 21:36:45 -0600
Message-ID: <20240226033724.1460079-2-denkenz@gmail.com>
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

Replace by l_strfreev
---
 src/network.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/network.c b/src/network.c
index 17cff7837a69..347861046e1a 100644
--- a/src/network.c
+++ b/src/network.c
@@ -127,14 +127,14 @@ static char **network_operator_technologies(struct network_operator_data *opd)
 			ntechs += 1;
 	}
 
-	techs = g_new0(char *, ntechs + 1);
+	techs = l_new(char *, ntechs + 1);
 	ntechs = 0;
 
 	for (i = 0; i < sizeof(opd->techs) * 8; i++) {
 		if (!(opd->techs & (1 << i)))
 			continue;
 
-		techs[ntechs++] = g_strdup(registration_tech_to_string(i));
+		techs[ntechs++] = l_strdup(registration_tech_to_string(i));
 	}
 
 	return techs;
@@ -345,7 +345,7 @@ static void set_network_operator_techs(struct network_operator_data *opd,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Technologies", DBUS_TYPE_STRING,
 					&technologies);
-	g_strfreev(technologies);
+	l_strfreev(technologies);
 }
 
 static char *get_operator_display_name(struct ofono_netreg *netreg)
@@ -553,7 +553,7 @@ static void append_operator_properties(struct network_operator_data *opd,
 						DBUS_TYPE_STRING,
 						&technologies);
 
-		g_strfreev(technologies);
+		l_strfreev(technologies);
 	}
 
 	if (opd->eons_info && opd->eons_info->info) {
-- 
2.43.0

