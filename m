Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09A14286
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805870; cv=none; b=Z/AgNqARV/fQDPd61Cw4mLvOXS1tI12Pv46ZbwgTPjOwZSlhQE5RIIkbwfl9Wcp/CvSvELo3iBRToXfpU81CdOl4i85YzFEfXdeqaFvQkEzuEL8O/wbUIaysiqGrh8qKtQ3LOydpDOZhzbQ+BR3Z8rJ6IAleLwZlC+XQ6BzgO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805870; c=relaxed/simple;
	bh=pYIXOfgiEz1OGsuVlpEPcidyColvh7vf6bs5oKzyCIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kiKKR5B/rkuofUNmbWlOTpRe53fjkO1m1Su23amEf2aE8m7bMfUPdqXPR6lsjpBg7jreiCpt5Vy+Kr26oNG3vkqBqTXIB25jCjCBmhAednsGav2/JzGhZvrEKSQFhTis1VABfD1is71k9YDBzzWIm1+IN5cc7PqMxJMmSrp4r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=iQJdJmTf; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="iQJdJmTf"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0D3F016499F
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:46 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AEC96125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:45 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 0/7] Add AT&T, T-Mobile, and Verizon MVNO IoT/M2M APNs
Date: Wed,  5 Feb 2025 17:37:37 -0800
Message-ID: <cover.1738805694.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=yoqiKpjAQ8KjwkDM9T+YZz8QiieWYEuVarsft8mcBZk=; b=iQJdJmTfmqQgrty6pMperZ8Aw7lDsptIjGO++yjVJaG3KasOvIl7gbKV3B6YnZXfMF1M6hpReMRIktsvuh8FPALl+zmya39FdoiEACqETYixTQPyOYT7JgcBbSFGNbx37NOpyIdZC7oQIWgdqTz1CQY0T2MTMozLYAxzlMUholjwrpy4E5QXGLKmXscsE0Sbkd9rR9kX6pK4Ef8HFw6zJVPUeseutsRZoFgs8Ktp1HBRHgQBYEE548HC8ia5k9XozpbcXR5WvsRBbBSqZjy+fadudnF1lsrlS68y2T/cWTjsLroIf0Opxj2zo8XE6Lyr9P1/NJalT7a+/+l5efe00Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

At least in North America / United States, there exist Cellular MVNOs
(particularly in the IoT / M2M veritical) that neither use mobile
virtual network operator (MVNO) service provider names (SPNs) nor use
unique home network identifiers (HNIs) (that is, mobile country code
(MCC) + mobile network code (MNC) pairs). Instead, they simply use the
HNI of the parent operator.

In addition, those MVNOs typically have two or three APN schemes:

    1. A "public" APN that is broadly used by one or more MVNOs for
       the parent operator that issues PUBLIC IP addresses and does
       NOT route through the MVNOs or parent operator data center
       infrastructure.

    2. A "private" APN that may or may NOT be broadly used by one
       or more MVNOs for the parent operator that issues PRIVATE IP
       addresses and does route through the MVNOs or parent operator
       data center infrastructure.

    3. A "private" APN that is used only by the MVNO that issues
       static or dynamic PRIVATE IP addresses, does route through the
       MVNO data center infrastructure and, from there, via a VPN to
       the customer services infrastructure.

       These are sufficiently MVNO-specific where they do not or
       should not play a role in a generic provisioning database.

KORE Wireless is one such IoT / M2M MVNO that uses AT&T, T-Mobile, and
Verizon as parent operators.

This adds a MNVO-generic IoT / M2M APN of type (1) and (2) above that
are used by KORE Wireless as well as by other MVNOs for the AT&T,
T-Mobile, and Verizon parent operators.

Grant Erickson (7):
  data: Add AT&T MVNO IoT/M2M 'Public' APN.
  data: Add AT&T MVNO IoT/M2M 'Private' APN.
  data: Add T-Mobile MVNO IoT/M2M 'Public' APN.
  data: Add T-Mobile MVNO IoT/M2M 'Private' APN.
  data: Add Verizon MVNO IoT/M2M 'Private' APN.
  data: Add Verizon MVNO IoT/M2M 'Public' APN tag for KORE Wireless.
  data: Add Verizon MVNO IoT/M2M vzwims APN tags for KORE Wireless.

 data/provision.json | 52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

-- 
2.45.0

