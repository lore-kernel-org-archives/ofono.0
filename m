Content-Type: multipart/mixed; boundary="===============1952981923936349245=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] radio settings: add FastDormancy property
Date: Fri, 29 Oct 2010 09:34:14 -0500
Message-ID: <4CCADB66.7010606@gmail.com>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A7DCA1F70@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1952981923936349245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

<snip>

> =

> So I gathered. To me this looks like a wider issue, though. InProgress er=
rors are returned in many other contexts as well, and they are not that wel=
l documented in the API documentation. All this makes it a bit painful to w=
rite a robust oFono client. Probably this could be at least partially recti=
fied by improving the documentation.
> =


Of course, and patches are always welcome.

<snip>

>> Do note that I have had the same argument with myself off and =

>> on for the
>> past two years.  So far this was never raised as an issue.  =

>> If this ever
>> becomes a problem, we can fix it properly using an appropriate idiom.
> =

> If this becomes a problem, it won't necessarily be visible to upstream. M=
ore likely this will be noticed in product maturization phase, and the fixe=
s made to a product specific stable branches might never trickle back to up=
stream.
>

I disagree.  I think upstream will be notified and we will improve the
situation as we progress.  But I do agree it might be too late for that
particular product.  Of course that is the case with all software.

<snip>

>> Honestly, if you expect multiple applications to battle over the
>> FastDormancy property, then it should be modeled differently.  Perhaps
>> with application registration and lifetime tracking over =

>> D-Bus, similar
>> to how agents work.
> =

> Hardly that, FastDormancy is unlikely to be a problem. I was merely curio=
us whether there is a general design rule underneath, or if these things ar=
e decided on a case by case basis. Based on your comments and looking at th=
e code, I guess it's more case by case. I just feel uneasy about an API tha=
t returns transient errors by design, on the (even if informed) assumption =
that it will probably be ok. I also dislike the fact that a generic InProgr=
ess error pretty much forces a client to just retry each operation until it=
 succeeds. If there are problems like this, they are most likely discovered=
 only in the product maturization phase and then it's generally too late to=
 fix the upstream. Too late for that particular product, that is.
> =


One of the biggest principles in oFono is not to perform premature
optimization.  Sure there is a potential issue, but nobody knows whether
it will actually manifest itself outside of malicious code (which we
tell to bugger off) or what the most common manifestation pattern will be.

If / once we know for sure this is a problem, then we can solve it
properly.  So far this approach has been working very nicely for us.
There are countless occasions where taking the wait-and-see approach and
gathering more information allowed us to devise a much better solution
than we would have originally.

So the general rule is: Do the simplest thing that is likely to work.
If it doesn't work, improve it.

> Br,
> =

> 	MikaL

Regards,
-Denis

--===============1952981923936349245==--

