Content-Type: multipart/mixed; boundary="===============2674765898514349299=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] PPP: Optimize write buffer management
Date: Tue, 15 Mar 2011 14:28:30 -0500
Message-ID: <4D7FBDDE.2010108@gmail.com>
In-Reply-To: <1299599897-2592-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2674765898514349299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 03/08/2011 09:58 AM, Patrick Porlan wrote:
> Extend the write buffer handling in gathdlc.c to minimize stalling and
> process switching during large PPP transfers. The single write buffer
> is replaced by a queue of buffers, allowing for much larger emission
> windows without hugely impacting memory consumption. This reduces the
> time required to send 50 MB between a couple of local PPP interfaces on
> my laptop from ~53s to ~3s.
> ---
>  gatchat/gathdlc.c |   95 ++++++++++++++++++++++++++++++++++++++++-------=
-----
>  1 files changed, 73 insertions(+), 22 deletions(-)
> =


So I was pretty happy with this patch and went ahead and applied it.  I
made a few simple style modifications beforehand though.

<snip>

>  =

> -	if (avail < size)
> -		return FALSE;
> +	if (avail < size + HDLC_OVERHEAD) {
> +

So I'm still a little worried about this part.  In theory the
HDLC_OVERHEAD should have two factors:
	- Our transmit ACCM
	- The size of the frame

Since we're dealing with MTUs of ~1500, our frames don't really ever
exceed it.  So 256 byte overhead is probably ok, but might be worth
checking if making this dynamic buys us anything.

Also, what do you think of growing the overhead and performing the
framing again in case our estimate is too low?

Regards,
-Denis

--===============2674765898514349299==--

