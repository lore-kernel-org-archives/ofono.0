Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D017C7BE
	for <ofono@lists.linux.dev>; Tue, 10 Sep 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952962; cv=none; b=IpQU0fCV21DZeLct8LGhewubXqxGa9PGTMoP1LsT9SwMhpoJlVITkNGLtAT1yZLjEIKCPGdPAU/sLUCvWZZGeHwuzkuZCcdz+Dwz5fEd7GdUPPNKVf6gLsBZeSB2TtDk8Bi8UsXJoCre02/FLAeDUJPJnu0QddI5EnZ9EXi5+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952962; c=relaxed/simple;
	bh=T+lOr/0y6fFjDB3m/PwhqEF4RlSps1nrdde6cKWVq2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YgtWxc/Gcp+T5xPyDnXv5NjRIhE6XeJyGJOeZZ3TArvJ2kbHX9DCM7cPyaR/eJIaDtyZldVVUB/qkou85B6H9DmreDYFmp/0uSqLfqiYveZcHAauvqmBblqhKCnYkjIdMV4+x7kT8pmVCHqi1AhamK4lQQrfpSMSoUyJc8DU2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bqPaiOEp; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bqPaiOEp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=gw92Jd8XyWsQuB6aY+yM0g9jyT6MCt7CZVUOAyatkYw=; b=bqPaiOEpf11HWyvW8TsvKKmiXM
	LzqUl47GnI4v3srUSx5AV/SxjOg4apextGNMhbSLo1s0lIhW7ucKLzj8eaKGUVT85y+WGW4586Ck/
	7tBetvdP0xc5tA7tFhC5+myff709tVUx7tlk+UJbWqMb7JK6veP48da1ZwhReDcbVUka0T4AYKIZq
	7lVHLxuQbMG9ADqhRPQRiSgeiapQtXC4I+HK6jI42aiWa9b2lKBHrNdt5rqAlr+WGF0/LDcYQ3IJX
	Iv2Qd5GV9yIVtPpo4v7edRjhoS0MjAVX5nJN4ltBmmz9geXO7dSVkVn7XZY/VEoiw9yplbBvm1QEZ
	1P3NMRsA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCu-0009YS-Nn; Tue, 10 Sep 2024 09:22:36 +0200
Received: from [185.17.218.86] (helo=benjamin-ThinkPad.geanix.com)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCu-0005mq-0k;
	Tue, 10 Sep 2024 09:22:36 +0200
From: "Benjamin B. Frost" <benjamin@geanix.com>
To: ofono@lists.linux.dev
Cc: sean@geanix.com,
	martin@geanix.com,
	denkenz@gmail.com,
	"Benjamin B. Frost" <benjamin@geanix.com>
Subject: [PATCH 0/3] add support for Quectel EG916Q-GL
Date: Tue, 10 Sep 2024 09:22:07 +0200
Message-Id: <20240910072210.2618396-1-benjamin@geanix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: benjamin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27393/Mon Sep  9 10:29:16 2024)

The aim for this patchset is to add support for quectel EG916Q-GL
using the usb serial port.

Benjamin B. Frost (3):
  udevng: support for EG916Q-GL using option driver.
  quectel: support for EG916Q-GL
  atmodem: Support for Quectel EG916Q-GL modem

 drivers/atmodem/gprs-context.c         |  3 +++
 drivers/atmodem/gprs.c                 |  1 +
 drivers/atmodem/network-registration.c |  1 +
 drivers/atmodem/sim.c                  |  1 +
 drivers/atmodem/sms.c                  |  2 ++
 drivers/atmodem/vendor.h               |  1 +
 plugins/quectel.c                      | 10 +++++++++-
 plugins/udevng.c                       |  4 +++-
 8 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.34.1

