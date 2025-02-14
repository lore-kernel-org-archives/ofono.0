Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92B266EE3
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546405; cv=none; b=TbgesU/qPMDyeOn6V79BEgqBk2D8MoqUB8wbqGIVoxgU2LCQxHl94chIv3tJyPKLeL4g1XYixe18GXCaz5WYMJgzNE6tUsMBwzjrA25jQM73K7+xkNG8QcvwWfek0E23F5ahVbMUqawZF3TGjZQO45RwUGyhbK5cyxBSAEcERjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546405; c=relaxed/simple;
	bh=yG0Mqr/vkr84MIdAGNU+NBzidiW/JZyv0uZahQqpwWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rROqM0TbwqBZpGf/SngH1pyE5kIfCJ/apWW/3Xk47xrWGet31u6pULQPDusRHFYTztkkYdeBXG8MxZtVu0wwgvpVZwuZC7szPVuTNbUYNKgNttccBQMf1tMppQRvN9qjQcKaRJ7h39+lOKK7qXjKuulgVlQ00cSnj+VgNPwjp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WftDUk+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WftDUk+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07FBC4CED1;
	Fri, 14 Feb 2025 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739546404;
	bh=yG0Mqr/vkr84MIdAGNU+NBzidiW/JZyv0uZahQqpwWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WftDUk+yxG0LmNd53NB+p+VrLzGHGJ2R+XNSGW5e1VTM2N2Qdapw86fRxQTS40fxu
	 o/r4DlzcpNor5ISjLK3yADjabu+Rb/L2KnMR6bjTsJlh5cwsMS4/ggWRq31j02+lfc
	 hcN/jXtbMgP0l/JctM0GG6MDqZF7phGzyqBl3MDmYQzYxgbto8m38sVlUXUxdBJCB2
	 es2GDAPfMo8e25yLfC1QLI71mJl3NK4Q77D4td6fOTTwAO4Yx3PcvZwGsm0VJEVqI8
	 ZJTpsOTbnzWED6a21scu2lO4SJo/9mlG6C8Y6JSsUE0zmmvtbad4zjMwZQ6t5kICgG
	 gAKpEIa7fnrHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 732F1380CEE8;
	Fri, 14 Feb 2025 15:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Add T-Mobile MVNO IoT/M2M 'Public/Private' APNs
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173954643401.2007401.7263056454485910056.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 15:20:34 +0000
References: <cover.1739493541.git.gerickson@nuovations.com>
In-Reply-To: <cover.1739493541.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 13 Feb 2025 16:42:18 -0800 you wrote:
> At least in North America / United States, there exist Cellular MVNOs
> (particularly in the IoT / M2M veritical) that neither use mobile
> virtual network operator (MVNO) service provider names (SPNs) nor use
> unique home network identifiers (HNIs) (that is, mobile country code
> (MCC) + mobile network code (MNC) pairs). Instead, they simply use the
> HNI of the parent operator.
> 
> [...]

Here is the summary with links:
  - [1/2] data: Add T-Mobile MVNO IoT/M2M 'Public' APN.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e43d8f1a272e
  - [2/2] data: Add T-Mobile MVNO IoT/M2M 'Private' APN.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5874690e03ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


