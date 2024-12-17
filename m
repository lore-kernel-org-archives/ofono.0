Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2612C80C
	for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434063; cv=none; b=SrH1PSCkr4g4U8JCKAH288Z1IuCg7xOlB2XFkH8+xoEEUwIcga8GNElIgym04/c3AZLDoN10nzLsFLeabqdqvo8kJO54j4tkDx4HpCK0aHg3ePh2eCIgiArdbSd0hJCechOqrZzGEOOWqNzwGk2NcXzwAFU8sQH6sf9Y9eyz1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434063; c=relaxed/simple;
	bh=+l3B/4LwkFZulKJGFABgsjPr0ABZrS+UDgUwXSg1nDA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=VIQJSv2SmziUHChhq5Slb62anU0UwUpbxO8jo2ERBz6YPgB5mxbXrSAYmwhaQhmeGciEJcdRw/cpQFwVZQMt498cd9365Ux1u1NB9j2CgO7ImtpK/qKb9a23qSsPhB14biTLqipsmdyVVaMvSnFlGVHQVO9CPM6WrY9ECDBCqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=d+3F+MgG; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="d+3F+MgG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=To:Cc:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+l3B/4LwkFZulKJGFABgsjPr0ABZrS+UDgUwXSg1nDA=; b=d+3F+MgGv0BsfYWKPb2Ocivrjz
	II9wWYCrhU74xhc64hMtv/UzeqPGNMvuZwKtlqii4cBEqfO7d65T7LO+16O+XRo299xKzVqiEmpGF
	fDG3i6fpgBEz69ykLot29HUeEQ3BFfRk2ZlERgv8n+Si9y+s0zU37zJtNWmlxuf2f04ERrBSkfBFc
	Zu2Dgc0oDYx7HI5IsGnskt3vHty1r0Umv5Nzc9TPNUhIzphA67VXOPVxU22O+aTbeWnMLt8IDaZdY
	LS86fNGbQ/RtJupLYSk6TwQ5O66kiKICbq6CR3BCX2i4/CabMeO//bTOvcaHFpHuXxTOluF929AZN
	BUdyr5Bw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sean@geanix.com>)
	id 1tNVGQ-000OJ2-2n;
	Tue, 17 Dec 2024 11:57:18 +0100
Received: from [2a06:4004:10df:0:143a:685d:95a5:d71d] (helo=smtpclient.apple)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tNVGQ-0006b9-1w;
	Tue, 17 Dec 2024 11:57:18 +0100
From: Sean Nyekjaer <sean@geanix.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Forbidden Public Land Mobile Network (FPLMN)
Message-Id: <0B16BA07-4A2C-4FF7-AB06-3D670BB40A91@geanix.com>
Date: Tue, 17 Dec 2024 11:57:07 +0100
Cc: ofono@lists.linux.dev,
 =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 1.0.7/27489/Mon Dec 16 10:39:01 2024)

Hi Denis,

One of our IoT providers recommends us to clear the FPLMN list.
We have been running out-of-tree patches, that clears the list when we =
go offline.

We would like to share it, other IoT providers might have the same =
challenges.
Could it be a boolean set via dbus to the SimManager?

=
https://help.onomondo.com/en/articles/233768-how-to-clear-the-fplmn-list-o=
n-the-sim

Br,
/Sean=
