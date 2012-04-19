Content-Type: multipart/mixed; boundary="===============3456410127550618164=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] hfp_hf: Fix modifying hash table while iterating
Date: Thu, 19 Apr 2012 19:15:08 +0200
Message-ID: <CANT-zCU-bGH1pW-o68TPJtOywE9eBJoASNcy58sytWu5nqPF-w@mail.gmail.com>
In-Reply-To: <4F8F626F.3060008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3456410127550618164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Apr 19, 2012 at 2:55 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mikel,
>
>>> The patch looks absolutely fine, however can you check whether removing
>>> g_hashtable_remove from hfp_remove would do the trick as well? =C2=A0We=
 don't
>>> seem to be doing this in the sap driver, and I no longer recall whether
>>> this was done in hfp_hf to keep valgrind happy or is simply a mistake.
>>
>> I was reluctant to make such a change because I wasn't entirely sure abo=
ut
>> which assumptions are made by the core about modem removals.
>>
>> If we know that all calls to ofono_modem_remove() will be originated in
>> hfp_hf.c, then your proposal would just work. I will send the correspond=
ing
>> patch soon.
>
> The core does not call ofono_modem_remove on its own, this is triggered
> by the plugins (e.g. udev, bluetooth). =C2=A0So Under normal circumstances
> all calls to ofono_modem_remove would be triggered by BlueZ reporting
> something, e.g. adapter removed, device removed, etc.

In that case the second version that I proposed should work.

> The only time this might be a problem is during shutdown, hence my
> comment about keeping valgrind happy.

During shutdown the table is freed inside hfp_exit, so that shouldn't
be a problem.

Cheers,
Mikel

--===============3456410127550618164==--

