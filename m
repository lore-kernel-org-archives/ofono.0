Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFB3EA98
	for <ofono@lists.linux.dev>; Tue, 11 Feb 2025 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234165; cv=none; b=aJ8XauakSvFwz1F26+0A/UfOb6NoXnVIaNDJD+3q1BTmtWStca3lqyyEPXJywThjVyJq3nYNH9lP/jlOXjYUvKj+VRZBEwHSgg80RgrRY/5Dn+dz4DQAYZQRwVGHSA+Ruw6CqV1yOBrap3qlki9CC6R27z68KTDTwAkJ1x5FZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234165; c=relaxed/simple;
	bh=qB1jD7zCvTcS7I+Y9QpJY2pdouf8SjGK2usX3sI0/Vo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QAa6lXJwAaz+TeU/JGGd4PrO3c4/7E3UvtOpn8tf1DUcxQyWBzFNykI66BiaaBSOgdWMmN0THStZcUOO/wsMjKvZrAPEMUzLV3Nm3k0dmJMttnD+jJlEWtu/WyksTIqeRRYZqJw27UV+k1u40+gnxS3QH03p87mA/qnWsJfIX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MbC7J3jd; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MbC7J3jd"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id F04A2164A14
	for <ofono@lists.linux.dev>; Mon, 10 Feb 2025 19:35:59 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A35CD124FE6
	for <ofono@lists.linux.dev>; Mon, 10 Feb 2025 19:35:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 0/2] data: Update Verizon APN Contexts
Date: Mon, 10 Feb 2025 16:35:56 -0800
Message-ID: <cover.1739233526.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=npwdZSV5qgGs6J3uauZ+gtjEtojiqnisnJPC2BRSwbw=; b=MbC7J3jdMncniERd4JNBxOlm9YBsKhun79iBIljQ4R5CL5UVRRKO08QJ5BWCPpj3jpdlhFM0G2M9ok+nD8LhCw/NeTwu1Chgh+OoUUhbaM3Im/TS5TUKVLBy6d7y4mriAog8AoLmB6J/kr83V8WC+o1wE1v+x1TxsL7OtVjr/ILH2inrYg3spbhZ3CjCOPTZ4rKSCBmhfQgj07Xdxz9xbOf65/J7gYXKZayOywMHEUp8dteYGwbOp9auZHgn8pTi7ss/U/237bxbr3ohkFx1vHkqwG53RYzPKAWbpby/Nvn19rhognz3gaddrTmlztoDcXzj0/yCWpvRMa6CX+b8uA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Verizon has a number of different Cellular access point names (APNs)
and contexts, depending on the application, per their documentation
here:

    https://www.verizon.com/support/knowledge-base-72601/

Some of those contexts must be used for initial attach (IA). For Voice
over LTE (VoLTE) applications, the 'vzwims' APN is such an IA context
and is currently marked as such.

However, for Internet of Things (IoT) or machine-to-machine (M2M)
applications, the 'vzwinternet' APN is also such an IA context but is
not presently marked as such. This change adds the 'ia' type to this
APN context.

In addition, one partition of those contexts are appropriate for LTE
and/or VoLTE applications while another is appropriate for IoT or M2M
applications.

These changes add the 'ia' type to the 'vzwinternet' APN context and
add the 'iot', 'm2m', and 'volte' tags to the three current
Verizon APN contexts such that no tags or some combination of those
tags produce the desired set of APN contexts for the desired
application(s).

Grant Erickson (2):
  data: Add initial attach type to Verizon 'vzwinternet' context.
  data: Add tags to Verizon APN contexts.

 data/provision.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.45.0

