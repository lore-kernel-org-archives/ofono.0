Content-Type: multipart/mixed; boundary="===============0532895881302209288=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] idmap: use UL for bitshift literals
Date: Wed, 05 Mar 2014 08:52:34 -0600
Message-ID: <53173A32.4020109@gmail.com>
In-Reply-To: <1393977694-18423-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0532895881302209288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 03/04/2014 06:01 PM, Tony Espy wrote:
> The current bitshift logic in idmap incorrectly uses
> the literal 1 for the value to shift in idmap_alloc(),
> idmap_take(), and idmap_alloc_next().  This causes the
> resulting value to be an int instead of a long, which
> results in the wrong bit being set once the number of
> bits to shift operand exceeds sizeof(int).  Also
> on some platforms, the behavior of the left bitshift
> operator is undefined when this overflow occurs.
> ---
>   src/idmap.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>

Good catch.  Patch has been applied, thanks.

Regards,
-Denis


--===============0532895881302209288==--

