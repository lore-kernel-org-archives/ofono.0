Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC13C47C
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324436; cv=none; b=sUDaAcSrUClb5WsPvBufvpFU+JEsXFwjS3+e5Fk9X7zSu4WyDBDwi2LAUGh22osW/V9hfByjfbg6E5FeTtOGHsZmgxyvEhLOVOzBC7TCdoVJY17YLGja1OKwhfQZxJtZV+QVZIeMbUY4io0X9zCC3gaX7GYBDUA1qH1Z6ZQ0oZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324436; c=relaxed/simple;
	bh=3ZESgFUN6JGc9QKlftO7FbaetXyrJN3cKBPv/UgVeYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iBqdDFcUvg7bW9TksrIdUIoHJRZ41yr2q0/zlsOKIjNjAlOkhxPKvi7L3GMBLAhPeI3pNt3dBIVSwOUim8OxtJxgUmCyoX+ZfG2lrXdDpB7e1ECjwFpnpkI4sdcbmHWT68rr+rm5W6V4ZWGczcKxA5FDRjqEUPgAL01zzxTB8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCi60yNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCi60yNw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CDFDC43390;
	Fri,  1 Mar 2024 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324435;
	bh=3ZESgFUN6JGc9QKlftO7FbaetXyrJN3cKBPv/UgVeYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCi60yNwfk/m6kvZuVLJ7cSJpqWuWAi0Pr1bSKeJ5U9BP8zkT7HGUqg0y3kBbNJ1v
	 wK3Jtlp5K7GdTBKn3yOcASF0m46/D5HvxlhhYqTuj4oz9O2Fv3Mch3B9qVP3py/XwM
	 uubx80i80YXdbAA+bZHIkghzxfiJQElq02mUZ0fA4dD5rGpoam6tRkbdGRGTAtnban
	 bo8zKd8Zwp6XXsyLybr1IO4nXh0QmuDyrYrtz+ILihIh123rZep+v59y1ty/Y9Y9Ke
	 g8FcI4oXxA87q8KMSfakCXZ0zTG3ALuqZyuj7ORmYvgQdFY8eHgnPtWUNPjmD1CATi
	 RIL5lh9JxLVqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61FC5D84BBA;
	Fri,  1 Mar 2024 20:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmimodem: Add support for "embedded" endpoints
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170932443539.27879.6300440922978030264.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 20:20:35 +0000
References: <20240301172816.1703961-1-denkenz@gmail.com>
In-Reply-To: <20240301172816.1703961-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  1 Mar 2024 11:27:57 -0600 you wrote:
> ---
>  drivers/qmimodem/gprs-context.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - qmimodem: Add support for "embedded" endpoints
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=342237b10b86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


