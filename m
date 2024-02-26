Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106D14008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918658; cv=none; b=PIyQEuRuTVXrlGLrJiqleM4CmF/34sPK8KIyWX27VVjKlU1M3ok1chVndnGYK/beWMxK6BKVWFOClz1GX/sYx3awdpbu+U2RJhRan+fo3gLfG4Sn5BwJSB1cCdQNJ0mV6PraI2l5uT4Kaq5zyb4zhc2J2bSOfp5+i4hVNOe2SNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918658; c=relaxed/simple;
	bh=JqRBUuNQ3133t6qTNSfC1Jp9fq3zqCtyFrEb45nS+6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufWbtxDe8QX6f9XW/gaZ3jpXXuN3Iop0Ka5N19eLNUO89gK1i3usuT3J7ak+U26BLUOsGwciqvuDEmXzhIDO65qQack0qCHfY056FOIBokYFjq/RZ22TIos4YgVIA9k1l2j+DIK7wFi2AoxxzyFYyhQEjWNzHWqtH3X8dZuspJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAZdFZDF; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAZdFZDF"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a05923b689so609119eaf.0
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918656; x=1709523456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaxVF2qihSqzxGKZBvAzLfq40v5D1O6PnVhbmcqQkgw=;
        b=SAZdFZDFWNqpJ79yIBKmQ6KOg/UqI+f2Wp8uGTWWl4KEEGNd7gEyzIBqLxc33z2nUF
         IKuiW0T74BSysAXxOQf5KDIm2F7nXvCk0ZzmCPQ+foctt/xkHthUc0HJsG8UkT9WaXCO
         tlMR9HZ3GsyJYVJI8n/g+wfCPTnIuuhEe3pek06ICevc1Y9pwv9bdtmGBu43jsTZEInT
         drZqE0rIUnsM4VtQ3v8O6k9Wg4fZB7CBf14s7Z92g0CZLda04c/QVIZobIPXqp8Hu8U6
         YzrxlkxOW/I5gydmVXguAUhEGb/c/oL3+B2GdvFKkTaX1QQJTZMHuEf2UVQ6V8Za+clB
         866Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918656; x=1709523456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaxVF2qihSqzxGKZBvAzLfq40v5D1O6PnVhbmcqQkgw=;
        b=JnViRg/+8ULH3D337qrERy/zEcU5rFUehb6I5TYhEAr1PZ6zk5sbzRpqfhsNSLcJpA
         VGDPThWyCXvmDWqSvOIb97aWnjwX5ZlGPnE30xgWs9OQKL0YqpT0a1AJjSfkXP9BsoE4
         sFfAty78nCyQUsfPBKOS/mbiDQlrqM6kEVzQLXQItph8DeR9UIBPgWvJCerNp2gd5jc0
         EtjOb9+bLpEtpkSep3CNapV6yhlnEeGc8oNbGKhWifC4e3ZK1yjv8c4EbW1XxeZhWxDk
         gVMS5Ox8YQlQuf0RPidx9gLRPJVYrG87+v0qSf/8Usj/MifoBzR157vbrQ3ysDjIMKUw
         putQ==
X-Gm-Message-State: AOJu0YwBukEkodtlxAFjD3JXNzKazNKqie84T7c7yuF/6wZec240JQCc
	xDEq4ZdWLJOaZhWNbHSUY9OxOZRTRDt5I3Wugtqbkxu9Vc/EkXyhIB4hTleW
X-Google-Smtp-Source: AGHT+IHBZuiSJKN/ioCuUryouoRw9cIDvQQ85zagMxWHTmv1tGRCGoUBHra0KjKc9JYAsCX3jxR7Fw==
X-Received: by 2002:a4a:3542:0:b0:5a0:312f:e8b2 with SMTP id w2-20020a4a3542000000b005a0312fe8b2mr4984372oog.9.1708918655940;
        Sun, 25 Feb 2024 19:37:35 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:35 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 15/22] network: Remove use of g_strlcpy
Date: Sun, 25 Feb 2024 21:36:58 -0600
Message-ID: <20240226033724.1460079-15-denkenz@gmail.com>
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

Replace with l_strlcpy
---
 src/network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 347861046e1a..7516d9d00210 100644
--- a/src/network.c
+++ b/src/network.c
@@ -365,7 +365,7 @@ static char *get_operator_display_name(struct ofono_netreg *netreg)
 	 */
 
 	if (opd == NULL) {
-		g_strlcpy(name, "", len);
+		l_strlcpy(name, "", len);
 		return name;
 	}
 
@@ -386,7 +386,7 @@ static char *get_operator_display_name(struct ofono_netreg *netreg)
 	spn = ofono_sim_get_spn(netreg->sim);
 
 	if (spn == NULL || strlen(spn) == 0) {
-		g_strlcpy(name, plmn, len);
+		l_strlcpy(name, plmn, len);
 		return name;
 	}
 
-- 
2.43.0

