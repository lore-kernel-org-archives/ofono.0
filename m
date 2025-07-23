Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA832EF2B5
	for <ofono@lists.linux.dev>; Wed, 23 Jul 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280988; cv=none; b=jpGtEwCGW5nat54XNyS1nemhv2dKsRKrDH3qKkLP/nQjKR2hHEFm0WsYjA6sHS7QRddhUfcLarRta6y6Vgw1jziYy313NQ6HUput7ytjct+fach5o3wgpCX0Op4gIqqWWmLBJ5xXQQYtpOHtuk+n2jGFfT7MLSbCQukl/t+X5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280988; c=relaxed/simple;
	bh=uI6BWjdBeOXD/4mOyNFv30vPwZYLCOY4BEtVwo9AYkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=adurTBdUdx6hjRTHPdnteZJTgw9nPu/gEYTE+Jo+eLUhL5iT0BKsSu1BXllSyQ53TOE9Z4Cn59xJoOuZKceyPVdzi3qLJWUBokXVCfse0sLHSA75VG66uHs8e3tuVzsBE4SQNjtI3PsGSELe5RUSxXZVgZQhXnsF9Fm99zryQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0rwt56W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0rwt56W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE265C4CEE7;
	Wed, 23 Jul 2025 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753280987;
	bh=uI6BWjdBeOXD/4mOyNFv30vPwZYLCOY4BEtVwo9AYkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0rwt56WovkAX7MDIcSWS8iuoZDvuQaigx+10R8GdraJDKSXxbJywmFIH5lAiJa/O
	 Wxq6ER+ZXGkTZP6qpXlOzAfvsvNAe6SwlwLnnuP8tZSlAANq/gs2+ObSey+ah33XyF
	 44eoNQP0apRvlEqUm24TPzLpUpeWAWU4MdB7+0OscGR5Q2JOaQoTCWENTHqrReoWsN
	 XbwJM3M4WIHqFUdwyeYWJcEjVUih6aopH8xEuaNKEQYMBwFSW7d+idajkf74nnL78f
	 /bbDpwi3MCBbo7Ms3xbH+gJL3vNOH3oJponrOXq+/rb37UDXowzBidkgUcr4tmcN+h
	 B+figpyn4sn+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2C383BF4E;
	Wed, 23 Jul 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: sms: Implement message ack
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175328100601.1586996.296879081725173348.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 14:30:06 +0000
References: <20250723060437.560910-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250723060437.560910-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 23 Jul 2025 09:04:37 +0300 you wrote:
> A "transfer route" message may come with ack_required being set to require
> ack, obey that.
> ---
>  drivers/qmimodem/sms.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/qmimodem/wms.h |  3 +++
>  2 files changed, 47 insertions(+)

Here is the summary with links:
  - qmi: sms: Implement message ack
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ad2de57ce8f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


