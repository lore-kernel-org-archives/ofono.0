Content-Type: multipart/mixed; boundary="===============1221567375686054078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: fix allocation of context id
Date: Wed, 02 Jan 2019 12:20:11 -0600
Message-ID: <a157aca0-0a18-b0bb-0d05-cf96f55f6879@gmail.com>
In-Reply-To: <20190102115053.79191-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1221567375686054078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/02/2019 05:50 AM, Martin Hundeb=C3=B8ll wrote:
> After the convertion to l_uintset, the creation of new contexts fails
> due to a range error being returned from l_uintset_find_unused().
> =

> The error happens because the uinset is created with a min-value of 1,
> but the start-value passed to l_uintset_find_unused() is initialized as
> 0.

Whoops, my bad.  I forgot how my own API works.

> =

> Fix this by passing a start-value just past the last allocated context
> id.

Won't this return an error if the last_context_id is at max?  I think =

the right fix is to back to the original logic, where

if (!gprs->last_context_id)
	id =3D l_uintset_find_unused_min();
else
	id =3D l_uintset_find-unused();

> ---
>   src/gprs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Regards,
-Denis

--===============1221567375686054078==--

