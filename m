Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5615B10A
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720415; cv=none; b=ZKUHv+6QftxlE4mmSPoLSfzyX/o990o06VYM5FjH5ZaNLw/gjTWPHSU9IUHBzGZxW/6HtTdrGZ6uuldS4ikn3bnOjJjcl7Ca3tgb4dOxJMZPh23scT9f76qJ1FIYFNuTVup+KDchLmOLJ3FyShKHV7mmL+KYVYuO92v3IKZaPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720415; c=relaxed/simple;
	bh=xey06cavSYHuP0vTPmbXI1xfijCEpI/wtkcpccaMG9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NCjff3C1KRfxXDrzxMy1syZ3ws+kEdXDmXYZ+dtmcVzJtoGWLsjXkFEUjv4nWrlTs6Ka/kd7w/qpG7LK885hyxHlgr9uEkX3sTHLWaXYGK6WkFePvVkYztU0upFLf5HIxQit0RTMomNJFss0ICjA0oD8BWcq4gurxBq+5w366Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csX+gZ8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csX+gZ8x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 743E4C4AF07;
	Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720720415;
	bh=xey06cavSYHuP0vTPmbXI1xfijCEpI/wtkcpccaMG9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=csX+gZ8x4Rws67818Z5myGKbHi5zchSSrZhlmGPI5tjJHOv9IA6jZhF0yqljVOwXX
	 id/TrLoHZ7qOrCosb8y7dL/KAZtUxp8FfHQXdA8Lot6IPo0BNxBYWAbKTQzxElqIM8
	 ytXY3SyJ9rUnkjl5L1OnvJgH/GIdbUEki4NBwxPmtw67fNUkyX63hM8AtuYs2eHTfz
	 PgQYHaW3KpovjPcMXbKPnubhhwjPVzwfuqXmsGayHGJH+IEE2v/IPbquVoxDToR7cx
	 BSWAlFS3GQMbMN5cFA4uhiZKRrTaaxG8clnpQt8y5W227LglrEls4WdG55nLXhlFNQ
	 hnoW3tqToILnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69A75C4332C;
	Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/11] udevng: Remove gps from setup_gobi
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172072041542.1229.4361524676850522905.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 17:53:35 +0000
References: <20240711164654.1688558-1-denkenz@gmail.com>
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, steve.schrock@getcruise.com

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 11 Jul 2024 11:46:18 -0500 you wrote:
> From: Steve Schrock <steve.schrock@getcruise.com>
> 
> Even when the gps variable was set, it was not actually used for
> anything.
> ---
>  plugins/udevng.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Here is the summary with links:
  - [v2,01/11] udevng: Remove gps from setup_gobi
    (no matching commit)
  - [v2,02/11] build: Require at least version 0.67 when building with external ELL
    (no matching commit)
  - [v2,03/11] Release 2.9
    (no matching commit)
  - [v2,04/11] gobi: Limit number of premultiplexed contexts to 4
    (no matching commit)
  - [v2,05/11] gobi: Request dedicated WDS services for contexts
    (no matching commit)
  - [v2,06/11] qmi: Enable _auto_ use for some classes
    (no matching commit)
  - [v2,07/11] qmi: gprs-context: Declare qmi_service objects using _auto_
    (no matching commit)
  - [v2,08/11] qmi: Pass two dedicated WDS services to gprs-context
    (no matching commit)
  - [v2,09/11] qmi: gprs-context: Remove parsing of unused TLVs
    (no matching commit)
  - [v2,10/11] qmi: gprs-context: Treat IP family TLV as mandatory
    (no matching commit)
  - [v2,11/11] qmi: gprs-context: Set up WDS service for IPv6
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c09e6bebe703

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


