Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2846551
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116590; cv=none; b=MV/6OvJZYbnrQ0bDe5abcdDMNrRsGMd0prOyhBAcoVyQs3VhYU0GCW7eDXT3yex9jEKxKDXEm3r+8k87IzSVLv+Oc9hQh+ouBw0xJwJxn9lKZcSsAvuOooMNePYl29MHUUl0mc7/RZ8hsuyBkjGXRiQd17WZgmZxX0aTGnNDoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116590; c=relaxed/simple;
	bh=biO0vb9/BuYWdOKBrZeZO+0e+XU5XceqX5G2CW9jOWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj79XDW6HwyUJPVqn7loHOTtibfvAC4nS0TXj/Nt6vU8SHcSicWEsJP6sXCFqwnhzsuglwOEESHpVner9GSvPjPVHX4BF0UuvGZXBqR9sH623sb4pr/ElyV21VSSlBvc8jLq1I3m3mXws0dC1MpcboxjFyYxTGTWIEBcxmGtoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BODkllga; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BODkllga"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a21859a4b8so727183eaf.0
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116587; x=1711721387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TfHiSW3eeJJvsnn2GJBhNZPGTm7drQ43Cvv3SrTLm0=;
        b=BODkllgaNrSWpp/Xr+0tCevuVWYiBDRPjHyJSe3Ruvmv/Ov/SP338WO1OYIMD3el49
         66mQZ8VTNycdygJnd1r5pdoAINW0P0cWvbqDdRMiTLxrgo0uCcEHLkmqJTBffZhQin7G
         Ehih6oTqWWIVdhmbMdZyougoWODu8CtDFD4+s4mSCZzkzsUvzqyHNc6vYJx5NNexC6xB
         QuIRLlCACc7j50J3BNvEfgZpdo6Oub407f50pP4w9ywmXwHvE3T/biSkUynoyXlIzZca
         A/qm/JuOpe005NC445+i+Xd7oL4k3YgIbAmlKd7V/VG6wLj1QJ1fvrr+g+tXh8rzbpjy
         GVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116587; x=1711721387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TfHiSW3eeJJvsnn2GJBhNZPGTm7drQ43Cvv3SrTLm0=;
        b=FCDAOaWWzWMP/GjPY6W0j3g/yasBBsN9CIWf/3MWmCJHYH1NGj9xdhL+ga3xE3oDgw
         k65OfOgr9CT8urWHtHIzS9EQZ3pBvsfZg4O8/L4EFvz1NpDxycwd49VFm0TgixIk4ZtU
         z1fK4q9OlmLB/Oq71yeBapu7DHEzS1yjMkKXicDVUtdv59uoT0ETFckvQlSngrMa/0yS
         kY8RQ9KANpjZ670Mj+onPe7sxY9MzJmJRsX0EmDDRm8HgeXVpvQPJdqPrwu76Zt1YLNm
         R6AWU8Qb/VJKupw6eeorH1fbSh2fVVEwERaJNlU6z+fMppo5G27I5aYw+aEqtuiu1gL/
         Zjtg==
X-Gm-Message-State: AOJu0YwgAYdiY6BHl08s5hePI6h5gN/jrF3MWgMllhDTgFk4WoePQDZr
	5TzJ3RWh4Bpdls18h2Ks3b5nr+SkIaVkJU+i3Hlu2sYeIIiNDaEBceNdXSbA
X-Google-Smtp-Source: AGHT+IGRAko03++HBgpdxWvgI8tr1nlAhfwF+gFIdFmOu45oh90jukrMzLSKdSRZxqgNHTH9F9I8Cw==
X-Received: by 2002:a05:6820:270c:b0:5a4:75f2:54d0 with SMTP id db12-20020a056820270c00b005a475f254d0mr2202952oob.9.1711116587518;
        Fri, 22 Mar 2024 07:09:47 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/11] doc: Add new Modem.Capabilities property
Date: Fri, 22 Mar 2024 09:09:05 -0500
Message-ID: <20240322140942.2703042-4-denkenz@gmail.com>
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

The intent of this property is to give an early hint to external
clients, such as ConnMan, about this modem's capabilities such that the
clients can modify their behavior accordingly.  For example, ConnMan
might choose to drive the modem slightly differently if it knows that a
modem is LTE capable.
---
 doc/modem-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index ff9facdce422..69108ab0057d 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -182,3 +182,9 @@ Properties	boolean Powered [readwrite]
 			supported by this modem.
 
 			Possible values are "test", "hfp", "sap" and "hardware".
+
+		array{string} Capabilities [readonly, optional]
+
+			Contains the capabilities of this modem.
+
+			Possible values are "lte".
-- 
2.43.0

