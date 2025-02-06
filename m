Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4B15E90
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802284; cv=none; b=V86OZiJejHrv7gPcVi9hClAFmtlCa0B9ktZomIZI4HgJm33ck/XRRnX3Av0+nEKYOiiQnsj67NllWbvpjP7mOAqtpgNGj+s2qidnA4DfK3IQAohwbchCOZblPw5RImxf6XE3hls6MsA+RL4sIzWsR1N9XGh35KTiLigvbxB9/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802284; c=relaxed/simple;
	bh=95RP/dK9W2pF/stP+zBqznwCfGh21SdUUlXS+GC+4pI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg78JhZFKSBEIn25SNNS4fAHsorpspkY3OBCvMXYj6a4pvuQrBxlROS0LMX2uo7LREW8nr1EVyAmX9PskO7rw5T5OU89iK/zsC3glXcEoviRAv8Wwh8+SThHrn0AfaPGwx85+XmnSGrsE4YcL1bi7Aq9OOsggQjdZ+89TQ3E0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=LmxQm7Tk; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="LmxQm7Tk"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 42695164A98
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:02 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EC7C9124FD3
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 3/3] build: Add variables and rules for generating ofono.conf(5).
Date: Wed,  5 Feb 2025 16:37:59 -0800
Message-ID: <0e05d9aa4338ea30b579917d8294fece34edf469.1738802120.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1738802120.git.gerickson@nuovations.com>
References: <cover.1738802120.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=hIhZg0le6dRMN6n4Hz7PRSurI4E6aqJl35zCyCfvZhk=; b=LmxQm7TknYl598Ez7bCrs7c7K/YlpvCoDlylScP/LgJFvo8Tg7RH61l2vYI2maNv/7TgBpZMZU8JxmavB8JnFOE9YqQBRDXgtH42z1TTnw+AVsRxtxunp72eymyjtVnqvD0Rd8jn4sSW8w9FcomIKj0ZC5UI6cwDPiUBsS3W5mepWKyF2jJnv9keFSv3AqAu+H1eL9FmY5IE0S51xZl83qHeh7yofmrZysWjcdKXNo2vDn8p4mEt3W7jslh7bAap6P8PZt9WzNXlP8EplXlgx3nCQSA9/8/5ltUZzPgBIpN4AEk2gEr+j1oeH1vlboI3nkQlbE/eXeR6xDLu+sEPlQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This adds variables and rules for auto-generating ofono.conf.5 from
ofono.conf.5.in.
---
 Makefile.am | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2d198f52a4a0..8ca4eaf16dd5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -832,10 +832,12 @@ endif
 EXTRA_DIST = src/genbuiltin plugins/ofono.rules plugins/ofono-speedup.rules \
 		tools/provisiontool \
 		data/provision.json unit/test-provision.json \
+		doc/ofono.conf.5.in \
 		$(doc_files) $(test_scripts)
 
-dist_man_MANS = doc/ofonod.8
+MANUAL_PAGES = doc/ofono.conf.5 doc/ofonod.8
 
+dist_man_MANS = $(MANUAL_PAGES)
 
 unit_objects =
 
@@ -1038,6 +1040,13 @@ src/builtin.h: src/genbuiltin config.status
 plugins/%.rules:
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 
+do_subst = $(AM_V_GEN)$(SED) \
+		-e 's,[@]sysconfdir[@],$(sysconfdir),g'
+
+%.5 : %.5.in
+	$(AM_V_at)$(MKDIR_P) $(dir $@)
+	$(do_subst) < $< > $@
+
 include/ofono/version.h: include/version.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
 	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
-- 
2.45.0

