Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0913F8D4
	for <ofono@lists.linux.dev>; Thu,  1 Feb 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823626; cv=none; b=abLvR8DHqdGlVHMOWuZtS5K+5e+f+JAZzRxuqupwN6I/IFR4tPBklAENtMPihl53BRaMOX12vSxp2FBXuztCWd0eka/EnWZbSet5RvuAxoBQlZfZa8hMa8vR6dhYtwNJtnbfSxR3p2IOHc47C5HQyBghgjQhw2jfiMeaENwONOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823626; c=relaxed/simple;
	bh=1WKvK1YamOLrhi+N7sISORJLQvVhp/rhb//7H6CT2Tw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DuV21jbeR0P+T2aIn1yoe2gFFcofgMKQRBrZOcwEaI+XLpKV0rDb06SvfueSbQpgzlmUhnP2RLjo/BC7VRBDBGXawjGxFy+xUaMlefl9X7sTqZsKyIiMoi/M0FXPmqMSvN0/jg812Vq3Yr3R0k/mRhbp+xfoWzSw7LQ4OqKUDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As5QI609; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As5QI609"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64FD3C43390;
	Thu,  1 Feb 2024 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706823626;
	bh=1WKvK1YamOLrhi+N7sISORJLQvVhp/rhb//7H6CT2Tw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=As5QI609ZXG0TTp6EPKIk3WAiEhXefgdtEndZCzpl9gYFO4q+19dm8Y93fWEiRaPW
	 JXSS9t3OOdxA/oxVbJsq+oFuyk8akktIScmrdzMLZVP6a22XmnCxuHhzaJpLyqAmNf
	 jykeEB/WvnRgA5gvgABEjSxDNOBFjh+M5BPCEfAUxv56m0RyDI34xTT2sjeWkqUYFQ
	 Mt7e4j9f2Sb2nmbZHKiaH43HZqC5ymib9O9jsXs4yg3bAisVRdyhQSCuYUKyWJJke0
	 aHJ/FLi30Gx0IlKo7JYXHgrZFKT0GHLq5an5E1tu2XdrsOkLHW+rVYli98Glw10U+C
	 wGEr7dQO2wGCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AFE0C0C40E;
	Thu,  1 Feb 2024 21:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] build: Generate and install provision.db
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170682362630.14986.9850171207375566403.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 21:40:26 +0000
References: <20240201202350.951327-1-denkenz@gmail.com>
In-Reply-To: <20240201202350.951327-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu,  1 Feb 2024 14:23:33 -0600 you wrote:
> Run provisiontool to generate the provisioning database in binary format
> from the intermediate json format.  The database will be installed in
> pkgdata_DATA directory (typically /usr/share/ofono) when make install is
> performed.
> ---
>  .gitignore  | 1 +
>  Makefile.am | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Here is the summary with links:
  - build: Generate and install provision.db
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=378b94a12adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


