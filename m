Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48B4C79
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704631; cv=none; b=Wampqt1eEa6Z0kZvxek4VOSmKFZt1qclsk6RswXaeIYv0LJdNEIuU8fqO+sLTx2P2fBkNaYpIKHEy50wps26T3mw2UiBH+zlQ5fFcptKXTPu/tXlvJDQgDh8lD7E50s5L296assPM6HbEUUcGEjlxDU7dqe033y7VNBl57l+E4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704631; c=relaxed/simple;
	bh=I7imhVr7Azhf2nKuprten81Wighuc+3PxBw/nTK/E20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cIsnzCQMkaqhHrkwbRKoNMyLmBJNXFCjxhnkwBaGTTEqR1Byvzo2RjYM0alIW7g34HteBYZhtfVWDplA7j4N+/62mWqqW++4oLHuTddzugsTxPLL7Yqcw7nE4UjMQy0oPFMrRSTFRWSzy5EnqWddw3YHkQ5eXGp+oi//zt3T5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StptIqpA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StptIqpA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0162C433C7;
	Fri, 23 Feb 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704630;
	bh=I7imhVr7Azhf2nKuprten81Wighuc+3PxBw/nTK/E20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=StptIqpA0sICKWGnGz5zW3EW897qA7vV3Gs24V2gnmkEb/oiZbHJBE3ugU1Q3ZaqO
	 a9WKDcKwOd92E0a/C869QA5Sn4gePP/hOcf6x75k6s0SllnBwXfVRd1eberq5p2ERF
	 A9J8raP1V2par0EQNT6ZOVFAV3jqXFW6Dj4sE0Ubc80+fZPbKGVeX2Xq/v2nQ3xnI3
	 pAYqVNzn+To6FTWhXjndr+hUayS0UimJO8mGZwqCUJAW7tZIsmc19N8bXs3KOTwpz0
	 kmjBaqNEtnwrphA8mStVnE6/bUWM5cxA1xePF44ZujIh+ZMElTuhpXysNTCl3+5azt
	 m05ZOX/Zy6Inw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C12D5D990CB;
	Fri, 23 Feb 2024 16:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qmimodem: Use l_queue instead of GList for notifications
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170870463078.10353.5379905742509803113.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 16:10:30 +0000
References: <20240222235356.32485-1-steve.schrock@getcruise.com>
In-Reply-To: <20240222235356.32485-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 22 Feb 2024 23:53:55 +0000 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 52 ++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 27 deletions(-)

Here is the summary with links:
  - [1/2] qmimodem: Use l_queue instead of GList for notifications
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6254bf0ce2d7
  - [2/2] qmimodem: Use l_queue instead of GList for pending service creation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


