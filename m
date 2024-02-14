Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122360256
	for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927633; cv=none; b=cQpNq6QFLwj6Q8hqGjqdFcqgMOr0/uHAuYCO12MTTaluBlo0fZwzN/MsEhVE82URrxt/BWnTyKvnF0iazjPPpyci9Rvc/KQlMa0i4gPj6J5SZl702KC6hlGZN65sTPzLDYBCqaPsTDe6UqzacA0rCzvpUA/+anWhmjQdOEWU0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927633; c=relaxed/simple;
	bh=uLrki9eGPGw9+zpj70mSWMS6/6NdBZyjNStFCLb3qag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SY16ca5dzK1h2sT6JJ4WD8eAuN7Q2RSgZcWLJ2JGCrRqajyjb2TJVsB7EiiLUWJFl2g8FSV2HGG9GUtrxTiskwK7NnT32VZ1jxelMj+3mwPrrwELuApkukVZ+9670VKOwWUxGTUGPcMifOVtKtR+r+B+Qjr6LJhNgFvp1ktvb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3achxem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3achxem"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC5FBC43390;
	Wed, 14 Feb 2024 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707927632;
	bh=uLrki9eGPGw9+zpj70mSWMS6/6NdBZyjNStFCLb3qag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G3achxemM9wJzg9uh7BM2mqYevTtda7GvADg47XAiiRJkjjtWfyxjazXVtBQxj3IA
	 8olX6aLZ1r/6yUA5K2nE7rbnw+APYgGocpJUPVajcU/ybw6PT7BB18IxH8mIj1eoMP
	 3AIq6jVc9c4buj277Av+Mtxc/9vx+Rre8Q9q89/t9HV9R+jqzLfDqWb82qib+6WgDL
	 eYjFdTxReEQI0chst0NweTiMFTvuowxP3WlVqCyBLqBFBparN187vPYcrpsmjOt1ZG
	 uBVTKUSu8zneuj5yZJMsGNxPxqJeFHyhKsVeYEjnc+Y7UAXrAnUMzTn2Xhp2R3XgW/
	 NeFfv//6zZ8oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA5F7D8C96A;
	Wed, 14 Feb 2024 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] sim: Drop glib use from sim_efli_format
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170792763275.6252.3270847052424436190.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 16:20:32 +0000
References: <20240213153524.1085649-1-denkenz@gmail.com>
In-Reply-To: <20240213153524.1085649-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 13 Feb 2024 09:35:05 -0600 you wrote:
> Change the return signature to use bool instead of gboolean.
> Also, change g_ascii_isalpha use to l_ascii_isalpha.
> While here, also update array subscripts to follow the coding style,
> item M3
> ---
>  src/sim.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [1/6] sim: Drop glib use from sim_efli_format
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=085637842bf1
  - [2/6] smsutil: Move iso639_2_from_language to util
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f7fc3fb342e7
  - [3/6] sim: Move EFli and EFlp parsers to simutil
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=dcc67adb9a01
  - [4/6] unit: Add unit tests for language list parsers
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=43989a59566a
  - [5/6] common: Convert use of g_ascii* to ell
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ad10d7b0189c
  - [6/6] voicecall: Convert use of g_ascii* to ell
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a1e492c39bae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


