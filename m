Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EB2367AF
	for <ofono@lists.linux.dev>; Wed,  9 Jul 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083384; cv=none; b=j2DbEkSXNmmz6VMKUIzQfSddnJwHvW6cciIIvb+TpHouhY7aVmeLFL4WRZYPzJZ5KHaNutTIyjdSx3rd8EJhCkOa4YgV/dk+SemKf+MwDdfQNNNrxdbJSqrCoINozVe453644dWb+U2YMraGmjZczqRyJ4jmddXU6A2cipjNje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083384; c=relaxed/simple;
	bh=3R6TdappnLG9obj5tXqcJizzu6VHHeAGR2CCREUBi5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bNgnp4gyr9ks+CQbY9RlCVQXgf/TQpL37AOYEdWhGgdwxVv/5r0FiYvDUuxurz7XSvsSDhtqG0W20eLx0WOavrm0juozcVAUMAEz3xDEKVT2rxYHQTEHPTY2J0tGdBi+zZK1loxGmgLJT1ZufPw3zV59HIF9B73VVUAY7Xq9mK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSH8YFNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSH8YFNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD84AC4CEEF;
	Wed,  9 Jul 2025 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752083382;
	bh=3R6TdappnLG9obj5tXqcJizzu6VHHeAGR2CCREUBi5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uSH8YFNwum2zDE4fnzzbs7b5HGjjh3aYY67FIU427fVUe+llLQSzRiJL8zEsYoa4P
	 H/t3TrLRFZlKQaxfnWvm6ExsZAYaSwTYuD1cYegM7EYeXFk1SbiBQsz5d9fVfwnv03
	 XYz1PY9VcqBxARILcxLcDwmzv1RaOLS9ChOZh4AWVBFb25M32uaqSxk+WNUghy36yi
	 Jvg6DnXTAlBRumSwXWqHq3zZu+ajAuSsuM0a21dQBHtiA4N1C37X42PsH0/DrYWhdk
	 i1M++YAiPcQaBRUYesg/gZMPRSLreALsF1pkiYM7iLEQUrmcg2A2YKca8va5iMsCXn
	 C20Q7GFVztOOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712FD380DBEE;
	Wed,  9 Jul 2025 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Clear forbidden operator list via SimManager
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175208340528.801714.8684602308943877694.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 17:50:05 +0000
References: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
In-Reply-To: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 04 Jul 2025 14:23:12 +0200 you wrote:
> IoT providers allow for enabling and disabling of operators.
> If the modem have detected an forbiddel operator it will block
> connections to that network.
> This will allow controlling software to clear that list.
> (Our IoT provider recommends to clear the list everytime we power off
> the modem).
> 
> [...]

Here is the summary with links:
  - [v3,1/3] simutil: Add forbidden operator list fileid
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3945760adaa7
  - [v3,2/3] sim: Create new dbus method to clear the forbidden network operator list
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=10f683763805
  - [v3,3/3] doc: sim-api document ClearForbiddenNetworkOperators
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=73b7b9dbe3a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


