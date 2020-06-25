Content-Type: multipart/mixed; boundary="===============8833761416995094104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] modem: add a driver reset function
Date: Thu, 25 Jun 2020 11:57:09 -0500
Message-ID: <717a3cb0-7d68-6910-cbe2-fc73aaff8b11@gmail.com>
In-Reply-To: <20200625092851.4548-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8833761416995094104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/25/20 4:28 AM, Jimmy Gysens wrote:
> Add a reset function to the modem driver. This function can be used to ha=
rd
> reset the device. This is an alternative in case the (*enable) and
> (*disable) functions are not supported.

I'm confused, how are you even powering the modem up if enable is not =

implemented?  And how would one detect that a reset is needed?

Perhaps this makes more sense as a vendor specific API inside plugins/huawe=
i.c ?

Regards,
-Denis
--===============8833761416995094104==--

