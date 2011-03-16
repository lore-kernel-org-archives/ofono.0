Content-Type: multipart/mixed; boundary="===============2950193918644460425=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: Re: [PATCH] PPP: Optimize write buffer management
Date: Wed, 16 Mar 2011 10:00:33 +0100
Message-ID: <1300266033.1921.24.camel@pporlan-linux>
In-Reply-To: <4D7FBDDE.2010108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2950193918644460425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 2011-03-15 at 14:28 -0500, Denis Kenzior wrote:

> Since we're dealing with MTUs of ~1500, our frames don't really ever
> exceed it.  So 256 byte overhead is probably ok, but might be worth
> checking if making this dynamic buys us anything.

Sounds like a good idea. We can expect to save a hundred of bytes or so
per 4 KB buffer in average: I witnessed overhead in the 100~150 bytes
but indeed it may be consistently lower than that, or higher than 256,
depending on the traffic.

> Also, what do you think of growing the overhead and performing the
> framing again in case our estimate is too low?

That becomes even more necessary if we start with a margin we expect to
bump into.

For the record, I tried the g_slice allocator in ringbuffer.c, and can't
really see a performance gain - or loss -, with the downside that there
is no "try" version, and that an allocation failure will therefore fault
the process. As for why it's so, I suppose that even a few thousand
allocations/deallocations only take a few ms. I'm also starting to think
that there is thread aware code in the glib that is not really needed
inside the ofono machinery. I'll send that patch to the list
nonetheless.

Regards,

-- Patrick


--===============2950193918644460425==--

