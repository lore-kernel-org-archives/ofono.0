Content-Type: multipart/mixed; boundary="===============6297859830169126271=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 4/4] quectel: use own cmux implementation over kernel line
 discipline
Date: Mon, 30 Sep 2019 21:43:07 +0200
Message-ID: <d9e21d81-9a5a-c718-71b6-7e12f6e20cbd@geanix.com>
In-Reply-To: <3f80f41f-7fa4-d3d3-f3f6-ffbdac1a2f4b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6297859830169126271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 27/09/2019 03.00, Denis Kenzior wrote:
> On 9/26/19 2:27 PM, Martin Hundeb=C3=B8ll wrote:
>> The in-kernel implementation of gsm0710 causes deadlocks in the
>> kernel[1], so switch back to the user-space implementation in ofono.
>>
>> [1] =

>> https://lore.kernel.org/lkml/4b2455c0-25ba-0187-6df6-c63b4ccc6a6e(a)gean=
ix.com/ =

>>
>> ---
>> =C2=A0 plugins/quectel.c | 250 ++++++++++++++++++++++++-----------------=
-----
>> =C2=A0 1 file changed, 130 insertions(+), 120 deletions(-)
>>
> =

> Ugh.=C2=A0 That poor quectel.c file has so much churn its not funny :)

As long as it is getting better along the way :)

> So I wonder whether instead of fully reverting back to CMUX (only to put =

> in n_gsm in later) you might want to just keep both around and use a =

> /etc/quectel.conf or OFONO_QUECTEL_MUX=3Dn_gsm|internal instead?

I'd prefer a single method to keep the needed testing to a minimum.

// Martin
--===============6297859830169126271==--

