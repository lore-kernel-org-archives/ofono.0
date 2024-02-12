Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0E1841
	for <ofono@lists.linux.dev>; Mon, 12 Feb 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707707424; cv=none; b=hdVb/BoU0MKQHBzUgP8z0dUOu9Dgm7d6vwccPq15lnyYtfJFtOuPCFs2Z12J8cRu4Xu+5BVkkUJ/HWU7Cx8j5/YBy7gY1LzqIgC/Nu/h2SazkvF6VwpfRC34VJmBEt3SimawVosRMpVpvVHWUkzcms0+S3kWlBUVo1dIyCWLKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707707424; c=relaxed/simple;
	bh=pcAyj7LyEqGAQqd0Kt7+5eWTGPIcz1uk407xoeHu4Mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUY2zp0UZdwoc9tkyd1vZelhfnN9noSwHf5+rmy6OBO5gez3rEC1nZYZjVBQFz6zrHzzvEwHoAoFtAYm70cvKzu57WdpvVmts9MWFjK9pj3QHhe57G4kmVyBt5+CSO11lphqteirBI5rJ2SFxFfcr8LucaNJVYL9DtYcuomCZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzYhbwAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzYhbwAa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40D1FC433F1;
	Mon, 12 Feb 2024 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707707424;
	bh=pcAyj7LyEqGAQqd0Kt7+5eWTGPIcz1uk407xoeHu4Mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzYhbwAaxR0i7t3hPxuFglWAWkOB411m9GKSes+Sls9uGgSMFZU0Ns2441Atmvlgm
	 QscVE/Aa9A0ReZG4JNrh4MMqb+cZ6V1K23c/u/0MyW+QWfXUk3i9Y+/0Hg0BNfKuaz
	 BA6069MKTmy0ljTi3I4X3rvFbA37PVSCgodhcZzYc47XjRkY1VFx/zd8+TqLmFky3e
	 ITo3M6roJqGzdwbU39oLTK3mifWG2BgbD/RDDsIygojDB8dJXji+42tnFxaivsTGBR
	 AGwaLFRKAtFMzRkVIb5+fDfZ6NcZtNdtzVIfnw7Nz5cAAgZOLd2UUwUhUID7Ur9sSh
	 MemA2BCVvK7kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2355EC41677;
	Mon, 12 Feb 2024 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: Don't use f-string syntax
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170770742414.25185.5887680808197516798.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 03:10:24 +0000
References: <20240209231001.1041957-1-denkenz@gmail.com>
In-Reply-To: <20240209231001.1041957-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  9 Feb 2024 17:09:48 -0600 you wrote:
> Some older Python 3.x versions do not support this syntax.
> provisiontool only had a single instance of this syntax use and it is
> easy enough to get rid of it.  This makes provisiontool compatible with
> older Python3 versions.
> ---
>  tools/provisiontool | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - tools: Don't use f-string syntax
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a51b6a96c8f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


