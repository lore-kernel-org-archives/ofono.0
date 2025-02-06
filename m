Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9B11185
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802284; cv=none; b=Es09w0KIlywXG8tyEftfmwWn61/mTZTZJI1xfqf6RUuhCyQvMJpKV33xkktRsLJ/qn7bMV8qNAN7/z3C3ev8TUufvn4y9aMgXqd0h5c4iUzb3zo67x2Zruz8Kbc02z7c6yzOcbgmQL5DysmMtw2N3eO+OMGH+FkGpF89sI8aRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802284; c=relaxed/simple;
	bh=Rqfjq/eVdUNJjCQl7wKPlki73sGkuFzKqzsP9ZCCTg8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iFkehWByoE00NLeaHtGlom0qj7qyJd+f1MjWWKTOyRtbPkGHNsuIYtg5V9kyP1TiD16R0KyWHY1ZbgD5TAsRiEO8QwkrREZaEcAiikxJFOUTM/4RwmMBvrEZuagyzl/VxClQg/bV9R1iPYnna6uwdmuC9JaBZRhCU7hyeymmP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=m5FYl0F8; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="m5FYl0F8"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D8E0F164A93
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 87691124FD3
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 0/3] Document and Generate ofono.conf(5)
Date: Wed,  5 Feb 2025 16:37:56 -0800
Message-ID: <cover.1738802120.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=n3m6483H0QCOGEsRPIZv/gP0x70aeW91kdd/GBAKN18=; b=m5FYl0F8X8xVBO2m67PDYtqD3SKFuB8WnDe2tgijUZVOH7/NHi1RIflG4/EUsw5FpKHRB6fy4gdEmxcKm5mnaKpnyybOdg6bLggWwpevhTzC5PGgA8/e0Z9LOcLmcxxLAcjrUtW9mCXo9o2R280txhElXUfb5/PjMC2itQOFQ3UcK8auP+bZpRpJ51DteI/6EVoE9/f6cMArQLV+ncobAzherwptG/wIFPu1QPdtCICJwkCaJNuYMvUV3P7OHhYsDw2SPf6SrCftc4odjaEGcxMluVLeQfYXBrMbLTrkbt3dO6ZyIhLj7irVLbqQD18tIDMRgJOqNoq1vl/ISLpl5Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This adds documentation for and auto-generates ofono.conf(5).

Grant Erickson (3):
  doc: Initial revision of 'ofono.conf.5.in'.
  doc: Add SEE ALSO reference to ofono.conf(5).
  build: Add variables and rules for generating ofono.conf(5).

 Makefile.am         | 11 ++++++++++-
 doc/ofono.conf.5.in | 37 +++++++++++++++++++++++++++++++++++++
 doc/ofonod.8        |  3 ++-
 3 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 doc/ofono.conf.5.in

-- 
2.45.0

