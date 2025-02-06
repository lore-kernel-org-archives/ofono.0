Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FA12E5D
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802284; cv=none; b=VzeREQJqhOb4vVxonZZyZuTnJ2rS3R8DPtoh8hkDH4d0BHL5L8Er+iJ269MBQow0oaiuANtuAAUD105QndW7OujAOyaRVzTMRWJvQviPE6aQAZPlS6Rp4m0HHWu7kiKyoP3/WJQtNi8zQIE/jhL8BmG3ZpVq6RU4EwGGICYlSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802284; c=relaxed/simple;
	bh=PflI5qBIaSJTT0QG7PTcHZOFe0bNQBtAKHMARNLtY7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roLmBbJowQysM3BAq0CrWFMPa/lZx5Rf5fv2StwGnVhRDohKDokNp1R+dZur3dM9/ZyAMw7cc6k9Dd/EUrkPkS/9uSKD6dXPQ5yekxMST8wQBWSk7tvDYE2vZTlovjTqZuL2yjoQfK0yK4dQHfrOQ2gbHckWCM1hGzyAXyulCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MzCyZZaC; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MzCyZZaC"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 51F0A164A94
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:01 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 08792124FD3
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 1/3] doc: Initial revision of 'ofono.conf.5.in'.
Date: Wed,  5 Feb 2025 16:37:57 -0800
Message-ID: <233b3b434b84a459e9197cd643a32a71b44a763f.1738802120.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=stcyPdIoR3aAZswof5OIeNa/MlZDFXY714cjYkEnoKQ=; b=MzCyZZaCNiWAuODNH49/HnqKonegtmxYaP9fhmu3EJ8f4Ey14YXj0qAaYaBOSBLU9ZASp1YR9N9XoihXj5SYIpPF/6sH2o9nv+7kQMjQEQl4K4Mn7v8YZ+ad5vkBVPnz7XaSm6aB41khl/9ffZIidLAZ6JmlteZUss/gowe4E8HG2YTFjR+Mcdsk8NlCY6wi5DICEft8ahyGHYZwfk3rODF+jBXiaznx3iKYGmym44v3sG6ikMSiPuJaU/IvYihJMIRIrmKEKcNCJaSBvqey0vBoqcTT0dyRIv/SGsA/5gah2ZgZl5D1mEmsivqH5AxqzMMvT0fa1Xq4lUShwKjxsg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Initial revision.
---
 doc/ofono.conf.5.in | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 doc/ofono.conf.5.in

diff --git a/doc/ofono.conf.5.in b/doc/ofono.conf.5.in
new file mode 100644
index 000000000000..7ce2941ed53e
--- /dev/null
+++ b/doc/ofono.conf.5.in
@@ -0,0 +1,37 @@
+.\" ofono.conf(5) manual page
+.\"
+.\" Copyright (C) 2025 The oFono Authors
+.\"
+.TH "ofono.conf" "5" "2025-02-05" ""
+.SH NAME
+main.conf \- oFono configuration file
+.SH SYNOPSIS
+.B @sysconfdir@/ofono/main.conf
+.SH DESCRIPTION
+.P
+.B main.conf
+is a configuration file for oFono. The configuration file is
+optional but it can be used to set up various aspects of oFono's
+behavior. The location of the file may be changed through use of
+the \fB\-\-config= \fRargument for \fBofonod\fP(8).
+.SH "FILE FORMAT"
+.P
+The configuration file consists of sections (groups) of key-value pairs.
+Lines beginning with a '#' and blank lines are considered comments.
+Sections are started by a header line containing the section enclosed
+in '[' and ']', and ended implicitly by the start of the next section
+or the end of the file. Each key-value pair must be contained in a section.
+.P
+Description of sections and available keys follows:
+.SS [Provision]
+This section is an optional section of the configuration file that
+influences the behavior of Cellular network provisioning.
+.TP
+.BI TagsFilter= tag\fR[,...]
+One or more tag strings to help filter and downselect the desired
+Cellular access point name(s) (APN(s)) when provisioning and/or
+attaching to the network when multiple such APNs exist for a given
+Cellular home network identity (HNI) (that is, mobile country code
+(MCC) + mobile network code (MNC) pair).
+.SH "SEE ALSO"
+.BR ofonod (8)
-- 
2.45.0

