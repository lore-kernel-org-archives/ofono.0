Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853856FE16
	for <ofono@lists.linux.dev>; Mon,  1 Jul 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862230; cv=none; b=auCOZ9ajVPmwrUg/xaiJaUliS81r6FWb5lArHaHA3kXN9EmV7MblmxwAAHKyoPseDc47IkNzQOB38zGXwkMDpkyYOFOEErCgd6D+NrybPRiMxQJYneznukIxpnOzd7sgTT1cYGn+ZTEd5BvJKo0bqTpU+6dYITvHFAepcNzODHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862230; c=relaxed/simple;
	bh=Il+P6HSuvdFZ8p41i2CdNhHeSdrxtpCA7pv8F5g7AwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U1GyP2ocF43b//udr26Qy5a1y1OLzriha2PaXsUUzGYA1foE8jRcGXM8lR0O3TS4xByEs+eMtsTyrCaoaQ6GZyRU71uyw55veKSmpvOP3Hp7/aEjSBZG8DszACJwFe3PvY1sS0Arl6VGZOF6qv0xRrT7FJEYqqMfdHHFK+w+iEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bneWwOpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bneWwOpe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 005B2C32786;
	Mon,  1 Jul 2024 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862230;
	bh=Il+P6HSuvdFZ8p41i2CdNhHeSdrxtpCA7pv8F5g7AwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bneWwOpeDE5AOxXH8c7ski/GOVteSOPOlUM3Ecjr/HUfrQxLw0twWP4LQtFXx0CMw
	 3LyQSIsR/9ZVkRIWJpesCTs05Wuu1IN/jVDhaymUEF/fWHrQA3J8YK4jNiVPNK8j+Q
	 6bHJYYb6eb6hNUKXSW321Dr7q6s6skb3h7nzR5RT+6bNq8x9bSAt3ZdEPj7z00ToxL
	 6HgOgOqBpFLcr2H4etcYOH7Yd7WczR1G8azXBuJ9l6OPjQFZV2y5bl5AAp9wiSPTES
	 qsXAe1/LQahYrod+umxt+E+xmN0J93awpLlE3xAGsCMkmLWT7tmTTfZUPJ+bTcTqdh
	 VWwQKLWQgkb5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF2CAC43446;
	Mon,  1 Jul 2024 19:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] udevng: Remove Modem setting from setup_gobi
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171986222990.21097.1279834359494476911.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 19:30:29 +0000
References: <20240701152553.23072-1-steve.schrock@getcruise.com>
In-Reply-To: <20240701152553.23072-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  1 Jul 2024 15:25:49 +0000 you wrote:
> gobi doesn't actually use the "Modem" setting since it communicates
> using the qmi protocol. The fact that setup_gobi required this
> interface actually caused certain modems to fail inside setup_gobi
> since mdm was not being set.
> ---
>  plugins/udevng.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [1/3] udevng: Remove Modem setting from setup_gobi
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2f7a01d0c722
  - [2/3] udevng: Remove Diag setting from setup_gobi
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3071e0720e8e
  - [3/3] udevng: Remove gps from setup_gobi
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=57f914624cf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


