Content-Type: multipart/mixed; boundary="===============4491581654270254200=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix common misspellings
Date: Mon, 13 Sep 2010 21:37:45 -0500
Message-ID: <4C8EDFF9.4060006@gmail.com>
In-Reply-To: <AANLkTin7tZ+zWXdZaOcRa5vDtFq=6d_WJRokjaGU2CMu@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4491581654270254200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 09/13/2010 09:32 PM, Lucas De Marchi wrote:
> On Mon, Sep 13, 2010 at 10:35 PM, Marcel Holtmann <marcel@holtmann.org>=
 wrote:
>> no signed-off-by please. We don't use it.
> =

> Sorry, I forgot this project follows the same rules as for connman.
> =

>> While in general I am all for fixing spelling mistakes, but you need to
>> break this down into logical chunks. Just doing a mega patch that does
>> changes all over the place is not working out.
> =

> How do you want me to split this patch? In my opinion it's not that
> big and it's almost only 1 change per file.  If the split is required,
> I think the options are 1) per changed word or 2) per file or 3)
> changes in documentation + changes in source files.
> =


Can you split them 1 / directory?  E.g.

- patch for files in gatchat/
- patch for files in doc/
- patch for files in drivers/
- patch for files in gisi

etc

Regards,
-Denis

--===============4491581654270254200==--

