Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EB1C32E2
	for <ofono@lists.linux.dev>; Mon,  4 Nov 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758823; cv=none; b=LDg/2W06b1PgpL8bbs+nJKWjcS5oRz95dG7oBmas1SVIkAO4cMoSGEyGkN5S1jCpMst6ZjIVOpiv3ozNJlpBtbjkx5yjuep4ph1pzzg2Ni4MFCqLH8PikP8v+Mt4Kgq7XKM+iucCWXTbdQslBFNOw0DziMZr6BSCbPpGah+BjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758823; c=relaxed/simple;
	bh=5x5Id6cu6ncbK953jt6k5IILK0w3YNqEq+94NdxZZBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RSWj4M0BneZrRwLHXjgpFsSZ60bh3VmbYxMTaHd0b+I5f69pIUvOfAuTU3+TeNTB95kphVB3nnv4k2hIXeBjUAmwA7JgqX7t9amxKLOxHfGee1uZF1JyTMXaqD0Veq3KbLRA2X++COyms07auz/M7FgoTFbq9NjzBfh5tLa+Sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5iYYFiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5iYYFiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D67C4CECE;
	Mon,  4 Nov 2024 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730758823;
	bh=5x5Id6cu6ncbK953jt6k5IILK0w3YNqEq+94NdxZZBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5iYYFiJOaLYUBM6pVC+WuuGqwhdn1CNo+5yIhY9FMVyTMzUnOcUMKxOPSXxa3dzt
	 hN++ihcd2lOxzobjrSgmj3Tnqx250zJZsL+/qSN06ZJEGhin+ScjqOzk5f8KJy6HmF
	 dLpf7sBfvaQij/AULd++ft1rTD8Y7JiWJ/lC2nk7GROkXvtZPDk2CK7n6VhjnWBhIf
	 CQlF81S4PWr5Bckf8aN6OcpGoTbMU1Al9nuASOxMxnmxcVzH79itts1JKQX8W1UpaZ
	 r/oZndNg8oNsIvo/zrpWESMqZJtIi5a3EXGJpGvrnQhQ8Np31g05SqNY6poXFdjHNx
	 /Yaj6WQyOVAnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B593809A80;
	Mon,  4 Nov 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/13] qmi: validate TLV length
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173075883201.37255.17067684461259773345.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 22:20:32 +0000
References: <20241031220638.1582166-1-denkenz@gmail.com>
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 31 Oct 2024 17:06:08 -0500 you wrote:
> For qmi_result_get_(u)int[8,16,32], make sure that the length
> corresponds to the size of the basic type prior to performing the
> memcpy.
> ---
>  drivers/qmimodem/qmi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [01/13] qmi: validate TLV length
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ba768fa893e8
  - [02/13] gobi: Clear out service request queue on shutdown
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3c6eda5e3470
  - [03/13] simutil: Return early if file is not found
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b59850d0a4e3
  - [04/13] simfs: Quiet sanitizer runtime error
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ede833c92f54
  - [05/13] radio-settings: quiet sanitizer runtime error
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b697463bc642
  - [06/13] gprs: Default CID range to 1..NUM_CONTEXTS -1
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0fba72b098a1
  - [07/13] qmimodem: Drop call to ofono_gprs_set_cid_range
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=40ecee4aff07
  - [08/13] gobi: Remove support for qmi_wwan_q
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4b854f0736d5
  - [09/13] udevng: Remove non-upstream qmi_wwan_q support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=da340fd02b80
  - [10/13] gobi: Bring down the main interface at startup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=147de7a149f9
  - [11/13] gobi: Support only "usb" Bus values
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f5d36c1c11b9
  - [12/13] gobi: document and validate "interfaceNumber"
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d4df0fb906f9
  - [13/13] qmi: wda: Convert #defines to an enum
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5677ffdbe643

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


