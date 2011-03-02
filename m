Content-Type: multipart/mixed; boundary="===============2891988205107490631=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] PPP: Optimize write buffer management
Date: Wed, 02 Mar 2011 09:28:09 -0600
Message-ID: <4D6E6209.6030908@gmail.com>
In-Reply-To: <1299055349.1964.25.camel@pporlan-linux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2891988205107490631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

>> Is there a particular reason why you chose to use a ring buffer of ring
>> buffers? A simple GQueue might be much easier to understand.  If you are
>> worried about 'infinite queuing' then a simple counter might help to
>> alleviate that.
> =

> Well, this implementation opens the door to further optimizations, such
> as reusing cells (buffers) to avoid frequent allocation/deallocation.
> =


I think I know where you're going with this, but I'm unconvinced the
circular buffer of buffers is buying you anything over the much simpler
to understand queue of buffers approach.

> =

>> You change BUFFER_SIZE from 2048 to 4096 and remove the multiplication
>> here.  It is a good idea to send these types of changes in a separate
>> patch for two reasons:
>> 	- Logically they should be separate
>> 	- It is much easier to review for correctness outside the context of a
>> large patch
> =

> Got it. By the way, why is it written this way? Is it to stress that we
> want space for two frames?
>

You'd have to ask Marcel, but yes I think this was the intent.

>> So I think we have to be a bit careful here.  HDLC framing can in theory
>> (if you're maximally unlucky) result in doubling of the data size once
>> it is framed.  This means that we might have enough space in the current
>> buffer according to this estimate, but still exceed it once the actual
>> framing is performed.  If so, then we have to drop the frame.
>>
>> There are two possibilities:
>> 	- Retry again with a full buffer this time
>> 	- Always pick a buffer if we have less than 2x size available
>>
> =

> Thanks for the insight. Picking a new buffer may be best. That will
> cause more buffer "run away" though, strengthening the case for better
> buffer recycling strategies.
> =


Yes, we definitely want to have some sort of buffer pool management
strategy to share a pool of buffers between different entities (e.g.
GAtMux, GAtServer, GAtHDLC).  Have you looked at g_slice* inside glib
yet?  I think we can take advantage of the fact that most of our ring
buffers are sized at 4k.

Regards,
-Denis

--===============2891988205107490631==--

