Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A6248F70
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714789; cv=none; b=i3SbJ6CzNoClKu8+9poiYva5OngsJUt622uT/vWSynGUiS5kOQcUjMtrPxst//undwSkEIqosOxWBh8zug7QSuYT9p3U9lwBGuJfGv1jslsxnFhnpwm7cQlai0soZ/GR9P4QuG6nTdl5W+3wI6XAI5dbqvMAD/m3gaAkVtRPZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714789; c=relaxed/simple;
	bh=21m+7hi/f3caKGp0xnqBsWs+IAT8cwBiKqwV8eZa0MY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZfrgiKM8Oj+i5LKp39yNl1CDp7Kb3+Kk/CMHb+S4oegb0pjJJvtWU2f8/t0fwOPf3EoEwEX+Z7kC7a+8RzH8TFYsAPCYbp4YPK5v54saehHJXpheEAAC4pD7uDd0IK1NnmLVwE2LVwXQ5rPOzGUIZbbB7ysM9axSFkejX7hlMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fepZBH4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fepZBH4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2325EC4CEE7;
	Mon, 28 Jul 2025 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714789;
	bh=21m+7hi/f3caKGp0xnqBsWs+IAT8cwBiKqwV8eZa0MY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fepZBH4eKI4itE856dFhUcUseOBGGzBYG3jDET17E+vIJXjhqboAdSyPstTSlvg9K
	 TyZXLS0DYEDsCdTcY5V/eLZA0YcostFZhwsYGw5udZOHxjjrdYm6d8w2bdSV3CFK89
	 8tGLyWlu01DGaJxqvEOvXPOAool24T8LyKzz2jo03wuqJ37RPzrcqgEDhZDLZdN28r
	 NTin1MwI7fQmFXG8dR+OmPwOMUz7h6U03PMKhszCgq578fm3tvddD+V8r+FM0yyv14
	 rAg7WWYy3rshed4Elup8KghzK7WuUZhMx4tZBLXRQHxZplL2AQiYOxYbUEhkOjD12S
	 NyMVKgkshWTJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5B383BF5F;
	Mon, 28 Jul 2025 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] ofono : enable proper D-Bus connection with PipeWire
 via
 ofono.conf rule for Yocto builds
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175371480575.736343.10408751198800373287.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 15:00:05 +0000
References: <20250728060806.932-1-quic_rbujala@quicinc.com>
In-Reply-To: <20250728060806.932-1-quic_rbujala@quicinc.com>
To: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Cc: ofono@lists.linux.dev, quic_mohamull@quicinc.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 28 Jul 2025 11:38:06 +0530 you wrote:
> - Added configuration rule in ofono.conf to establish
>   correct D-Bus communication with PipeWire, when
>   pipewire running as a systemd service.
> 
> Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
> ---
>  src/ofono.conf | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [v1] ofono : enable proper D-Bus connection with PipeWire via ofono.conf rule for Yocto builds
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1a414d4bf340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


