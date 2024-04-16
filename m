Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594E1E4BE
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304229; cv=none; b=C5qoVPhsNVJmOVBEDrqWHjCl+PxZVPCu9QqEX5SpZZSuAoquq7o9v6jsNckK79LO7Yy6QDsYajIReQ3TfXHdkt1ZB8krM8cFUX1xFeGm2EfcZG+6orbbsqoD239vvspisfOic6iJxcmRgAi5B+muyHEBPQWRTxa13Z6ECeHidP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304229; c=relaxed/simple;
	bh=YdiA6OorIOfqty5LDja7nYumJNd2sAQr6sqPtlGoJZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q0vFQQtB4a6dWFbbtOumG06RWVUxi2IFpejxI1U0oOp9kiPXTITOqbZPFPg1c60Gq386BvJZWZWBhaphHYk58OsK0V2yjdJ39pjNe5DoOJw9Ty1SsObTqRg4AF7I3JPctGwPso29dmmg7qjK8KqbMW4ZImMgre6a8ZO9sZ/9qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uch3E5N8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uch3E5N8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86975C32781;
	Tue, 16 Apr 2024 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713304228;
	bh=YdiA6OorIOfqty5LDja7nYumJNd2sAQr6sqPtlGoJZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uch3E5N8ygIOHtLuQPTuOC/rWOAd0TS9tuPYzE63Ht1BH6JThXesxgiuAQHztVAAV
	 m5xkrUbTSIdfaj7KH0vmTGzzmzi+EpQyrfSBjxOHqIGiEuoSJwG+u0z/g79EngAQtt
	 mq9VFt7IP3rKhs7qXr6shcx+L36i/vZkeFJTkZWUGv8fHTJkgpqi8VT9ThanEGDnPe
	 mavLkR4QT+4cpO9bpxOzPre26hQv/mlJl5JX4uZmieYUtOMeweB/5x4ZBVVgLu+lXk
	 +MIWE/1EOUiBxZwq2hMPIJUYD9YBT2yh/8cCIsGaEwy5kKBywnCsdnyKO8KQb1Yg0Z
	 JEEUmwYCghnmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74445D4F15E;
	Tue, 16 Apr 2024 21:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/7] qmimodem: wds: Introduce qmi_wds_ip_family enum
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171330422847.13946.15215936110448578564.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 21:50:28 +0000
References: <20240416151448.3359644-1-denkenz@gmail.com>
In-Reply-To: <20240416151448.3359644-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 16 Apr 2024 10:14:28 -0500 you wrote:
> ---
>  drivers/qmimodem/gprs-context.c | 4 ++--
>  drivers/qmimodem/wds.h          | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/7] qmimodem: wds: Introduce qmi_wds_ip_family enum
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=417517a5849e
  - [2/7] qmi: gprs-context: Do not free/alloc unnecessarily
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=844b488b2919
  - [3/7] qmi: gprs-context: Move singleton defines to call site
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=72d9244b091d
  - [4/7] qmi: gprs-context: Convert QMI_WDS_AUTHENTICATION to an enum
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=acb8d77ba97b
  - [5/7] qmi: wds: Convert defines to enums
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ecd6933d5f32
  - [6/7] qmi: gprs-context: Remove single-use structure definition
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=93395363f1cb
  - [7/7] qmi: gprs-context: Request certain TLVs to be included
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


