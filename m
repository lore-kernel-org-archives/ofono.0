Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E685126F27
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706916632; cv=none; b=RllEWz7Mb+fKPqT/a0UdaPUsdyvmH1GW4ZOUUOk0Zmw3SE71XbjMXJSD0CwaIEkM6nnDe/5fr5FUJMvlbbKIqjqOpwRVCKDL70oEyx2/s2uDLrT1SKiojSfLepn49zb1ERClgUKeOl4BiJTmQdyn75wR0kToo0dsSmGYVRKKh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706916632; c=relaxed/simple;
	bh=NrqBxJvvUtfbdW5tByjIcyXuS1i/cg/sAHXlMZ4+Op0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LiYPiErnIqhA1f6HvhxpVoszPADR/yWMod/w+IvbrN16ZkUNRe+MmXqh9/Qr2dyMQgIF2mdy6L50niV1pCdVuMEUaNrL9o4xUKEyxV/Mo2hoqKvRWatusTKERoUJ7FPX7KNBd9In1Tn0p+SggarvhoCL5xe2uJd7N85vl9r46Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHlFgmZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHlFgmZY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0171C43390;
	Fri,  2 Feb 2024 23:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706916630;
	bh=NrqBxJvvUtfbdW5tByjIcyXuS1i/cg/sAHXlMZ4+Op0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dHlFgmZYnSZpAN5/7AWhyPk1fqeW5elrMach3avKmEIr2884NYGkRCINq416usD8t
	 yYgwzEfs02aZYnU8R0w+G3qlrHoPjy1UypLyeGVy3g8YvPCs2m8x40CyX8DTwvn/R3
	 fsmsmaUCnau3IjUtmp/dwX2jwQ23bkqNxYY/ZsthUlDMyvxr/EAmYC61KSOgAx7/f2
	 4LRIoTUUoieniluscTeOwGqOHTZPW+y2rmjy14RXV7Q20l5hi3iozkph+oXcNDY4eG
	 1vguRFg0w/fd/jRGLRmOcssrR0Ea8lHqaXXUYOm0JzRjZwdFaiTe5bMHd2t8r5ZP97
	 C2E0Q5yO7gGkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A47FD8C978;
	Fri,  2 Feb 2024 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/17] umlrunner: Also mount /var/lib as tmpfs
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170691663056.19326.7160291387196376588.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 23:30:30 +0000
References: <20240130212137.814082-1-denkenz@gmail.com>
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 30 Jan 2024 15:21:06 -0600 you wrote:
> /var/lib is used by oFono to store various long term settings.  Make
> sure the settings from the system are not used by mistake.  Also, since
> the host filesystem is mounted read-only, updating of /var/lib locations
> by oFono wouldn't work anyway, which might be confusing.
> ---
>  tools/umlrunner | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [01/17] umlrunner: Also mount /var/lib as tmpfs
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=aba0f71b784a
  - [02/17] build: Only enable backtrace(3) in maintainer mode
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=05eabee2524d
  - [03/17] build: Bring in more ell classes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2a9ccea64b54
  - [04/17] provisiondb: Remove some duplicate MCCMNC entries
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=19a0d53ba5d5
  - [05/17] storage: Introduce storage_get_file_path()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cebe22caedd1
  - [06/17] storage: Convert g_strdup_* use to l_strdup_*
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d650fe8936cf
  - [07/17] common: Drop GLib use from gprs_auth_proto_to_string
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6f63dbbbb5c9
  - [08/17] common: Drop GLib use from gprs_proto_to_string
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c934b708742c
  - [09/17] storage: Remove mode parameter
    (no matching commit)
  - [10/17] storage: Use l_malloc
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4619f19d3ac7
  - [11/17] storage: Remove mode argument
    (no matching commit)
  - [12/17] storage: Use void * instead of unsigned char *
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=75998e0898bc
  - [13/17] storage: use l_file_set_contents
    (no matching commit)
  - [14/17] lte: Refactor lte settings management
    (no matching commit)
  - [15/17] lte: Add provisioning support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=69adffb51633
  - [16/17] phonesim: Add lte atom
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=783b036d7bc8
  - [17/17] lte: Write provisioned info to disk
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=53c13ead095c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


