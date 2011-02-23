Content-Type: multipart/mixed; boundary="===============3280275144099347305=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Wed, 23 Feb 2011 09:58:05 -0600
Message-ID: <4D652E8D.2020404@gmail.com>
In-Reply-To: <AANLkTinshCCWMqKhgJocjHArKHOy9son=B0=bkzE37tw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3280275144099347305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

> Common gprs atom would be able to handle all situation: 3G only, 3G /
> LTE, LTE only,
> marking technology in Bearer property. Though it might be difficult to
> handle double
> registration of 3G and LTE at the same time for mix modems, if this is
> allowed.
> =

> 3G only stuff in gprs seems to be only gprs_suspend during callback as
> in LTE
> call won't suspend connection, and attached property as LTE is always
> attached.

Yes, unfortunately this is also the nastiest part of the GPRS atom
logic.  From past experience I can tell you that extending the logic
will not be easy.

> Most of this atom is context related which is common.
> =

> Fast look gives me this division of gprs:
> - gprs atom: suspend, attached, status handling
> - lte atom: status handling
> - context atom (common part for 3G and LTE): whole context handling,
>     cid map, ~80% of current src/gprs.c, + some IMS stuff
> all would probably need to use netreg_watch
> =


Most of the context management can be done on a separate atom /
interface if needed.

> In my opinion, combined gprs atom would be easier to do and probably enou=
gh,
> separate atoms would be more "looking into the future" like but I am not
> sure if this division is necessary.

Looking at the current ConnectionManager API, none of the properties
(Powered, Attached, Suspended, RoamingAllowed) are applicable to LTE.
If we use a separate LTE atom then the Bearer property's 'lte' value is
redundant as well.  So why would you want to carry this baggage around
for the user of LTE-only systems?

Without those properties and the associated logic, the LTE-only atom
becomes quite trivial, assuming the context management is factored out
somewhere nicely.

You might be right of course and this separation is not necessary.  But
we won't know until we try.

Regards,
-Denis

--===============3280275144099347305==--

