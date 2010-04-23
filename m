Content-Type: multipart/mixed; boundary="===============2145336672034173688=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 17:15:21 +0200
Message-ID: <566553110d5cd5487d0791c06ad3f0e5@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2145336672034173688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 23 Apr 2010 16:34:44 +0200, Marcel Holtmann <marcel@holtmann.org>
wrote:
>> The cast-align warning is a can of false positives. First that warning
>> should probably not be enabled. It does nothing on x86, and it's a waste
>> of time with ARM and other pointer-picky platforms.
>
> I don't have an ARM platform easy available to test this, but this can
> be fixed by just memcpy the data structures.

No, that wouldn't make sense.

Memory copying would make sense if we had an unaligned (or possibly
unaligned) byte range that we want to access. In this case, we have a
properly aligned structure but GCC does not know. GCC thinks we are passing
a struct sockaddr_pn (alignment: one byte) as a struct sockaddr (alignment:
two byte).

In this case however, the pointer will be passed to kernel. And the kernel
definitely does not care about alignment. It would be a trivial local DoS
if it did.

In this particular case, removing the packing of sockaddr_pn might just
work. But there are other cases that simply cannot be solved. For instance
casting a sockaddr_storage to a sockaddr_in or sockaddr_in6 exhibits the
same problem. Yet it has to be valid, by design of sockaddr_storage.

>> Most importantly, using -Werror _by_default_ is a _damn_idiotic_ idea.
>> Been there, done that. One cannot know what weird warning any given
>> compiler or version thereof will ever return. And then I don't need
>> to mention "bugs" in header files from underlying components. Even
changing GCC
> optimization
>> levels can yield different conflicting warnings. That's known to happen
> for
>> uninitialized values detection, which relies on optimization-dependent
> code
>> analysis as an example.
>
> The rant about -Werror doesn't help. We are using it to catch nasty
> constructs that might fail on any given platform. We have used -Werror
> inside BlueZ and ConnMan for a long time now. Yes, sometimes new GCC
> warnings come up and we fix that, but it was always good to have these.

No it is not. I gave the counter examples multiple times. I don't need to
quote them again.

> And yes, it is true that you need to use -O2 to enable a bunch of these
> warnings.

Yet another proof that it is a bad idea. You are self-contradictory.

> So in conclusion, the -Werror stays and we need to fix the code to
> compile cleanly on any given platform. It is possible, so lets get this
> done. Feel free to post the warnings on the mailing list and I am more
> than happy to look into it.

Your problem. If you don't want oFono to compile, I mean.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============2145336672034173688==--

