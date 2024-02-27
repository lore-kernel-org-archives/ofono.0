Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A014F992
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071831; cv=none; b=j6ULfkdmVFCrT5NgA6cH3f0NWXq8lQQZi51RpUGbeHwATzNNNXWtQBH7hzVqxkMkVfJ7FxNNbsbioRaDvnWLRXa0Biu39WT1Vrpca1z4hUBeX+7MoB1Ico5UO7Z6bsuiNT8HGaYhxOEobgZXYeELKPE6VoLTerLeDHCWTZQ+Zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071831; c=relaxed/simple;
	bh=uj/T5WP42AOuqNnehs3fQs+dEDeT+A9VztSKi2M4TvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=imJNWew/K9uMIFf9wbuSOhTcnmKE4z60AYMtryiQCgBymuDT+wHq+GVdz1zDXB+IwUe7GBKnDVSClZadVAwlg/DRsfb+Lpkng9A6dPl7V/YcnsrNlEjGDNklFsnZPPcwIh80zGEUz4mU81DpbbrVXSDRcbpv9AsjeRRjdC/EhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiRaFRP1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiRaFRP1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FFC1C43394;
	Tue, 27 Feb 2024 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709071830;
	bh=uj/T5WP42AOuqNnehs3fQs+dEDeT+A9VztSKi2M4TvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uiRaFRP1MIlVExHcN9Z45G300qQSeRWQ2A3KRieIwQzzUMuqCw8GtZAoDsocHpE3+
	 1+ysi37CuGXwG9eSUPxMWYoTn3TBnbXjtZIlAs/CGb5cLVj0tZwae66SqdwkP4zTaJ
	 z0CJciIg5EJH6wymSBc3uRnV6Hpzd4jj12Muza9WYlrnT4xNI9lM/+8yZkotGdNTgB
	 roAEPb17GRnSqkGnlZGYp/sXQS9J52s6/FdqyaS/WyiNFzSWGRcUkkiLb36XVTGPNA
	 Dg+Gg/z4Y9lHzD6ftjBxbuN8SYaFxNUPVAuAE91ti5G2vBg3h1A+BrdQnCLOV6cmZu
	 Ob/QG4mNRWSiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12431D88FB0;
	Tue, 27 Feb 2024 22:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmimodem: QRTR service discovery
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170907183006.24151.4324200142058751835.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 22:10:30 +0000
References: <20240227210143.142603-1-steve.schrock@getcruise.com>
In-Reply-To: <20240227210143.142603-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 27 Feb 2024 21:01:43 +0000 you wrote:
> QRTR service discovery works by sending QRTR_TYPE_NEW_LOOKUP to
> the special socket of type AF_QIPCRTR. Then the services are received
> one-by-one. Soon they will be stored and made available for use by the
> qmi client.
> 
> There was a re-entrancy problem where the qmi_device could be
> destroyed in a callback, but then the code running would still try
> to access that device. This was solved by creating a common macro
> that would do things in the right order so that the qmi_device was
> not accessed again after calling back into the client.
> 
> [...]

Here is the summary with links:
  - qmimodem: QRTR service discovery
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ffebc1ffa6de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


