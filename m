Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECC43AB0
	for <ofono@lists.linux.dev>; Tue, 13 Aug 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578038; cv=none; b=YP8xpfCwgURDZcbzLQ03AEHxl3eD5Pd4RWtvp1/5m8Ftd1Lepl8OGbnJWYDziZOMLYMYpz++fzrTJlg16nYi07QcIhlLtv6dnL7KMLisHgsvUqiFEmZ9KVg0V8LCEcqiMHU0qOk2DndibIw0gXkhd71jZBCj9vgcW+j5xtrd4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578038; c=relaxed/simple;
	bh=2Mu8DPz8EWFjhQMh17AHY0Yu7Jze8mhT4z2tQsDMoro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhU5SdqMEEEKEpvS1DOS6kwPAhpgnTUfr9q88ccuHPiXClkOArz54TfxeIVHXFxhpGSNNDtJt2cbbERFRuTqNr0TjvH1aGXz1d7zZAt14hD7EGbVGV3bFHKIFSu/076LT0OJ76s9FNNlfoV2xUT0f/2Vchu0kQsTK6jsHcZz3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uegs2CKE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uegs2CKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8EDC32782;
	Tue, 13 Aug 2024 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723578037;
	bh=2Mu8DPz8EWFjhQMh17AHY0Yu7Jze8mhT4z2tQsDMoro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uegs2CKE7JYg7Mcq8pvlrC/tPVtz8uu4gDowt3L2p5i3K/toevvVtmZLjPgYF38TS
	 UG59SHeyGLpg232+DrOT4hbgXm++xbl+lVxd4oQB444fxRZKCfnIA7MCizf0i+71B6
	 1pdIwdYSVL3qRxj08Q4CYzgpZK4NBNrfMiLwZLEtOjMtL1qHXotGuOu9jxlGzry+Fq
	 twaDzk+3ScS8kRNeaUHXRCk3Kz4ZECpIHjmA9a1agVRqFgwcSA2/DvSTm/f3B2dv17
	 A3U/BCftraaOZ85QBm83g/hoc3M8p2lyI08bH+Q3Do7dAyp15duBklvSbNsvD8SAU2
	 LNLVKxuEF1TMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF7423823327;
	Tue, 13 Aug 2024 19:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] smsutil: check that user data length fits in internal
 buffer
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172357803652.1736044.13589834836772584626.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 19:40:36 +0000
References: <20240812085134.74064-1-j.lemetayer@kerlink.fr>
In-Reply-To: <20240812085134.74064-1-j.lemetayer@kerlink.fr>
To: Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 12 Aug 2024 10:51:34 +0200 you wrote:
> This addresses CVE-2023-2794.
> ---
>  src/smsutil.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v2] smsutil: check that user data length fits in internal buffer
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5209fd65ff41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


