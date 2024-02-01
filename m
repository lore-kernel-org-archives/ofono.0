Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DE3F8D6
	for <ofono@lists.linux.dev>; Thu,  1 Feb 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823626; cv=none; b=HsBurXD4FyzF2DE7k/PeISFp6GRVZaX5WCO+V/jTkPblOXszb5oExduQvkXgsuaucT6/ROiQthEQMHLpWHvsOBofvviBLcqkvuOulh5QwBeAAA6jbK9lIrevMjWplyY6cT3l7oipN/b3doJ2X2/q2bXDQpvbpqrhxmwquxhrNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823626; c=relaxed/simple;
	bh=7mDwIqiXIYIHvBaci5gcUehp+WZyW1cQPWspaOflL6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E6r1tlpLU+lm5QjbUFZqsKtlTvOlkezHOI5mZo0yWjEZVxJSK0LUX+QcxwIfJSp+hQxFVYOgr8oIX0phPfDYwr6PlsYkt0QfXaC4Aro82BL96uGzTmEf8dEY1ZI+Om8Z4t7sOrQI7jNgYcbygEO5FLpwHDS+f95EIE/7pw9ZOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmPeNVBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmPeNVBL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60A6BC43394;
	Thu,  1 Feb 2024 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706823626;
	bh=7mDwIqiXIYIHvBaci5gcUehp+WZyW1cQPWspaOflL6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EmPeNVBL6BXXD8dyNRuMhfJ3e94vzDZ7VmdPGupfi3I/28svrUmo6V2Nb821tSxhM
	 R1pvLmPgewqfZciggQsHuewoBfQM+V1JDgI1fzsNAtnoBrjgqg00xU14PlvvMQvfzB
	 cKk0HdUAf3ChpGYWbkFzDk7/J1HNrhrbGR/h8EvuihoihYA+O9EWn6TSvoKp3n1Sy9
	 76JeIh1Fxpl+L2iUTtFAFlZtPedDfAdMApJOcW90w0TJmLy3OZBG0w4zszAHxU/WI1
	 21mc0+jkPN1CM8MZZn5qmQqJPcNPkB/RaCKhxqiXo45IasJHsiph6PwTpSYtpbZQ1p
	 H48gdfdBO2qYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42DABC1614E;
	Thu,  1 Feb 2024 21:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] doc: Prefer l_new instead of g_try*
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170682362626.14986.2479024470502468622.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 21:40:26 +0000
References: <20240201204412.951617-1-denkenz@gmail.com>
In-Reply-To: <20240201204412.951617-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu,  1 Feb 2024 14:43:59 -0600 you wrote:
> Using l_new and g_new* variants for small allocations has been the
> preferred approach for quite some time.  Update the coding style
> document to reflect that.
> ---
>  doc/coding-style.txt | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [1/2] doc: Prefer l_new instead of g_try*
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b461139f484e
  - [2/2] doc: Remove rule 13 in favor of O3
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=feb3e44bb6b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


