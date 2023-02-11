Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEA3FC7
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:19:02 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id n13so6003081wmr.4
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhZoAKv9nvJIkXstREQiYcTxdxN/lipQxCaCrio2DWQ=;
        b=5iHaBZnr8fwG2s26NFv1YdBIRxR+mqEloldkLA14+P4Pdi5zn3xqaT4Stp5inY4h7g
         09Kqv+HR+abCm1fVUR26WCp9myU089Ik2GO+xuDMSMEdpoyHzRwFizPLeS8ukTTddPsU
         WiCox2t9HVWlg48Tn1ohRoSJiQCgGKlOtPS+55E0Th7EkWRuMsr8NrfSBJeNNDYxfTf8
         F92mTFtdVHjb9CW2/oWW21El4zbKgb/RK+2qCXZNBI8pDKL93KzIbwzfiSQa2PqFQgV0
         kV/X6vgNSeeGwgko8M/AhJHxnCoNOc0L+ekGcsm/lG6BKo8viDv02MDp/yNQKBqy8gCX
         craA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhZoAKv9nvJIkXstREQiYcTxdxN/lipQxCaCrio2DWQ=;
        b=TF3+B6EdO0LYSHmjB3fdlv6WnSBpohYvzJMF+QKRo1HfqZ3y1FLpuEEAYmAmjHL0Sf
         lKEQzGM0ucayrlQK8h7NrzAjUUpu5kIfVYsMpQUfZU3WVZ5yHIpziVSdtByRlETt8goD
         RQAvL9KHECZg8iIekHlMRXHK4uezeAA4VtV6mr4VNhnPRWNkFK4FR6UEQNKUZ0PvdPId
         gJKnuUdNpl92FQ7xkgKXof2wJxoPDtv9L5qBW71C5kLqGTIurr2mJ60VpbRvlDkCmWDW
         KU2cKcBTkLtyHk1IV2xLK246MjY8b8c01qlbAPRhCYxxG1IGEpF0xCF2m5RNzXRZWfss
         3zKg==
X-Gm-Message-State: AO0yUKX0rIKFkCbHK7c9bW6/SWz9B1yxJgED76khlKl/ef2T8KAIfg7L
	x2ws8RkVb7lDcJ2GzdnB9RDiJD8TMK/J6/VRqNDm0w==
X-Google-Smtp-Source: AK7set9WAR0iRcVVUhp+37cZ6u/FeCoAg0o+e/kGKjBQ+YA5wejob1VwUo0NpUKPXY/Db2uSOs4v8g==
X-Received: by 2002:a05:600c:210d:b0:3df:eedf:f378 with SMTP id u13-20020a05600c210d00b003dfeedff378mr15102276wml.24.1676139540746;
        Sat, 11 Feb 2023 10:19:00 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id g20-20020a7bc4d4000000b003a3442f1229sm12067150wmk.29.2023.02.11.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:19:00 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] docs: update ofono mailing list
Date: Sat, 11 Feb 2023 20:18:50 +0200
Message-Id: <20230211181850.8597-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've re-sent some patches to 'ofono@lists.linux.dev' and it worked.
Initially, my patches/emails got denied by the email server (when sending
to ofono@ofono.org).

Checking 'https://lore.kernel.org/ofono/' it seems that my patches went
through, so it looks like the docs could use with an update.

The websites are not changed, as http://ofono.org redirects to
   https://git.kernel.org/pub/scm/network/ofono/ofono.git
---
 HACKING             | 2 +-
 README              | 2 +-
 doc/ofono-paper.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/HACKING b/HACKING
index 15ea2912..8d67a19e 100644
--- a/HACKING
+++ b/HACKING
@@ -114,4 +114,4 @@ a feature that touches files under 'include/', 'src/' and 'drivers/'
 directories, split in three separated patches, taking care not to
 break compilation.
 
-4) Submit patches using git send-email to ofono@ofono.org
+4) Submit patches using git send-email to ofono@lists.linux.dev
diff --git a/README b/README
index 1c539995..e2a1c772 100644
--- a/README
+++ b/README
@@ -62,7 +62,7 @@ Information
 ===========
 
 Mailing list:
-	ofono@ofono.org
+	ofono@lists.linux.dev
 
 IRC:
 	irc://irc.oftc.net/#ofono
diff --git a/doc/ofono-paper.txt b/doc/ofono-paper.txt
index ec6d01b9..a5321618 100644
--- a/doc/ofono-paper.txt
+++ b/doc/ofono-paper.txt
@@ -167,6 +167,6 @@ add telephony capabilities to Linux desktop and mobile devices.
 6.0 Resources
 
 Website: http://ofono.org
-Mailing List: ofono@ofono.org
+Mailing List: ofono@lists.linux.dev
 IRC: #ofono on freenode
 
-- 
2.34.1

