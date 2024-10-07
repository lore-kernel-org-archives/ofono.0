Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713491DDC05
	for <ofono@lists.linux.dev>; Mon,  7 Oct 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324029; cv=none; b=KeglMUiqy6ZELvqzmPbawI14fSM4fDoB2/v8L8weFfKocN4CRhrH2GIT0cj4nWolc3ER87epUO97HQrBEB8e7YgOA+SyYhkBqZIO/MyUlAGymT6Kvx7//Vw0yPOMA5eh+k8gZO5/z+6JIARUpPsxxXN6wMfvFFMzr/bgrBXhkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324029; c=relaxed/simple;
	bh=QHlFgYsevh0I3Js2gPBzNAmW0bWXozCeIs8WN0ZxbcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PBfSlr3s46dsiHs8NUyDJrPaEduFA+ccMyqFj0hNyDA51ei7jKQs1Hj0E8JCm7d3jzWHg/df1HTW+Lq58/QzDoNTjOtgvoyOrqEOU0flxhCNKTK7Udjv3U5rgrG4eSzAtSx1Xt9RoEh94ZsV8QXgbpHvE6c+QHO5kBrkpPv5cYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sULYH7I1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sULYH7I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC35C4CEC6;
	Mon,  7 Oct 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324028;
	bh=QHlFgYsevh0I3Js2gPBzNAmW0bWXozCeIs8WN0ZxbcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sULYH7I1IayYuXKiGsXHTFO/2BuX6/KUuUuxtBi+lCxji926fsiZdMll8IRJenaxk
	 UxuxnNB9QBwNpKM7OrKo5ah0cDXbz5q5Nc/rwibP8I4/ftqeQugBCPRMSG1fl72g25
	 Gm5oFNgiFxDnx8MIdy5dEVC/CLS7xeAXtUTmJO0LAYBmxNqSrT1DyKdjdNPNVo2Jz2
	 IsnyRpJEulFaurFp8j2EoJiV34OJsc03+o/0WDabNO5zlJ3E92fIFgClZpiVQbx8HI
	 zOd6FMOtytm7MYcP0f36pMX2ILBlbJKkIkSOiA0jOBxiKg0K+kRDYnlLbI8kbsrXc6
	 v386qK6rlf3Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9C3803262;
	Mon,  7 Oct 2024 18:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gprs: allow attach on eutran networks
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172832403301.4120599.4007089110853357062.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 18:00:33 +0000
References: <20241003124737.666419-1-sean@geanix.com>
In-Reply-To: <20241003124737.666419-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu,  3 Oct 2024 14:47:34 +0200 you wrote:
> SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
> 6 registered for "SMS only", home network (applicable only when E-UTRAN)
> 7 registered for "SMS only", roaming (applicable only when <AcT> indicates E-UTRAN)
> +COPS supplies the <AcT> = EUTRAN
> ---
>  src/gprs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - gprs: allow attach on eutran networks
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8a61a0c44110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


