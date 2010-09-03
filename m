Content-Type: multipart/mixed; boundary="===============5473304150446111947=="
MIME-Version: 1.0
From: Jeevaka Prabu Badrappan <jeevakaprabu@gmail.com>
Subject: Re: Patch: "Added missing DCS handling in stkutil and stk" Description
Date: Fri, 03 Sep 2010 04:59:01 +0300
Message-ID: <AANLkTikRo0aM549pBa5G=Muh8oQUcTZc5KQM82G0Yq1o@mail.gmail.com>
In-Reply-To: <AANLkTi=vwa2GYP43LQaOpSg_wzZUAyDxyKeG4TX=-PP-@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5473304150446111947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> There are two cases:
> =C2=A0* Get Inkey/Get Input, where the answer is actual text, in this case
> the dcs can be determined automatically,
>
> =C2=A0* Send USSD where we're sending the "8.15 Text string" but the
> contents don't actually have to contain a string, it may be any data
> that the network sends us. =C2=A0So to me it makes more sense to handle
> this using a separate structure like you did in your original patch,
> which contains len, dcs and contents.

Yes, I undestand for the Get Inkey/Get Input, dcs is determined
automatically. Currently, we are providing one function for building
each data object specificed in 3GPP specification. If we provide a new
structure, then we need to provide a new function for building the
text string data object. This will result in having 2
build_dataobj_text( existing one for handling Get Inkey and Get Input)
and build_dataobj_ussdtext(new one for handling the section 8.15),
which is deviating from the existing ones. If we extend the existing
structure and add generalised handling which is done now in this
patch, we won't be deviating from the existing things.

Regards,
jeevaka

--===============5473304150446111947==--

