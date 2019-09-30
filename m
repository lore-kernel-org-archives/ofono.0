Content-Type: multipart/mixed; boundary="===============2450208430190825897=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] quectel: use own cmux implementation over kernel line
 discipline
Date: Mon, 30 Sep 2019 14:55:06 -0500
Message-ID: <2a2597d7-b0f6-fcfe-9b94-bc19611ae633@gmail.com>
In-Reply-To: <d9e21d81-9a5a-c718-71b6-7e12f6e20cbd@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2450208430190825897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>> So I wonder whether instead of fully reverting back to CMUX (only to =

>> put in n_gsm in later) you might want to just keep both around and use =

>> a /etc/quectel.conf or OFONO_QUECTEL_MUX=3Dn_gsm|internal instead?
> =

> I'd prefer a single method to keep the needed testing to a minimum.
> =


I know where you're coming from, but you will probably come back in 6 =

months and want to use the kernel multiplexer again and this change will =

get reverted again.

Then someone with an old kernel will want the built-in one.  Might as =

well bite the bullet now..

Regards,
-Denis
--===============2450208430190825897==--

