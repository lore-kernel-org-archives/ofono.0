Content-Type: multipart/mixed; boundary="===============7973673747457846313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Fix compilation on armhf/Musl
Date: Fri, 08 Sep 2017 12:11:52 -0500
Message-ID: <ed4776f4-1cb8-b908-67b0-c96cacd80cdc@gmail.com>
In-Reply-To: <20170908161820.GA3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7973673747457846313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clayton,

On 09/08/2017 11:18 AM, Clayton Craft wrote:
> The following patch is needed to successfully build ofono on armhf with
> musl (in place of libc)
> =

> =


Applied.  Please note that I had to hand-apply this patch since it =

didn't apply cleanly.  Are you using the latest git?

Also, I split this into two commits per our Patch submission guidelines. =

  See 'HACKING' document in git.

Regards,
-Denis

--===============7973673747457846313==--

