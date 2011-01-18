Content-Type: multipart/mixed; boundary="===============5079651946697436163=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Tue, 18 Jan 2011 09:56:46 -0600
Message-ID: <4D35B83E.8060609@gmail.com>
In-Reply-To: <1295353285.23534.227.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5079651946697436163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

> So actually they aren't both "active" at same time as the logs show but
> personally I don't really care as long as the results are consistent
> regardless which API you use which is not the case at the moment as
> querying through org.ofono.CallForwarding can give you different result
> than using org.ofono.SupplementaryServices.

Ok, so I'm convinced we're not handling this properly.  Based on your
testing and my own independent testing setting the Unconditional CF rule
does indeed 'hide' all other rules so they appear inactive.

So do you care to come up with a patch fixing this?  Briefly thinking
about this I believe we can implement option 2 from your earlier email.
 I'd rather play some tricks and not clear the cache unless really
necessary.

Regards,
-Denis

--===============5079651946697436163==--

