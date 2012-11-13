Content-Type: multipart/mixed; boundary="===============8504409237709473099=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Memory corruption when submitting a huge number of SMS
Date: Mon, 12 Nov 2012 18:26:47 -0600
Message-ID: <50A193C7.9090403@gmail.com>
In-Reply-To: <20121112230243.GN31742@xiaoyu.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8504409237709473099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

>> Have you tried making a debug build and seeing if you get slightly
>> better debug information?  Just set CFLAGS to -O0 and --enable-debug
>> when configuring.
>
> not yet. I might need to travel this week so it might take until Wed or F=
ri
> to test this. Is ofono using multiple threads? this somehow sounds like a=
 mismatch
> of first deregister from the glib event loop and then free...
>

No, oFono doesn't use threads.

Regards,
-Denis


--===============8504409237709473099==--

