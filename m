Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E481E0492
	for <ofono@lists.linux.dev>; Tue,  7 Jan 2025 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268630; cv=none; b=UhYJKlrwE1/Jt9XUaLKsoii98EBHxJGrWhW94aQx68UINUlFHgmZbKeYQrcB/jHItwrZnokqKznGXRovFxUGmBk9zAKU2ghgMW7EMoRGM03jnIM6M8wW9oBBvgmXIMw0gMBdZl+pixWXNUyensFPTT96y1U98cfdYnWUZLQyLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268630; c=relaxed/simple;
	bh=08fTr8gstlvD1dDjYFy5AaE16Biv0VtstDQriR1heeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XvOwCxF1ynQRkv+4dpxz0tQ0A5713E94+DeqCnf+UEOuK1iPnZT47CVsH7qV9m+C7jpIicGUAhIULLnOYjqa6R7RJEG2lsK2xOZlawtsXPf6ffadTZRWmG9KLmfqd9kZ5vGNh00K87jpJK9A5T5MS0BR1PdASl6gthiNHBhVv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWbOzeMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWbOzeMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D476C4CED6;
	Tue,  7 Jan 2025 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268629;
	bh=08fTr8gstlvD1dDjYFy5AaE16Biv0VtstDQriR1heeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IWbOzeMSX8mubCWtarSM0us5Bohggo7EdaG7jS2KDuHYHcmIYa4kQ0bo47Rzl7poS
	 XPCDNfvW7DUMPBMbXUksyAxT9yohUj5fluRLC3mSYDRHjP5wR7BmUcXz/cGZ5G7MAu
	 jd7RgXs6+LIyUkKTf9RCD/XGrH9segLWgiUo2FS4smHETsQlHJAHfq/rZdWNA34v7J
	 8ZFxrK1M3WdzN9hskky6uzM5rVlZUmjPpWwmqotoxQ6NXIis4eCUY5NuFAQL9aNd8L
	 lwrfzZPon4yhAgDke3PPsTV72/x79RhiNvIqRS7bELt+CErnHIolPSa5TuYbOPOfAv
	 ibhwXSuLHcz7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C37380A97E;
	Tue,  7 Jan 2025 16:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] handsfree-audio: use correct signature for GetCards
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173626865070.30633.5560175877207481563.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 16:50:50 +0000
References: <20250106215446.14890-1-absicsz@gmail.com>
In-Reply-To: <20250106215446.14890-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  6 Jan 2025 23:53:09 +0200 you wrote:
> Match the signature for GetCards to the structure of the dbus container
> as found in the am_get_cards function, as well as in the documentation
> for the handsfree api.
> ---
>  src/handsfree-audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - handsfree-audio: use correct signature for GetCards
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8fec91a55512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


