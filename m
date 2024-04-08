Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F542171B0
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616027; cv=none; b=gPj8kwizT8Gcp7lmXuSVQAGae2muv9SEysseQCPMD9OlZ/cEq8Cvaai97D3VOyhH7cdwmr55PzQD0xm8/nacSQ+rRW4jqSlNXuK9TjQ6kc8WMflty2wnXe+76otvLDg2J+3Egl8+6fmbbdvjKOEYdRhS3ErXUm7WxsdTZLw3ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616027; c=relaxed/simple;
	bh=mlLOQaau7FpRLT14vhPUIOn7CtrfEXx/qOlWHvkK74A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rxvNFkeHkq/06Iv8PhHcLYtOhwkjNL6fR4HpDUoZN1vO7dSIlwRuAtBjRst9xU072OrJIZkwmb+iAwIKOHJ+SIXXE+DCjYpBiDW0X9VisfrKEdoxrRw5JsBtgt6bwQbqOM4ajylwIyQlNx7ffbAsFHM9P/nShmVl9WL3rR0fNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMHn9gu5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMHn9gu5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56DADC433F1;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712616027;
	bh=mlLOQaau7FpRLT14vhPUIOn7CtrfEXx/qOlWHvkK74A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vMHn9gu5epb5nWBsT8EBfZooIjNNs8QEtM2F828MCRRxPo1v3Yss+f5wBekauqwoz
	 bmPqrucwK+AfDDmzOphIveFBwE4o20ms+KjWtom1zw1eJre3okf4vKe8jlu7WtjzsN
	 otLvmbq0yjVUBN1qPPY2JzOdCO+c2TJtZIHEgeuFRoI0DeiXsyfU5t1K+sy5IFnM7u
	 xCHsIMU58v8M8SZ5vLI4ra/PkD6N3+BBdIhLUpL7CXFKhjpWeCkMw/p1NXmR3Ss0gS
	 aKZAM2XMY+aviiSYPOOEY26ZZJlWeOZw/u1qsyMPraBQrXYTcFraJGeDnMYJIy6fn1
	 ld5+/Gvn9QZwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D0EEC54BD4;
	Mon,  8 Apr 2024 22:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] udevng: Detect embedded qmi QRTR modems
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171261602731.14139.11720512601084022341.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 22:40:27 +0000
References: <20240408213453.53910-1-steve.schrock@getcruise.com>
In-Reply-To: <20240408213453.53910-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  8 Apr 2024 16:34:38 -0500 you wrote:
> Embedded qmi QRTR modems are identified by the existence of
> rmnet_ipaX and rmnet_dataX devices. Add a new "embedded" modem type
> so that these devices can be collected during enumeration and then
> configured for use by the gobi plugin. Modems of this type will be
> exposed as /gobiqrtr_X.
> ---
>  plugins/gobi.c   |  19 +++++++--
>  plugins/udevng.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 119 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [v2,1/2] udevng: Detect embedded qmi QRTR modems
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=296347f8a4f1
  - [v2,2/2] qmimodem: Default embedded modems endpoint ID
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6d7edaf5bc5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


