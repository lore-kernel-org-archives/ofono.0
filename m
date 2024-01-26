Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEF1CF83
	for <ofono@lists.linux.dev>; Fri, 26 Jan 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283626; cv=none; b=e5vMChs0LNjHHH3ZvM3wKMlHICUvDMtpARhGCx3tBeEPPfVMDYasGV/Zdx4xZZX0UXLibDCNfma2ZEK52qwiHEd1+yme3PMGSOVrM8bhTQkFZnJF1V0ABfRtlLQvsf8J4+cxwleUrUqSq52w5DJ9xytw9wtKNxA/nqlh8l4CGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283626; c=relaxed/simple;
	bh=ltZPZ2eM87eFpYHGBLdNti4Y/Ue76PpgqyqLJ6zOxHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZCRnrDzNyTvyg7iO3iCPcyr4K686wKG6Ew1PfbYBOf/8BmHSctjIWulIgqB5V78Z6i6/oCM11aI2QG7JmsP0f0vGQpa6Iruv//CVC1ZWfyBpZHyXjjl8LiwTGt7gL0e+0hv0ApGg/q8jpxhzjYZvYyX0/soqM5OUkpU3Okx2xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMp7Ak0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMp7Ak0i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61B89C43390;
	Fri, 26 Jan 2024 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283625;
	bh=ltZPZ2eM87eFpYHGBLdNti4Y/Ue76PpgqyqLJ6zOxHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QMp7Ak0iiPZSJU6yw7gYyNQNY9O/UAbPrO6fmLZJJMzNbNT6AlB4x/UZHs76iBu8G
	 8tTHRteyjgvl3LSfkkLnov8Ytpv+FygqhQqxiCzI5SRL7RfhZNd4rNYPQHPUN7mNox
	 YD4LlfocWXkMeEm3wKYMG44BkB29g+tQQRoO4x1wUFRriZCnAvyCLTkWZr/IyUQhNw
	 6dfUTBXblD8KEUNZKFQa8CXsrt7aJZ5ogHuWu6f4CKSHRjhI33f7dNpOeaA/M/zPO3
	 RUZnLDN9FMrFH12TCWIDCPebkvZ65laPNXq7MQht81c/1MPnq/b9NLFvNc/Ih8rxwr
	 qJqfEH6RO+HzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4954DD8C961;
	Fri, 26 Jan 2024 15:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] provision: Add MCC/MNC combos and APNs to db
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170628362529.28119.12789014735998383689.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 15:40:25 +0000
References: <20240125224903.4731-1-bfukano@gmail.com>
In-Reply-To: <20240125224903.4731-1-bfukano@gmail.com>
To: Brian Fukano <bfukano@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 25 Jan 2024 14:49:03 -0800 you wrote:
> Add additional MCC/MNC combos and APNs to provisioning db needed by Cruise
> ---
>  provision.json | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2] provision: Add MCC/MNC combos and APNs to db
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4e48785557c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


