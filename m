Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255652E542E
	for <ofono@lists.linux.dev>; Thu, 26 Jun 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949982; cv=none; b=LL7BgpefTs5DvpLcf6mpj5WMhbkAJoKZefmPYKEK3RohlS2s9jDSoiIPCL2LzzL8MkTscqEMDe2BRMLuj0pKOqcwrc/hNuwVvAw++8O7cHShzfI/4weyhzrzhcOBgW3lTwSv3FqSu+nTMB4J7XDRdOXDAcTz2vxZTBBgBknU5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949982; c=relaxed/simple;
	bh=LVaFVrVG7LgKDHe3+5fV519abRf4NH+MSgcWWvv/AjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M9C9qyNBzVsbgWkK2claJtKgVF2uCFndQogL49ux/1KjncyCILo+GLTswmQTEt1iZdOde/W1fENUCTwrz9R0PqpLjHVd12NGgnyh62gkq+RTxZMaC4qNiHty16wf4+2JzJRZE+vif/P5n5GkosNAMKGiYB+yzMkHskXotfPS2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDqJQ0tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDqJQ0tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D46C4CEEB;
	Thu, 26 Jun 2025 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750949981;
	bh=LVaFVrVG7LgKDHe3+5fV519abRf4NH+MSgcWWvv/AjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nDqJQ0txLd7evbsuGuMJ6RdmQ11+rVd8CdBGDFCbGnLQhKyijADq5ndIQ3c4qWbUm
	 HtnV/OdXLqE6jLQHsWo4AnRRXEi2qvR/1DkzXGiaNWmZLjCOOpfMrlC6O1uIvqn/PA
	 WhAXVL1utJToVQq36bHlbwoFIREZVphUkV1DDa9l6qcumX+jEtShvHq/zedapzL1DB
	 Bf/XrpeK6izbNzgy3+AR89gld033J5BNveZP7VzOiznWp9OMGyAyCV4mWynfadwurX
	 MIzUL7WjiKHoIs2b1vxDoBYUd29wXwL+TJrulijV4JPUpUoH0Uf8kqaQW36MtuB4FH
	 d2Dplb2H4lOSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716F53A40FCB;
	Thu, 26 Jun 2025 15:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] sim7100: query until AT channel is ready
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175095000823.1233506.6117694860314064146.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 15:00:08 +0000
References: <20250626065853.1357255-1-sean@geanix.com>
In-Reply-To: <20250626065853.1357255-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 26 Jun 2025 08:58:52 +0200 you wrote:
> It's seen that the AT channel contains unknown data upon power on.
> Query the modem until it answers with OK. Create a timer to re-issue
> the AT command at regular intervals until the modem answers OK.
> 
> plugins/sim7100.c:sim7100_enable()
> plugins/sim7100.c:open_device() devkey=AT
> src/modem.c:get_modem_property() modem 0x261f20 property AT
> plugins/sim7100.c:open_device() devkey=PPP
> src/modem.c:get_modem_property() modem 0x261f20 property PPP
> AT: > AT\r
> AT: < \r\r*A
> PPP: < \r\r*A
> AT: < AT\r
> plugins/sim7100.c:init_timeout_cb() 0x261f20
> AT: > AT\r
> AT: < AT\r
> AT: < \r\nOK\r\n
> AT: > ATE0Q0V1\r
> AT: < ATE0Q0V1\r\r\nOK\r\n
> AT: > AT+CGMM\r
> AT: < \r\nA7672E-FASE\r\n\r\nOK\r\n
> plugins/sim7100.c:cgmm_cb() modem model: A7672E-FASE
> plugins/sim7100.c:cgmm_cb() before CFUN
> AT: > AT+CFUN=4\r
> AT: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> PPP: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> AT: < \r\nOK\r\n
> plugins/sim7100.c:cfun_set_on_cb()
> src/modem.c:modem_change_state() old state: 0, new state: 1
> 
> [...]

Here is the summary with links:
  - [v3] sim7100: query until AT channel is ready
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4aaa475f3290

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


