Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868B1E871
	for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076429; cv=none; b=GztXE00GCFecO5ncslf3iyK9lvdXY6zzI+nwEfzsFzyDZlI58VLI7JkvHHf5wyf4daK6gmTtuHTqb9NSbOc+57FkbUdvo/TW1/mHa563PKxDXXOQppYfkfq1CucBjtm1qbPv4kXy/ad9FB7tUT451BYxRvdnv6316jSDUMvsh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076429; c=relaxed/simple;
	bh=rCatLuHsVmqmMyoaOr+fB3X/R97RnbNLEnkbubt8tEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EYHuTDrrqbRb5fXlneJT5Mu7nuF11mQEk+HNGfPOU8E3Je+AUFuVwjpGYfP8QIjbivTQMXQjkJFFO5o78tW8wwe1T3RL48HkQFznQcpx4rgarShXhjS6m+wunI05w9JlFxlOA9unbD3ZzQwRNWPDeXL/EenaxFGTPnhAZ9SA2DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2vxelVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2vxelVp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 207D2C2BBFC;
	Thu, 25 Apr 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714076429;
	bh=rCatLuHsVmqmMyoaOr+fB3X/R97RnbNLEnkbubt8tEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2vxelVpkNou70Cn/Yf1IYtJ7zikBLtQU+0xaVp+0bkYnCF1AGeQWKcUe4C00jrrI
	 0iQayo4MofYXlPEL1TFWr5DH+CgkNCdnrX1klaytjn8tdERFYH23XGoFb654oVdnCr
	 oV8i3bN21azSWCPa3nubcA2NpsR+AsxWRA1yiVJD5eHi34/sVMZg75fwlzAzzFx5s6
	 8fUkjG6xNlNFksASEufozQOwr9sMVlEwOg3f2ivLJEyBV4eE+RBXLQoSZdi/SuEvNf
	 5B0hLrnQPz4Epcg+H7/rLlVAgCXFb/c8R0BtIvH2MdTwvLn+uxHQP18AzplLxdGC7S
	 IjVvAgXVUXtFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 102B2C595C5;
	Thu, 25 Apr 2024 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atmodem: fix detection of ATD*99 for non-muxed serial ports
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171407642905.12759.7904250069278840586.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 20:20:29 +0000
References: <20240425115744.274891-1-martin@geanix.com>
In-Reply-To: <20240425115744.274891-1-martin@geanix.com>
To: =?utf-8?q?Martin_Hundeb=C3=B8ll_=3Cmartin=40geanix=2Ecom=3E?=@ci.codeaurora.org
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 25 Apr 2024 13:57:43 +0200 you wrote:
> The gprs context probe function has logic to detect whether CGDATA is
> supported by the modem, or if ATD*99 should be used instead. However, it
> seems like this logic was wrongly placed after registering for CGEV
> notification, which did an early return in case the passed chat did not
> have a slave.
> 
> Thus the ATD*99 detection was skipped for USB modems using separate
> "virtual" serial ports for command and data channels (i.e. ttyUSB0 for
> AT and ttyUSB1 for PPP).
> 
> [...]

Here is the summary with links:
  - atmodem: fix detection of ATD*99 for non-muxed serial ports
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d42aad3e9553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


