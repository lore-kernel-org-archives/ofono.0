Content-Type: multipart/mixed; boundary="===============1269811379048490708=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: [PATCH 1/1] Fix compilation on armhf/Musl
Date: Fri, 08 Sep 2017 10:15:10 -0700
Message-ID: <20170908171510.GB3@computer.craftyguy.net>
In-Reply-To: <ed4776f4-1cb8-b908-67b0-c96cacd80cdc@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1269811379048490708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>Applied.  Please note that I had to hand-apply this patch since =

>it didn't apply cleanly.  Are you using the latest git?

Hmm, I am using the latest git (well as of earlier this morning).


>Also, I split this into two commits per our Patch submission =

>guidelines.  See 'HACKING' document in git.

Shoot, I'm sorry. I will re-read the HACKING document :)

-Clayton


On Fri, Sep 08, 2017 at 12:11:52PM -0500, Denis Kenzior wrote:
>Hi Clayton,
>
>On 09/08/2017 11:18 AM, Clayton Craft wrote:
>>The following patch is needed to successfully build ofono on armhf with
>>musl (in place of libc)
>>
>>
>
>Applied.  Please note that I had to hand-apply this patch since =

>it didn't apply cleanly.  Are you using the latest git?
>
>Also, I split this into two commits per our Patch submission =

>guidelines.  See 'HACKING' document in git.
>
>Regards,
>-Denis


--===============1269811379048490708==--

