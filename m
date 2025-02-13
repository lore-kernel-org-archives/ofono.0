Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C14266B5A
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480412; cv=none; b=ivxs3DTcwJFnaSPTd6x6OZsLWhfGLeiwIHwhUkKyJeptqErMxZR2EE+3hTho1iImJX+0WIm2U4Bw2/MLfL0oPTVTD3yh6e/SPCJu9hbVGAYjnxM3r2MZTZaJ+YRAwvqhMlXhJFuNj54G54oZNHNiDx9jkWzYc1Mj6V/UEdw0s/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480412; c=relaxed/simple;
	bh=js5LccS39b5y3i5aBalVsaV+q22cr+HTdKduVsrxYmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jq0EPq/HADvXiX31yWMPqHqXOH8DPgn54/l/DIssmv1ZE6hvXIpDnY9tsm3p/l8UnPNjJTTks/Lo+aUDuZhqC/p2KyXa4KvpVeAMKAtq+arIa/EB4FZMnrb7HgC4V/h+xABB/KV9s9ZJ8SaK6UJ94RFkSxzVYp1R3iexWtbdvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebD71yyj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebD71yyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76065C4CED1;
	Thu, 13 Feb 2025 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739480411;
	bh=js5LccS39b5y3i5aBalVsaV+q22cr+HTdKduVsrxYmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebD71yyjjx9BTP2is28phEHTbK+P+EDOHHScvuE1owrcBL71UidM99v3FnXE+12xD
	 GlD6T5SbPeKTZfXcPE5I4FCkPdTtnbXy+j4OVp0Ar0ng1mfeqi434AYwNltakq7NEA
	 uBxN+PfwxIwM7MZ9rtFuljAD9mF1hZumFbU8YcSOOxGkMI9JBjirS6H31ZvbDoC3Sw
	 iP9Cvbo5ttEPFPgP/P6Pusc5ATdh4SYENeSi6NTlaEpFnr4r040gdM/Zvxpn+c/WDg
	 QjKB+48hFu0714mPCi7nrqRRT69bnC7dZ5v8wM4v8rMvTP/sLhINBGG0hxN/NPT/Ct
	 4hMUs8aAOWBxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2BA380CEF1;
	Thu, 13 Feb 2025 21:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] data: Add 310 030 MCC/MNC (HNI) as AT&T.
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173948044079.1373628.2383733173984484210.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 21:00:40 +0000
References: <bbfc59214e9740499221d0084dd7a223b1583a47.1739475286.git.gerickson@nuovations.com>
In-Reply-To: <bbfc59214e9740499221d0084dd7a223b1583a47.1739475286.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 13 Feb 2025 11:35:00 -0800 you wrote:
> The 310 030 MCC/MNC (HNI) for the GSM 850 MHz band was acquired by
> AT&T Mobility from Centennial Wireless; however, at the time of this
> commit and as of "ITU Operational Bulletin No. 1280", published
> 2023-11-15, AT&T has formally withdrawn this MNC and the status of
> this MNC is non-operational.
> 
> Nonetheless, "AT&T Business" SIMs issued have SIM IMSIs prefixed with
> 310 030.
> 
> [...]

Here is the summary with links:
  - data: Add 310 030 MCC/MNC (HNI) as AT&T.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d2dd983e0686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


