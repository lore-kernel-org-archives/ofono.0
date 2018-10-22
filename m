Content-Type: multipart/mixed; boundary="===============0414963429427624648=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v8 0/5] lte atom auth and IP protocol
Date: Mon, 22 Oct 2018 11:48:24 -0500
Message-ID: <ffec1cfc-cc61-4471-6683-c8fa9b2c100a@gmail.com>
In-Reply-To: <20181019113141.20734-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0414963429427624648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/19/2018 06:31 AM, Giacinto Cifelli wrote:
> I would like to submit this patch for the lte atom
> =

> This patch adds in core atom:
> -  the protocol for the default LTE APN, ip, ipv6 and both
> - the authentication handling, with 3 properties:
> 	method, username, password
> =

> then these are used in the atmodem atom:
> =

> The behavior of the patch is described in the api document (part 1),
> and in the core atom header (part 2).
> =

> Related to the previous version, this version:
> - changes the name of the function at_auth_type_from_method in
>    atmodem/atutils, as suggested by Jonas, and calls it without passing
>    from an intermediate local variable.
> =


I've pushed out the first three patches of this series with a few =

trivial tweaks added.  Thanks!

Regards,
-Denis

--===============0414963429427624648==--

