Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DE242D72
	for <ofono@lists.linux.dev>; Wed, 20 Aug 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706796; cv=none; b=GfAQUBMctdEWDFRA86JtjKMFoVUl8dZG8jy94UT2bCaoUUEPp+3By4dxw5INk4dUHsuuz5u19GLqxS3ileU5JH2+VwP7VvxLYTYT85UHe0umkGM2Izd4KvAXB/OsvqPod5KS3Ttgq/tB/UYVS2/eZokSyKbcHwp6LdO9dAtQFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706796; c=relaxed/simple;
	bh=hdNuLI80cTS9z62B3mp8EubqITwY98neJARNHSKNflQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BqFEbgL3syXPKSM7MwBf9RQoAw36tB/nGumHyEQNMBgGyRocb6R4FYMwffumNTBkKjbjF6zZdlv0qoI440I4P0CiC/cw6QtZHj6/8su8wzqAIcuRp9ccYoIwG2IU1r+VVTiLRAXdxm2zU+eoTCLURHd4h3RRm3K1jJmB45pxKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecMqqINM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecMqqINM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADF9C4CEE7;
	Wed, 20 Aug 2025 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755706796;
	bh=hdNuLI80cTS9z62B3mp8EubqITwY98neJARNHSKNflQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ecMqqINMmj4J8LkqcT5oZoVoMry/RwroKMGAs6WucbdBdUtaoH4Fe8DPEPt6OiOOp
	 YYUdRXZXPyYcFz+NoL0CEMJPyNmmQa6AnN0kbxnXSld5JNiDNclZHRsgGnO8AbRXFq
	 g5g3y4NYfgneFFQFP6W5nx+ZquSMRbFVX6llRtbhT7/h1i14+xrueCOYOErMATmnSP
	 XV5pVB+AOuUlY20YQXMt6ME6GLppbDEE1PPALIGdtK+Pgn0qtwijTy8NbTXOHTWwkU
	 BUoZ+sdIKL55ByuhvLO4CGW8oi4iQTgS/7wnJX3aI2P7u074riEZys2eHr2EfjwcTi
	 kS48meBet7n4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DED383BF4E;
	Wed, 20 Aug 2025 16:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sim7100: enable ppp-reset workaround
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175570680603.295806.7656348284273827010.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 16:20:06 +0000
References: <20250819104700.1027172-1-sean@geanix.com>
In-Reply-To: <20250819104700.1027172-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 19 Aug 2025 12:46:59 +0200 you wrote:
> Implement AT+PPPTIM command handling for A76XX modems to enable PPP
> state reset when powering off (AT+CFUN=0). This is needed because the
> internal PPP engine doesn't shutdown when powering off and makes it
> impossible to create a new PPP session before the old have timed out.
> (15 sec)
> ---
>  plugins/sim7100.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)

Here is the summary with links:
  - sim7100: enable ppp-reset workaround
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d3a70b22ee37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


