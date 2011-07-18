Content-Type: multipart/mixed; boundary="===============2883097470880441289=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH 1/3] Mobile broadband provider info plugin
Date: Mon, 18 Jul 2011 16:32:11 +0300
Message-ID: <4E2435DB.7080006@intel.com>
In-Reply-To: <4E208460.2010206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2883097470880441289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Denis,

On 07/15/2011 09:18 PM, Denis Kenzior wrote:
> Does mobile-broadband-provider actually have multiple settings yet? If
> not, then this might need to be set to 1 until it does.

Actually, it does.

> Why is this const?  You're performing some nasty casting later because
> it is.  If you're assigning the result of g_strdup to this variable,
> then it shouldn't be const in the first place ;)
> My concern is that this is not valgrind safe, but more importantly, why
> don't we use an enum here?  That would save us some string comparisons.

Sure, this const isn't necessary at all. Enum is also a good idea here, I w=
ill =

update.

> I'm a little unclear on how we handle multiple matches of the same
> mcc/mnc.  To my understanding these are different plans within the same
> provider and some user intervention is required to select the right
> plan.  Or it could be that the operator is actually an MVNO, which is
> why the SPN provided by oFono in order to to distinguish between them.
>
> So it sounds like that if we encounter entries where multiple matches
> are possible, we should not actually provision the context.

To my understanding, multiple matches of the same mcc/mnc might be because =
of:

  - Different kind of settings (internet/mms/wap).
  - Different plans for the same kind of setting (prepaid/postpaid).
  - MVNO.

A few possible solutions in order to avoid the ambiguity would be:

1. One could try guess the type of settings out of the access point name. T=
his =

should work with a few exceptions, which could be handled case by case.

2. Same as item 1, except when the kind of settings can't be guessed, just =
not =

to provision the context and let the user possibility to choose.

3. To introduce additional tags (internet, mms, wap, prepaid, postpaid).

Any thoughts?

And yet a question regarding not provisioning the context. How should this =
be =

achieved by plugin:

- Passing no settings to oFono?
- Passing all found settings to oFono, but indicating that the user interve=
ntion =

is required?

Anyway, thanks for the comments and ideas. I will prepare another patch.

Regards,
Oleg

-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============2883097470880441289==--

