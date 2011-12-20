Content-Type: multipart/mixed; boundary="===============8312617131997209716=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 2/3] network: Add CPHS SPN, short-SPN fallbacks
Date: Tue, 20 Dec 2011 15:19:22 +0200
Message-ID: <4EF08B5A.2060005@intel.com>
In-Reply-To: <4EF02C71.7020008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8312617131997209716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 12/20/2011 08:34 AM, Denis Kenzior wrote:
> You have to be careful here since you can't really guarantee that the
> operation will succeed in your time allotted.  If you are unlucky the
> timer will fire before the entire transaction succeeds and you might be
> running the old transaction and the new transaction in parallel.  You
> would have to check if the current code can handle this, but probably
> not.  And of course you never know what timer value is large enough.

Just a little more explanation here. The g_timeout_add() is periodical, in =

unlucky case it will run a few times checking whether the SPN reading flag =
is =

cleared and only after that will trigger the new read operation and unregis=
ter =

itself. Since we clear the flag in all SPN read callbacks in all cases, thi=
s =

should be safe.

> A better approach might be to set another flag in this case, e.g.
> RECHECK_SPN, and re-do the transaction.  However, you'd also need to
> make sure the sim file cache is flushed as well.

This might be more efficient, let me check this.

>> I will be sending SPN changes for src/gprs.c soon.
>
> Before you do this, a sanity check on whether any MVNOs actually use the
> CPHS SPN field might be in order.  It may be that this complexity is not
> needed in the gprs.c provisioning logic; and that the EFspn field is
> sufficient.

Sure, that makes sense. I haven't found anything on usage of CPHS SPN by MV=
NOs. =

However, that doesn't mean nobody is using it. Anyway, that change won't to=
uch =

the provisioning logic, might this be useful, the patch is almost ready, ju=
st =

decide when you see it.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============8312617131997209716==--

