Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29F1804A
	for <ofono@lists.linux.dev>; Wed, 11 Sep 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016430; cv=none; b=Kz3QEvprMRH4iGEu/NFthLg8U/uWYEwxDRvFt8v7QOFp7nLxJtorcypAPqCPmSTfGf5x6kHC+AGCWWV5sh99UqA0rm8XxEzO4TsOZY6DfTC64ACAKR/lqoDx72jDCJtxlD4Cwa2aEnpsESCz4rpJ0XrGa9L0RV+jtXr8LLwLhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016430; c=relaxed/simple;
	bh=2mOAALV8OPPp8j1PZOfDkQDYdtoFUxujfLe4fMc6Pgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RO0LnQ4A/+HGrBLH8H7m5u502QYAJUy3ibYKKzoNeGiJQafEoSODNyzrM2PugCtBocDpPld5n+WxBrDo6Uaev0jB9nEKmEX86o/8cGm3fXaLUHT/Ow18afnDDEx342tuiTlEJG6nhIjIZHOQND/nNxa+b2/P4yfwTmImuv3V8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/qu5vO5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/qu5vO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E044C4CED5;
	Wed, 11 Sep 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726016430;
	bh=2mOAALV8OPPp8j1PZOfDkQDYdtoFUxujfLe4fMc6Pgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/qu5vO5QdnhcYhUhj1tUTlnKZqX0WsrkhN5nwAKBjolX5LSaU8ZjfAdG8S6COLqD
	 TlATQxDZ6RjHK/x5K5w+IMzm4kgzKF3DqJJ8wfXzWFh0x/BknC5nBYwEVgFIY9jLdb
	 kAqC2w3F3/Pw/S6sQMFGiKK4VVRy+J1V2e8EZ1ao0raZDgZJIfDcEGVI2kuL2aJK/f
	 dMTrpWDVnExPBiAlGZyrd35m6PvS9x+kJqzZRM+3HjAtdC82pnRLUdkDDlYF0wXvtw
	 Gcrodh99YlYjSw2xOTBhkSrrENkHsKBLIC/YqszBlW0j2biSGjQnvVO0FlJ0Ang0gV
	 S35FXvpqQwHDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E903822FA4;
	Wed, 11 Sep 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] add support for Quectel EG916Q-GL
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172601643126.449226.6463578070457547330.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 01:00:31 +0000
References: <20240910072210.2618396-1-benjamin@geanix.com>
In-Reply-To: <20240910072210.2618396-1-benjamin@geanix.com>
To: Benjamin B. Frost <benjamin@geanix.com>
Cc: ofono@lists.linux.dev, sean@geanix.com, martin@geanix.com,
 denkenz@gmail.com

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 10 Sep 2024 09:22:07 +0200 you wrote:
> The aim for this patchset is to add support for quectel EG916Q-GL
> using the usb serial port.
> 
> Benjamin B. Frost (3):
>   udevng: support for EG916Q-GL using option driver.
>   quectel: support for EG916Q-GL
>   atmodem: Support for Quectel EG916Q-GL modem
> 
> [...]

Here is the summary with links:
  - [1/3] udevng: support for EG916Q-GL using option driver.
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ef867dce8f01
  - [2/3] quectel: support for EG916Q-GL
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e9af32a90215
  - [3/3] atmodem: Support for Quectel EG916Q-GL modem
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=87b12433cbca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


