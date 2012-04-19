Content-Type: multipart/mixed; boundary="===============8475033533548282582=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] hfp_hf: Fix modifying hash table while iterating
Date: Thu, 19 Apr 2012 08:54:21 +0200
Message-ID: <CANT-zCUrNSM4xRhwj_CiiCZeJoMV-vDkqKC4pj=Co6y3Q8AhWw@mail.gmail.com>
In-Reply-To: <4F8EE3E1.4070502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8475033533548282582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Apr 18, 2012 at 5:55 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mikel,
>
> On 04/18/2012 10:19 AM, Mikel Astiz wrote:
>> Calling ofono_remove_modem() while iterating the hash table is not safe
>> given that it can modify the table in hfp_remove().
>>
>> A simple way to reproduce the problem is to pair some Bluetooth phones
>> and remove the Bluetooth adapter, triggering a GLib-CRITICAL assertion.
>>
>> This approach proposes a two-step removal: first, the hash table is
>> iterated and all modems to be removed are marked as pending (thus
>> removed from the hash table and put in a temporary list), and afterwards
>> all pending modems are actually removed.
>> ---
>> =C2=A0plugins/hfp_hf.c | =C2=A0 11 ++++++++++-
>> =C2=A01 files changed, 10 insertions(+), 1 deletions(-)
>>
>
> The patch looks absolutely fine, however can you check whether removing
> g_hashtable_remove from hfp_remove would do the trick as well? =C2=A0We d=
on't
> seem to be doing this in the sap driver, and I no longer recall whether
> this was done in hfp_hf to keep valgrind happy or is simply a mistake.

I was reluctant to make such a change because I wasn't entirely sure about
which assumptions are made by the core about modem removals.

If we know that all calls to ofono_modem_remove() will be originated in
hfp_hf.c, then your proposal would just work. I will send the corresponding
patch soon.

Cheers,
Mikel

--===============8475033533548282582==--

