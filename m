Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278956ABA
	for <ofono@lists.linux.dev>; Tue,  6 Feb 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238830; cv=none; b=K7tJWaPWBoFqSGE5FJjdu+0TZ8xxtYzrE5Ilci0SLSb4Ykv4eOjnStrME6iQASjM4oBtnNaXNK3IGHCqVkcDG9+cAkgv4zbuZdAQo4qs254xSvZ22pRF0UJkT9sn0X6otuA+utMabAQPyEZ7cBzW389nt8UrT2KY5WD1217KO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238830; c=relaxed/simple;
	bh=DPk2IBlwDuUF40Xt7/vL7KVMUQ3si/5r/w79kOayFCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTIpXIjXddyPx6fDhft6jiksLyMxnBekg1MSTWnMaeP3SPct6NmdLWBNC0922aUQVY4i2Jeo8a4pTBn8eOU2ICU6pdA+IdRZalwXBd/Xbmetd3LAu3+w5RAPvKzFzpK6Rki6Qag1NsKX93XSR5sAVyRRcjCo/XzCQPeMAD11HqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBR1dsz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBR1dsz8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0848C43390;
	Tue,  6 Feb 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707238829;
	bh=DPk2IBlwDuUF40Xt7/vL7KVMUQ3si/5r/w79kOayFCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBR1dsz8GspdQtzFLE+Bm71TIl+u7ExrSaRJ8xWMugrxDHM+OYwTduI5DlKTlvvxw
	 rW9dLJAOTRiFLtJxY2H9TbphRTsDl9sp2cq4D7wtg0dos/Se65jF8J8rRn9BvqBF4H
	 10K+U9a5oA2NOYXtmaTjT+KNkQy52csJPR5HVVAPMFmiZWNTvyOsyEIjnDX8OWW8Bg
	 FmnEyWlZxxX6TnNlpri1V0JcgOpSy5ktqPufpyiV72lVYZ741Dx187ry66EiIJ/3r0
	 b+XOW/vodIxGd5C1WaYWY7rHcgeY5MpuxxGlSPgLCQgj5RK6kTX6nf54wZhO3F8dGW
	 nj7tq1QljqR6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AE62D8C97D;
	Tue,  6 Feb 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] build: Drop GLib 2.60 requirements
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170723882956.19015.7333030902590522202.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 17:00:29 +0000
References: <20240206162453.1024228-1-denkenz@gmail.com>
In-Reply-To: <20240206162453.1024228-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  6 Feb 2024 10:24:34 -0600 you wrote:
> Since g_utf8_validate_len is no longer used, requiring GLib 2.60 is no
> longer needed.  Drop back to the original 2.32 requirement.
> ---
>  configure.ac | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - build: Drop GLib 2.60 requirements
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d70bcc06096a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


