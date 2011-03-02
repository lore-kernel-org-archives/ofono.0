Content-Type: multipart/mixed; boundary="===============4909086537307788379=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: Re: [PATCH] PPP: Optimize write buffer management
Date: Wed, 02 Mar 2011 09:42:29 +0100
Message-ID: <1299055349.1964.25.camel@pporlan-linux>
In-Reply-To: <4D6DBDC2.8000400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4909086537307788379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 2011-03-01 at 21:47 -0600, Denis Kenzior wrote:
> This is a great description, but right after reading it one should
> realize that this patch is better broken down into two.  The first patch
> addressing the ringbuffer performance improvements and the second one
> dealing with PPP/HDLC queuing.  In fact, if there were two patches, then
> ringbuffer changes could go in right away.

Fair enough ; I'll separate the changes.


> Please try to avoid going over 80 characters a line.  Sometimes it is
> unavoidable, but lets try very hard to avoid it.

Understood.


> Is there a particular reason why you chose to use a ring buffer of ring
> buffers? A simple GQueue might be much easier to understand.  If you are
> worried about 'infinite queuing' then a simple counter might help to
> alleviate that.

Well, this implementation opens the door to further optimizations, such
as reusing cells (buffers) to avoid frequent allocation/deallocation.


> You change BUFFER_SIZE from 2048 to 4096 and remove the multiplication
> here.  It is a good idea to send these types of changes in a separate
> patch for two reasons:
> 	- Logically they should be separate
> 	- It is much easier to review for correctness outside the context of a
> large patch

Got it. By the way, why is it written this way? Is it to stress that we
want space for two frames?


> Please watch out for space / tab indentation mixups. =


OK. I'll fix that.


> So I think we have to be a bit careful here.  HDLC framing can in theory
> (if you're maximally unlucky) result in doubling of the data size once
> it is framed.  This means that we might have enough space in the current
> buffer according to this estimate, but still exceed it once the actual
> framing is performed.  If so, then we have to drop the frame.
> =

> There are two possibilities:
> 	- Retry again with a full buffer this time
> 	- Always pick a buffer if we have less than 2x size available
> =


Thanks for the insight. Picking a new buffer may be best. That will
cause more buffer "run away" though, strengthening the case for better
buffer recycling strategies.

Regards,

-- Patrick


--===============4909086537307788379==--

