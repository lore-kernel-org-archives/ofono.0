Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10985627
	for <ofono@lists.linux.dev>; Thu,  1 Feb 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819081; cv=none; b=cd+lsSNqsHetvmrwQXpn6Q8n+MFiGIPBOTvorjLCGo2A4v3gKj7TwBMZy/6iaqhbkvHULGKiQ/IomTa8oR1+A4R2+3nCWiTVXazjSeV54tfoydDNY12LuWqzNNDM7VpQQQ4Z/qQirN6f4M/dB7YpFBrxzcwMTDedH7p+Tr0P59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819081; c=relaxed/simple;
	bh=gcZoiSBVEN3CIu3uttfxRfR/2VDR2nngHzardZYsGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9Zb2Kye+am4d3WP7WYpYDZxJAEk/sIwLxZaPJOSKGGOzvWMstqsNrHw+l5osSk4RZmDY7E8M75HZC7kmm0FbmcUN90JuCJjbl3cTvcDfNo6dnzfsiopgqm7gag4aRUIZrTA1ml491GzVUZXhskJc70gz7i/qYsDGVv9r6qV5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=culfFDzw; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="culfFDzw"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3be5973913bso741825b6e.3
        for <ofono@lists.linux.dev>; Thu, 01 Feb 2024 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706819078; x=1707423878; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+1C0yg6uFh8sCAjDdY85xicfXH9d0bBDqNDQpCaOZ4M=;
        b=culfFDzwtmJPN4cYfukQN17j+FnDX8secxyspqsNqezhkrz+WdoERKCyiF1cVOGcAI
         TKUc0I1s6wTkvkgpzqi8BwF6BrJQCRGr7B+FLSZ+f1LvoLxCS1zWiVYKnVOXczyjGiVp
         gMO/wRDKokqcGlCscTx5h7vDFRk4HPbEi2qxIFL7mgZZ4jMymgK8FufiWAp7L0zptrJb
         C+Wc9m7pGpkXuTb2z2XkVNaHBhtaBzphO2+DOizexiLPe1PvULyS3N0ZlI4sRs1CWknf
         DnTJp32YJ1+6KZncJHO+eXybLRMY9u6O5O/9xP5XHYB/pymS+skx3fgEcEQ3iADK9gkH
         X56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819078; x=1707423878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1C0yg6uFh8sCAjDdY85xicfXH9d0bBDqNDQpCaOZ4M=;
        b=mgQphtnlSHQFrZdDzpzsPgEhSYAe4fBYtpXcPf6BDBRr37Jy7k441jXze88vKR8nLu
         OP6kSXygFeUPDuFss5ivvDEGfYDq+z/AMyR6Pna5LsI8JcK1xcydIL/OlTQjy9FOdnoz
         OMutKSZFh3rA5wmQUPVX7fUAr8zirHPf+eGveLUIHJRryD5hfMyCApZw6dqS/XkzSgcR
         0+B/57/2+WoF0FZ4Syd51/Up3L43m4/JNf86A3n6uxI3Wl+fFcXI8+q9SetYeanUE7uN
         I+gOFRgHqbhttMpGTixbkc7KqZQrrIPNowmYMiBeVQA4hkv7et+NLkU/gYnHMNhShu+P
         vSJQ==
X-Gm-Message-State: AOJu0YxoHu+sAkZZ3kBqpxxg75lhHCfCOQfbYfZTeAE4/tSpBR1WqQat
	hQwOvRxZjIC5RcFVs4NNHNo3NNkcjGGn3C0pVPxDSAnhd4aWS/qUrIw0Q8B5
X-Google-Smtp-Source: AGHT+IGGqqBuF+/K7oBMGMZ5oTsow8GHicPmLbzvXM6vF2WAIJYxLC8WLXuuBBl9BzCMH9ZEm/PoFw==
X-Received: by 2002:a05:6808:189c:b0:3bf:bb44:a002 with SMTP id bi28-20020a056808189c00b003bfbb44a002mr284588oib.7.1706819078260;
        Thu, 01 Feb 2024 12:24:38 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu13-20020a0568082a6d00b003bf9e5edf7csm67756oib.47.2024.02.01.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:24:37 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] build: Generate and install provision.db
Date: Thu,  1 Feb 2024 14:23:33 -0600
Message-ID: <20240201202350.951327-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run provisiontool to generate the provisioning database in binary format
from the intermediate json format.  The database will be installed in
pkgdata_DATA directory (typically /usr/share/ofono) when make install is
performed.
---
 .gitignore  | 1 +
 Makefile.am | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0cfe5283ec35..27184e16e42b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,6 +24,7 @@ stamp-h1
 build-aux
 autom4te.cache
 ell
+provision.db
 
 ofono.pc
 include/ofono
diff --git a/Makefile.am b/Makefile.am
index 5221b1cca138..8517bc0309d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -207,6 +207,11 @@ statedir = $(localstatedir)/lib/ofono
 state_DATA =
 endif
 
+provision.db: provision.json
+	$(AM_V_GEN)$(srcdir)/tools/provisiontool generate \
+		--infile $< --outfile $@
+pkgdata_DATA = provision.db
+
 builtin_modules =
 builtin_sources =
 builtin_libadd =
@@ -748,7 +753,7 @@ src_ofonod_LDFLAGS = -Wl,--export-dynamic \
 
 BUILT_SOURCES = $(local_headers) $(ell_built_sources) src/builtin.h
 
-CLEANFILES = $(BUILT_SOURCES) $(rules_DATA)
+CLEANFILES = $(BUILT_SOURCES) $(rules_DATA) provision.db
 
 plugindir = $(pkglibdir)/plugins
 
@@ -901,7 +906,7 @@ test_SCRIPTS = $(test_scripts)
 endif
 
 EXTRA_DIST = src/genbuiltin plugins/ofono.rules plugins/ofono-speedup.rules \
-		tools/provisiontool \
+		tools/provisiontool provision.json \
 		unit/test-provision.json \
 		$(doc_files) $(test_scripts)
 
-- 
2.43.0

