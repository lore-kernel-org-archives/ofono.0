Content-Type: multipart/mixed; boundary="===============5601936498002453195=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf: Fix modifying hash table while iterating
Date: Wed, 18 Apr 2012 10:55:13 -0500
Message-ID: <4F8EE3E1.4070502@gmail.com>
In-Reply-To: <1334762376-24124-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5601936498002453195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 04/18/2012 10:19 AM, Mikel Astiz wrote:
> Calling ofono_remove_modem() while iterating the hash table is not safe
> given that it can modify the table in hfp_remove().
> =

> A simple way to reproduce the problem is to pair some Bluetooth phones
> and remove the Bluetooth adapter, triggering a GLib-CRITICAL assertion.
> =

> This approach proposes a two-step removal: first, the hash table is
> iterated and all modems to be removed are marked as pending (thus
> removed from the hash table and put in a temporary list), and afterwards
> all pending modems are actually removed.
> ---
>  plugins/hfp_hf.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> =


The patch looks absolutely fine, however can you check whether removing
g_hashtable_remove from hfp_remove would do the trick as well?  We don't
seem to be doing this in the sap driver, and I no longer recall whether
this was done in hfp_hf to keep valgrind happy or is simply a mistake.

Regards,
-Denis

--===============5601936498002453195==--

