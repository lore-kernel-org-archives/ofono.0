Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13302352925
	for <ofono@lists.linux.dev>; Thu, 18 Dec 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080860; cv=none; b=CJtWy/qhvqh2CvhxvKfeGj/4Ug7/usL2r3ezm1SAysrwTwcakz/NWQEUDt9yWjp5BZ7zgIMA4hGERL54xg3SuyCX09/AgIWB/JodMuofvHFOiDOIaNuLRon0GNi4b9zCNKh8Qdlluj74S5BK3zQx/h/Q56c8F8kBGtdiEOz9ZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080860; c=relaxed/simple;
	bh=7pAmBi/yJK8SGzUV+c8jQ2Y2apxuGU+fetMlIWp7wgA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rqebocm3u84ZIQ4mqhqwaa01cz0hv5dX+xTm8WSFvhtrLwMlAWHlozSQU1kAGM3hkRjiUDF9kNBo3GgLCKYWYWGgy/m3+rEnn2nKBwZAxsVnoNbvamwvNH5jp5z1BYYQ8GhEUNR490vBNBS5N4EmOUCv6JiYFoknnA1DIg2ba/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7429FEC
	for <ofono@lists.linux.dev>; Thu, 18 Dec 2025 10:00:50 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A47283F762
	for <ofono@lists.linux.dev>; Thu, 18 Dec 2025 10:00:57 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: ofono@lists.linux.dev
Subject: [PATCH] build: add missing mkdir when creating unit/test-provision.db
Date: Thu, 18 Dec 2025 18:00:56 +0000
Message-ID: <20251218180056.235274-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index cf51cdf1..3bd414d6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -947,6 +947,7 @@ unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd) -ldl
 unit_objects += $(unit_test_qmimodem_qmi_OBJECTS)
 
 unit/test-provision.db: unit/test-provision.json
+	$(AM_V_at)$(MKDIR_P) unit
 	$(AM_V_GEN)$(srcdir)/tools/provisiontool generate \
 		--infile $< --outfile $@
 
-- 
2.43.0

