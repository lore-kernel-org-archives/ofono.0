Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B68120C
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534830; cv=none; b=rnNiSNalwYZRp+DYTN0bMl49Lb9OcnVQrUdtnvj2gpyvbMopx3ezy/s3dWrarJdENVNrn6L5Jct9eP0v5jGFFtYoUW/veKdVMMw05XyqzZfopfZHPRIgu3SXKpiOsqPTqajNAvWrONgX1fOILi4NzssUp0YbxOArtPC/NCXhcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534830; c=relaxed/simple;
	bh=nYSXdC64/34r7MReywj2r1FYLzkh4TNE0cjjq7sOzrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XA9oyCeWkEOKRCHwq8MlUD/Ce25A+kZ/Jq32avBK1QYGSCl+RIthfcQVLG8vc0kjWLmmDeQJ2Hja0OTzwya72B+joALlhwBL4jKmOUu9r1gVIp6DvXij5Q1V86u8FAq24sD7Pu3NKR5tlczzh4KqEzJx42DMVlnaa0+XCnhfHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYCXCZHw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYCXCZHw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E0DAC433F1;
	Wed, 21 Feb 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708534829;
	bh=nYSXdC64/34r7MReywj2r1FYLzkh4TNE0cjjq7sOzrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JYCXCZHwv1eOgYeacSUQiAKnwfqBIJeKxWIJZpXM3cNZUg6Eq/uAa/vfZneS+3q62
	 wrUguAqpqkw3TaxGUdJqOb4h08PCL1YdMwxkU5tyHFqXbmuATdzHLwz8o/ZjSbjr/Q
	 XUd6cynamMvz55eiZcJbCp9r4Bk3uJDadeKbxpU21aE0WYDO8w1bo0a5x9MuBtNCpy
	 2n/egwmFMKWsMSY1+YY7ATp4KL+XPSMb4Im+Bw7xFYZinKdDY/46SIpkHjmGhxqHAd
	 qHBqITJO0Kp7lZWb77vJyI4YgEdx7vNF+962j856gTV2mq4iOX7+fJKd3hLh3AIyLu
	 AvGMI9LXPmkrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 707CDC00446;
	Wed, 21 Feb 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/7] qmi: Remove qmi_device_sync
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170853482945.26428.868425492408098435.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 17:00:29 +0000
References: <20240221162335.1258315-1-denkenz@gmail.com>
In-Reply-To: <20240221162335.1258315-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 21 Feb 2024 10:23:14 -0600 you wrote:
> This is an implementation detail of the QMUX/CTL interface.  Since the
> only caller always invokes SYNC after discovery if supported, simplify
> the SYNC operation to be part of the discovery procedure and remove the
> relevant APIs from qmi_device.
> ---
>  drivers/qmimodem/qmi.c | 89 +++++++++++++++++-------------------------
>  drivers/qmimodem/qmi.h |  5 ---
>  plugins/gobi.c         | 10 ++---
>  3 files changed, 39 insertions(+), 65 deletions(-)

Here is the summary with links:
  - [v2,1/7] qmi: Remove qmi_device_sync
    (no matching commit)
  - [v2,2/7] qmi: Introduce qmi_device_new_qmux
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7cf914bdd495
  - [v2,3/7] qmi: Remove qmi_device_set_close_on_unref
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=63420ccbefb4
  - [v2,4/7] qmi: Move control_{major|minor} to qmux sublcass
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=0382434d8879
  - [v2,5/7] qmi: Move version_str to qmux subclass
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6cb6953abbe3
  - [v2,6/7] qmi: Introduce shutdown operation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=34d0183a9ff7
  - [v2,7/7] gobi: Fail if device could not be created
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2cfc037e723b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


