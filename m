Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2911DC985
	for <ofono@lists.linux.dev>; Mon, 24 Mar 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839199; cv=none; b=UnqMrf21Y4bKAwXvJodsvjW+88eIMFosaA/QxRYU28iR7o7lUASTBqGhtrnOHgu2h0N88Ydcvpxb/LNkSERhg6TScfgB7U5UMRx202gOMgn3ys5ovxd3e84TLtRDzbum5aHn7jGiYk8e39jeiYpRhjMU6VIpZcU524qIqC5Ibec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839199; c=relaxed/simple;
	bh=2ej6nKnCnZr8gD8t+ZD0FAOOxqOu+MsxKQB1yLky20Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yo9w3TkJHcIoEMAzSGkikZ/zpe6R4MsfEKdPv/3UgBYgngBJpI9cM9OXFC67YAbXcaVsus0xLwZMXGf2EeUKjmVZrkKt8Qk/qCiEpIKI13luyzuLLdnkRrT6Jupmwbn8jTcZPvrnS3J4YrGaaPddj5zd0tpijH4bYN0BZdVTzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqoekcJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqoekcJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56902C4CEDD;
	Mon, 24 Mar 2025 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742839199;
	bh=2ej6nKnCnZr8gD8t+ZD0FAOOxqOu+MsxKQB1yLky20Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pqoekcJLRJVmKw2vS1qKRdlz00x1KqLON+9Io7SCQqlOQVUBx+ZBgH8R8yQsaBigR
	 yCJ+lvJWZBnYIOzDm1Lw6OBFitKjP9VUABCmjRGgyyHmFLrP8vzkjycWox/dad8CqD
	 A3PVsdos5cuBlY5McJ9K/Jts1baGkatODxXxX8w40fS5oNOU6oFGTZhyHiOzvMe8D0
	 85JMwZnYkHcXadzCTzI86vxscAAJcdcM4KkCwwOUu762Mc4QnYS00UfHv+d+5fC32H
	 dXttG51LtIRhhr46lqyDhxTGjhKon6WziDsOtAeZ2pSWHrC5YyJLV0TSLAbe9cYWYe
	 RPuipszIurC1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE19380664D;
	Mon, 24 Mar 2025 18:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: sms: Fix possible out-of-bounds read
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <174283923555.4117759.9715462394060057262.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 18:00:35 +0000
References: <20250316102642.44301-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250316102642.44301-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 sunweaver@debian.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sun, 16 Mar 2025 12:26:42 +0200 you wrote:
> Fixes: CVE-2024-7537
> ---
>  drivers/qmimodem/sms.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Here is the summary with links:
  - qmi: sms: Fix possible out-of-bounds read
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e6d8d526d507

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


