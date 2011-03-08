Content-Type: multipart/mixed; boundary="===============2334603392960967212=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: Re: [PATCH] PPP: Optimize write buffer management
Date: Tue, 08 Mar 2011 17:08:48 +0100
Message-ID: <1299600528.2528.9.camel@pporlan-linux>
In-Reply-To: <4D6E6209.6030908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2334603392960967212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 2011-03-02 at 09:28 -0600, Denis Kenzior wrote:

> >> Is there a particular reason why you chose to use a ring buffer of ring
> >> buffers? A simple GQueue might be much easier to understand.  If you a=
re
> >> worried about 'infinite queuing' then a simple counter might help to
> >> alleviate that.

I just sent a new version of my patch that does it (forgot to tag it as
v2, sorry).


> >> You change BUFFER_SIZE from 2048 to 4096 and remove the multiplication
> >> here.

Having a constant named BUFFER_SIZE whose value is half a buffer size
did not seem right though. I reinstantated the multiplication, but at
the macro definition level.


> >> So I think we have to be a bit careful here.  HDLC framing can in theo=
ry
> >> (if you're maximally unlucky) result in doubling of the data size once
> >> it is framed.  This means that we might have enough space in the curre=
nt
> >> buffer according to this estimate, but still exceed it once the actual
> >> framing is performed.  If so, then we have to drop the frame.

I checked with random data, and get some frames dropped with a 128
margin, but none with 256. Using a much larger margin might be
detrimental to memory usage, so I chose to leave it like this. We can
address this in a further patch if you wish.


> Yes, we definitely want to have some sort of buffer pool management
> strategy to share a pool of buffers between different entities (e.g.
> GAtMux, GAtServer, GAtHDLC).  Have you looked at g_slice* inside glib
> yet?  I think we can take advantage of the fact that most of our ring
> buffers are sized at 4k.

It looks like this allocator should be used in ringbuffer.c. Let's
discuss that and follow up with another patch.

Regards,

-- Patrick




--===============2334603392960967212==--

