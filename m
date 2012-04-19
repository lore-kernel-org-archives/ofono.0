Content-Type: multipart/mixed; boundary="===============7632258523333713713=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] hfp_hf: Fix modifying hash table while iterating
Date: Thu, 19 Apr 2012 07:41:56 -0500
Message-ID: <4F900814.4030507@gmail.com>
In-Reply-To: <1334818738-14217-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7632258523333713713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 04/19/2012 01:58 AM, Mikel Astiz wrote:
> Calling ofono_remove_modem() while iterating the hash table is not safe
> given that it can modify the table in hfp_remove().
> =

> A simple way to reproduce the problem is to pair some Bluetooth phones
> and remove the Bluetooth adapter, triggering a GLib-CRITICAL assertion.
> =

> This patch just removes the update of the hash table inside
> hfp_remove(). This can be safe as long as all calls to
> ofono_modem_remove() are accompanied by a hash table update. The only
> example of this kind right now is hfp_agent_release().
> ---
>  plugins/hfp_hf.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7632258523333713713==--

