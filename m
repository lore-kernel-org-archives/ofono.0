Content-Type: multipart/mixed; boundary="===============1804850519833262523=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Patch: "Added missing DCS handling in stkutil and stk" Description
Date: Fri, 03 Sep 2010 02:57:02 +0200
Message-ID: <AANLkTi=vwa2GYP43LQaOpSg_wzZUAyDxyKeG4TX=-PP-@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A0E5D5@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1804850519833262523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 2 September 2010 16:16,  <Jeevaka.Badrappan@elektrobit.com> wrote:
> =C2=A0The following patch "Added missing DCS handling in stkutil and stk"
> handles the missing dcs case as:
>
> =C2=A0As per 3GPP TS 31.111 section 8.15 Text string structure requires d=
cs
> and text string to be sent. Current stkutil function and data structure
> is missing the dcs information.
> =C2=A0In this patch, we handle the case where dcs will be a value other t=
han
> -1, yesno and packed values are false. This text string structure is
> used in Terminal response of Get Inkey, Get Input and Send USSD.

There are two cases:
 * Get Inkey/Get Input, where the answer is actual text, in this case
the dcs can be determined automatically,

 * Send USSD where we're sending the "8.15 Text string" but the
contents don't actually have to contain a string, it may be any data
that the network sends us.  So to me it makes more sense to handle
this using a separate structure like you did in your original patch,
which contains len, dcs and contents.

Best regards

--===============1804850519833262523==--

