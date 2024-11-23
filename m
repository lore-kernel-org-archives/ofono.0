Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022C70814
	for <ofono@lists.linux.dev>; Sat, 23 Nov 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379428; cv=none; b=aA096I17cLpZlNFsNoanbptPwKX8C0V9gGyLc5caACGxAfNyf8EyUXT+HfjD8hRvzYTk9zVdZ7ArWFZZYDfyQ7d9++UVQXdWqt4SYbrbkxUnD4JW8OV58leiN3b/tQKnedIu6Fm2ABi3Ogp2/88iUnjuRAYimYUfmbqlWAmIa+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379428; c=relaxed/simple;
	bh=ItN7+TAihZ0RxjRDA4VreCloWfN2nPG9CxoSGSAOGeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ew+/8RsZ+OYLXkAqfN8ogs7392qVXkbz9FAA2SVQmVLWbfKyndTxqz9Xli2UcUAJ9xGGlS8jGOySCj6hNioE3KS5QK3LT7mnD2NkaCCHLmj0mxLoxqXZRifmTZFckwTUzJBZu1fMAhGWq/GoF0CBd8zM2iIpBve9xnsOGBvErao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uur0XHkY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uur0XHkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA1C4CECD;
	Sat, 23 Nov 2024 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732379425;
	bh=ItN7+TAihZ0RxjRDA4VreCloWfN2nPG9CxoSGSAOGeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uur0XHkY170EEnPOGFHBq1/brIWXuhEULQ9fLcOrA7DW9M/V5uNa3VHM4ZjLytj6+
	 kbJjviyc6R/vi1O6+iOBLX8PnyZgVVh8MArc0RWWmUcUThzHnOzppihAYLLUBFvTX2
	 puX1k8iabNHx1WcTtjQMMC1MQDkOITwyA+NgoQaJRtogwJZy+jcq1gEMrAEGrsps8t
	 ecYwwW68Ea6J15RTdFvgOzkO6OB2/qTrrCwoywKnqnp3cdaiVMK2KerTEEqeo+IBmG
	 CAJ6X6r7ZmcwFV7FT9/SLFJBd8FXX7/+tBATLeeMpl7eBmC7bBdRneotu4UDYgzLJU
	 TYhjU3Vn2836A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5633809A06;
	Sat, 23 Nov 2024 16:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [0/4] qmi: implement missing pin functions
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173237943776.3026806.12378740203214991665.git-patchwork-notify@kernel.org>
Date: Sat, 23 Nov 2024 16:30:37 +0000
References: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <1732352735-31944-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sat, 23 Nov 2024 11:05:31 +0200 you wrote:
> This series implements the missing QMI modems SIM pin functions. It also does
> a minor code cleanup.

Here is the summary with links:
  - [1/4] qmi: sim: Implement query_facility_lock(LockedPins property)
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=030c54528088
  - [2/4] qmi: sim: use struct/enum for session type when sending pin
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ffa3216fc91a
  - [3/4] qmi: sim: implement lock(LockPin method)
    (no matching commit)
  - [4/4] qmi: sim: implement change_passwd(ChangePin method)
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


