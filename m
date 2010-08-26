Content-Type: multipart/mixed; boundary="===============4139559436499679645=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [sim-fdn PATCH 1/4] sim: add EnableFDN and DisableFDN methods
Date: Thu, 26 Aug 2010 19:08:59 +0300
Message-ID: <AANLkTi=iBgBu1KihScHS9LEg2Y_+wb8EjRVzEYAQAp1i@mail.gmail.com>
In-Reply-To: <4C768F72.9090905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4139559436499679645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/8/26 Denis Kenzior <denkenz@gmail.com>:
>>>> Enable or disable Fixed Dialing Numbers feature on SIM card.
>>>>
>>>> If enabled, calls can be dialled or SMSs sent only to numbers listed on
>>>> special FDN phonebook on the SIM card.
>>>
>>> FDN has serious implications for the rest of the system, particularly on
>>> SMS atom and Sim Toolkit. =C2=A0oFono will either have to support the e=
ntire
>>> thing properly or use a 'limited' FDN mode (e.g. if FDN is enabled, we
>>> only permit emergency calls.)
>>
>>> We have really not made our mind what makes sense here yet.
>>
>> I think most modems support FDN in the firmware. (Well, famous last
>> words.) I don't think it makes any sense to support or "support" it in
>> oFono.
>
> You're correct. =C2=A0However, if FDN is enabled, carriers require that S=
MSes
> to numbers not in FDN to be rejected. =C2=A0It is quite unclear whether t=
his
> is done in the firmware or not. =C2=A0If oFono has to handle it internall=
y,
> then we also require access to the FDN phonebook.
>
> Sim Toolkit interactions require FDN to be explicitly ignored for Send
> SMS, Setup Call. =C2=A0If these are not handled in the firmware, then we
> can't properly support FDN.

Do you think oFono should reject the SIM if it happens to have FDN enabled?=
 Why?

If we don't support FDN restrictions, we don't support. This has
nothing to do whether we should allow the user to disable the FDN on
the SIM card or not.

-- =

Pekka.Pessi mail at nokia.com

--===============4139559436499679645==--

