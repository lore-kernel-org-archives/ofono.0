Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E43FB3B
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116593; cv=none; b=ixfSD6nvfpaoLUfe9dMlSO3pGII64D7vyWszf1XUbQYagqlcWG9OIm6N+RpS6MPDX/MYL8FgM7qgR2jAv5F5c6L3hPww6LVj9QZPxqZbQFgI21VAJY82BoEzfpz6YE0JZ+UMZRuXmmNXIyrtru+Myodgtt0wCmpYFVyFOk0IrH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116593; c=relaxed/simple;
	bh=mBiLrFdYNYBz0XbHChKsUD1e65jj5aBvVSyWXY4nl48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWQJkmmu5T+SoN5WdhygZnDFhVPFe1Iu/smC6ii/Uud1mFq32TXJ31jHWp6VQIFG8RRlEBvT8aGhOi6BQr9IDvHjj6nK8AgDOO0kaSIEvORoOBL5M0kNRaO/8SR0f5HdKC3siD/iVo9VE64yj7OY1cnZZEsevd0KAJnPDzqVZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAvd72Nk; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAvd72Nk"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a4f7a648dbso1121972eaf.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116591; x=1711721391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2vBrJVLFqka9GoaqiUx2639LIKDpdupWHga3nbQOHo=;
        b=CAvd72NkKcuoNWDhhRCnRJUQ2HJPobh+NGB3+TPwRKGNkqjBdgxUhv8PRIKZmPRnBB
         d+br6mPjQktiQY9EEa7w13DIlfIzGli3GeDTIouYvR+jZnCLJ1PSR+2AL8k5y++qQOvZ
         GqFMsQuSR0rtQktPSDbYjIEbadNoaBXPNMD/4AEFSPTv+zwJqZrlvYwwiTF1M7GprtDo
         7G3iyqTL4ADYjVZUdpIJ0D96Z2nRzeLm/LHNk0ubIUL8qdlgG9/knPkD9+x+hc13nskE
         4hhZgd/n7c/CU6o1q9GeIO4u+Wu14B0t6kOYeZUMVJRRaXW/dGITXwzMrIHOMGAA3zQX
         qoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116591; x=1711721391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2vBrJVLFqka9GoaqiUx2639LIKDpdupWHga3nbQOHo=;
        b=Rn3d3U2c3RCfBNSpV65qISPTHPPjya49FeLi5DMbgm5deij9zgsZV3UY9S+e8lSMca
         tR+Pd8OLPr17pgx1h3fNfhTd0O0n3ThRdQD+DgbRfce0lO5qmiPO7sQ5U56FAG0VQbOY
         SnOZayXHw5Oh9P/5EWs0Xz+AbX9W3YD8IVXWF1CmGlM3RGbAntGA7kcVgQo0Aq6b/LwP
         RJZ0kHFVXh5L4WlHD8nU8Ko7E4/fMs3MonO2pspaLQpihnzd6jIkI61acrYOSfhwf2ml
         cAfjJ6HKU1eRozmZXjP1mvi6LTomwpJ3XwnqxLz8M/WeYFMMR0WrS8AYCajOWVoohUCL
         cxBQ==
X-Gm-Message-State: AOJu0YxEjEUhbLKP/bk421CopoHfyyTsYTQHs0kV4hLOGjny3DBSt+dI
	ecu8ddCKpAn3yHSEZRucLQvlXGJqwCxdw1yw+Exk7Taf+8hx5WBKHzCZ7WST
X-Google-Smtp-Source: AGHT+IFf+jPR4BzE3KP5M0evY1G4nwQHFmSMiS1elzI5kzewLkrK/mbM7hFzjCYBJmC3EPeXj5Kqqw==
X-Received: by 2002:a05:6820:210d:b0:5a1:b49b:f5c5 with SMTP id cd13-20020a056820210d00b005a1b49bf5c5mr2404824oob.9.1711116590795;
        Fri, 22 Mar 2024 07:09:50 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/11] ublox: Set modem lte capable
Date: Fri, 22 Mar 2024 09:09:10 -0500
Message-ID: <20240322140942.2703042-9-denkenz@gmail.com>
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
 plugins/ublox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index c5661ab6b1ad..c2fab0e7184e 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -91,6 +91,7 @@ static int ublox_probe(struct ofono_modem *modem)
 		return -ENOMEM;
 
 	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
-- 
2.43.0

