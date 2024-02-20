Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669827690A
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443028; cv=none; b=LGihztw8okgR4KCj9JCJGTU2y4hqU20jCST2wMx4UlfyMb6LSpT2tx1+fKOgO6yOTmki1shRLe5E2W1tfi682BtyJFvq8hVVFU6dydfYYkct+ocI7eCX9BQaW2imMaIjmrVeCcS+e7EBMNXjz2zuwkVdGbhm4ffLZSnXk7PdcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443028; c=relaxed/simple;
	bh=FMqk4qLaZs3wKQADNOYeyBp36Y3MYJJ00RU2cBTBH8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJ8a/BmihL3gn3wIg5r1otyAZMB7CNnP7ha3XMryukJ8UTXY/G/dSfaz9Qm7ImObissY+50Gf5k95Y6xrtpU00lV1W2q0/g26CaV1lGMQlQP2MsE8vnudsgZNfHQCMdkil+lC31UR6uDx2gSFUlG8Y0pW93uCXCzGGvt0WdqHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/AOn3uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/AOn3uz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46A8FC43399;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443028;
	bh=FMqk4qLaZs3wKQADNOYeyBp36Y3MYJJ00RU2cBTBH8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s/AOn3uz7Kwqi1oS7SRfVRsuudvsJhL1wcq0OvzULXe3HnEKOxKVrpLmvzBNA4gq3
	 tajBPuoG0deg1T5nExPCw0LkhFB1c+KwSScsv39VsSA9NNbnrDPoBRsWQVz0NV1o3q
	 ElFOhnrYSwVxRm7um4OQfydTvbCcMZThx82MZkNIHnB+bDQyaA6dGR83r2A20UYPGr
	 UcaPi4yTJWHL1MM7ZTgHfrd6Ooo/a5oR+Gvl2knJMVq3pvowz2JqGb5VwwQorRFFnf
	 1m/KTEoi/tuaRAyzXgAoY5wv7ZaYnx1KKs+Lin4tZ+FRszWd6dWAK4IuxKK8lMzsEC
	 XgPna3prhFj9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2ACF0D84BC4;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qmimodem: Support 16-bit service types
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170844302817.30347.14255964067423553797.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 15:30:28 +0000
References: <20240217003032.76366-1-steve.schrock@getcruise.com>
In-Reply-To: <20240217003032.76366-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sat, 17 Feb 2024 00:30:31 +0000 you wrote:
> Prepare for QRTR which has service types greater than 255.
> ---
>  drivers/qmimodem/qmi.c | 8 ++++----
>  drivers/qmimodem/qmi.h | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [1/2] qmimodem: Support 16-bit service types
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6984ddd42694
  - [2/2] qmimodem: Fix checkpatch.pl warnings and errors
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=00444ee7c8bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


