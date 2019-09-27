Content-Type: multipart/mixed; boundary="===============4946298777502509664=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] quectel: use own cmux implementation over kernel line
 discipline
Date: Thu, 26 Sep 2019 20:00:18 -0500
Message-ID: <3f80f41f-7fa4-d3d3-f3f6-ffbdac1a2f4b@gmail.com>
In-Reply-To: <20190926192725.227285-4-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4946298777502509664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/26/19 2:27 PM, Martin Hundeb=C3=B8ll wrote:
> The in-kernel implementation of gsm0710 causes deadlocks in the
> kernel[1], so switch back to the user-space implementation in ofono.
> =

> [1] https://lore.kernel.org/lkml/4b2455c0-25ba-0187-6df6-c63b4ccc6a6e(a)g=
eanix.com/
> ---
>   plugins/quectel.c | 250 ++++++++++++++++++++++++----------------------
>   1 file changed, 130 insertions(+), 120 deletions(-)
> =


Ugh.  That poor quectel.c file has so much churn its not funny :)

So I wonder whether instead of fully reverting back to CMUX (only to put =

in n_gsm in later) you might want to just keep both around and use a =

/etc/quectel.conf or OFONO_QUECTEL_MUX=3Dn_gsm|internal instead?

Regards,
-Denis


--===============4946298777502509664==--

