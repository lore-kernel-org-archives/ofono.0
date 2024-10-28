Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E91E48A
	for <ofono@lists.linux.dev>; Mon, 28 Oct 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140229; cv=none; b=VNQcmtm+fLiZLjKx3oo7yRTmJTjOFUf5o7ecWUPx72GwpmUe0o/mKaMC67KcFxNKIb5lwoXHv9XXzm5P3DlOBsk5t69i8ao2y6IW22eiViTsyhpE/PllRtrFN7SxnjBtMrKrR0ACVw9Aox3ZUs7eHg4VBPTVBkkqHswtcB6WFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140229; c=relaxed/simple;
	bh=h0c7uok8fhCnk9zjQNE1FMurvk+19+L+z7EpLx6WX/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ATcJN5iZh6+bikiM+IT6WSuk27GjMcScFu0Xrx3L2mrlFuHMHRLa1CzD6ccWNuZybkpKex+sn6Sk+YyPv7jDZyE6N2cwqR2W9TP53V4y+DZEwE9IQKHXjc5h6k1NMeylmj43rfUuUAfAfGegtR+7F88hCBUOTiXm3IPGDFsSL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca3Ole8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca3Ole8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F76C4CEC7;
	Mon, 28 Oct 2024 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730140227;
	bh=h0c7uok8fhCnk9zjQNE1FMurvk+19+L+z7EpLx6WX/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ca3Ole8maSk54LCKEsZdaAoNZDtyHVLVJv8qhhuK3M9jgxpRi6wnSDPSynx2kKQfn
	 mPgFpdI0oco5a+TfGSl0S9lMRxhNxOn9MnR/L+7yvL2D+jhoBPcKe43p6RcARjhZNB
	 OuSuL2+uL4iL1qy1SPtHt/J03kEjlnU6K6r2v2FXM/pX2+k475MY3Uxlo6ny8K8QEF
	 Vp9XWlpKc+Os/5nckixJweovcLdi4oBnWnxJsBun/Y0k90uTTN/w/Tf2O74Pv0AP/o
	 u6ML/1tlX/mkh7r8VhJqzQGRr0pf+3GuO3Q3SlutLn7sygV/yeUMeCGfnmZrtMp2Mh
	 B/tuDpjvINf4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C80380AC1C;
	Mon, 28 Oct 2024 18:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] udevng: restore support for phonet modems
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173014023498.140589.14718029151284480812.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 18:30:34 +0000
References: <20241026115324.211317-1-absicsz@gmail.com>
In-Reply-To: <20241026115324.211317-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sat, 26 Oct 2024 13:53:11 +0200 you wrote:
> Commit 296347f8a4f1 ("udevng: Detect embedded qmi QRTR modems") introduced
> a constraint that only rmnet_* modems are valid "net" subsystem devices, thus
> breaking phonet modems, which are located in that subsystem as well.
> 
>     P: /devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/ssi-protocol/net/phonet0
>     E: DEVPATH=/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/ssi-protocol/net/phonet0
>     E: INTERFACE=phonet0
>     E: OFONO_DRIVER=n900
>     E: OFONO_ISI_ADDRESS=108
>     E: SUBSYSTEM=net
> 
> [...]

Here is the summary with links:
  - udevng: restore support for phonet modems
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=116b6dfef7a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


