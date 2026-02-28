Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8193EFD21
	for <ofono@lists.linux.dev>; Sat, 28 Feb 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269941; cv=none; b=GjRamJYNz7WqdB42J0E777SGOUwgpJKjacz6PdPQxYd80v8eqrd9rYmUmvJAoLIv1UIYfU9CIFqVQ4yeOXT/RyXoO2a1RLFkSBQDsmF6fbHtOwUO3/4BPRxvxc58vbFFNaERXiE4tCU8xTNqXC0BuyVa+InPwGhyOq8GMTXv50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269941; c=relaxed/simple;
	bh=mzg3/ktoJDdfbFLrs9vBlgEBpQasBU+Z0JCO8akmPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y69yvec7o1NY8fvnPb/vaOrXBO33CX+g/4/Dtkdp8KjDsfnXLbI0XBk9SuBCwMAIsQdsnr1RO6Io0UVxckdgaA8JjU1bpcdGYSmZULvegG34Lbf4NF3drwNQf4x5nqh7aQylIGKDhd+KTxYb2skYX5SxAOAAx5azHr/Hh8BL0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id E61F510F3F2; Sat, 28 Feb 2026 04:12:19 -0500 (EST)
Received: from 5400 (unknown [172.56.160.155])
	by spindle.queued.net (Postfix) with ESMTPSA id A3C9F1137F8;
	Sat, 28 Feb 2026 04:12:17 -0500 (EST)
Date: Sat, 28 Feb 2026 04:12:13 -0500
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Cc: Jonah =?UTF-8?B?QnLDvGNoZXJ0?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 0/3] Port to Qt6 (v2)
Message-ID: <20260228041213.45bc0030@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

From: Andres Salomon <dilinger@queued.net>

A few years ago, Jonah send patches to port Phonesim to Qt6, but only
some of them were accepted. In particular, the patches to convert the
project to CMake were not pulled in. Rather than switch to CMake, here's
a patch set that enables Qt6 within the existing Autoconf build system.

This first checks for Qt6, and will fall back to Qt5. There are still
plenty of warnings when building for Qt6 due to the Qt5 Compat module
being used, but those can be cleaned up in time.

Andres Salomon (2):
  Only call QTextStream::setCodec in Qt5
  Make configure script detect and enable Qt6 if available

Jonah Br=C3=BCchert (1):
  Fix compatibility with Qt6

 configure.ac     | 26 +++++++++++++++++---------
 src/control.cpp  |  8 +++++---
 src/phonesim.cpp |  2 +-
 src/qwsppdu.cpp  | 12 ++++++------
 4 files changed, 29 insertions(+), 19 deletions(-)

--=20
2.51.0

