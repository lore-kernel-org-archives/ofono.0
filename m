Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F014F12F
	for <ofono@lists.linux.dev>; Thu, 24 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780236; cv=none; b=NjXfHOoeJi6FjfixgM9u6IPW/CHoKYMg7K+PkPX2EGkUEfoKMd0LRYqasKCglAmqc0RJVp38+6ZRyEz/TttUdtrMHv4zFL3MdqtdPFhEIDoJEmN0RgfqrgJywx381oyfAHR0T7qEF0JvvCH9GynK98zlzJAq8rjPYTNmCzXPq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780236; c=relaxed/simple;
	bh=JjYkPFzVGY3z0JG2dt42Ch02/BkGGMZFVIXcHiGynsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nlRh8oe4koYMndqtI0NazIZLITBvBGOemoWS78bWQ9G0IrbE2UQA2A6Y0Un2Ksy7mCA3tRluhIbZJjy3soMEqBSDrfW+qlmDRb4GY2wZy7dmNVWEmdrGdnLgUpkHEhisQZDtzE+GMh+iEJj00/2T9YGX+SdjDX66V5h+KI/fW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dof3Jwxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dof3Jwxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F19C4CEC7;
	Thu, 24 Oct 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780235;
	bh=JjYkPFzVGY3z0JG2dt42Ch02/BkGGMZFVIXcHiGynsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dof3JwxxhZf7d5H5W+w9H9+TVJhm8Dn8lQQ5qRbEztu8MytIds7VQwg3lwoPL34p2
	 9TQWAndiETX3rjhrapokYSEvSIJFrpd5vc0FevGFFBowxRaFHj/EkwfLVwNCb99tqI
	 iv1Hmtlejuj+ATsaPCnOmhdqWd9usAfaI1UKrMcM0nb2IAkpBspTllmk1BOplDIx4l
	 vbuXfQ8Cc/5u75dfwPQ7B7RxAiddztBbnxGDD0AKne+fzhssMmIrdBgxDmdiQda82X
	 aKC6rc1vvVTLe7V6pdVcjG1Yk9vFcmrQPIXBhnSgJenMsfVE2kNzRM/1N0HfyKKhSZ
	 KsSegzfELRc0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE083380DBDC;
	Thu, 24 Oct 2024 14:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] network: allow status' and notifications on eutran
 networks
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172978024224.2259464.2419489708633664881.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 14:30:42 +0000
References: <20241018105147.1382861-1-sean@geanix.com>
In-Reply-To: <20241018105147.1382861-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 18 Oct 2024 12:51:44 +0200 you wrote:
> SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
> 6 registered for "SMS only", home network (applicable only when E-UTRAN)
> 7 registered for "SMS only", roaming (applicable only when <AcT> indicates
> E-UTRAN)
> +COPS supplies the <AcT> = EUTRAN
> ---
> Changes since v1:
>  - removed switch cases in favor of L_IN_SET
> 
> [...]

Here is the summary with links:
  - [v2,1/2] network: allow status' and notifications on eutran networks
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8d1c9dfcb161
  - [v2,2/2] gprs: allow attached updates and status' on eutran networks
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2cf81c33a02b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


