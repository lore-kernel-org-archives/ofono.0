Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F041EB3A
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626635; cv=none; b=HRJsvuyl9eCeRPrg0E+u162g5SEiHWKFo+thj8zd2x18WAycyM3+yy1pvknuLHwDx+7UoKSRac4/P1kQSZkmck0KaZxSgaHxg61jskIWFfs7yFwCwUBSsrfs9OdfVBym2Y0LSl2ih3MabVcU6HwDQPMg258jXHPYLJWLSDVTAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626635; c=relaxed/simple;
	bh=MApcQ5ByKqaH/pRcQhD1e84fcvr15stoCDlBsmdcYDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SiHXqBjeuXxqsTQP+4FdcsisnDklkdiUrfK3brf3YM4iKLQpQQbr29viYVyum/ea84nSKIjpQaKaEOAU5ZFrmhRM+Jw41cX6PRqCVE2mxjizxlo2yrOxXLJCgagTZOc1dFQTSjZ2/hUTjnI/fE4IZRfdq4hY5FGyJvlZha/Mgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdiwKT62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdiwKT62"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC7E8C433F1;
	Thu, 22 Feb 2024 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708626634;
	bh=MApcQ5ByKqaH/pRcQhD1e84fcvr15stoCDlBsmdcYDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CdiwKT62GdoX8bw2yMwFRj4FLO9bagM9mrxjtGdzlG1G6c1s+viXAugTLGy22oTFN
	 A+bQBsMr8x3mFhiL6rT0WTRs68fshGGrFyw+aiugkObxHnaLYPVewPenrA33lurSjR
	 nuv/aJe3tWXoPS4fu8lloVXWjXOBATFBYXgZdy2LyxyRMlOHuyjyVJwq+fdsny97GU
	 wuqE6h7zVHwQFzj4TDWCSKThfONrlTk8821ySRetQL7hqVqrIfOf5JOizhLyhTLwC2
	 yv4E6IqzNfdVxGp2QHH2H54VFmvm4aUgoOONf499St91pf+AaoMciP0g7e/x428waX
	 25MM1E2sG/H+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A047D84BBB;
	Thu, 22 Feb 2024 18:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] qmi: Drop qmi_device_ref
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170862663462.28435.2186670942239492823.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 18:30:34 +0000
References: <20240222171438.1291553-1-denkenz@gmail.com>
In-Reply-To: <20240222171438.1291553-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 22 Feb 2024 11:14:17 -0600 you wrote:
> This API isn't being used, drop it.
> ---
>  drivers/qmimodem/qmi.c | 10 ----------
>  drivers/qmimodem/qmi.h |  1 -
>  2 files changed, 11 deletions(-)

Here is the summary with links:
  - [1/4] qmi: Drop qmi_device_ref
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a3754ea27528
  - [2/4] qmi: Rename qmi_device_unref to qmi_device_free
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=fa849c0c1ab3
  - [3/4] qmi: Introduce client_release driver method
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=63adff8aaf1b
  - [4/4] qmi: Introduce client_create driver method
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4d20101211ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


