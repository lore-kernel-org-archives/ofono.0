Content-Type: multipart/mixed; boundary="===============3708796923370208851=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Ofono has too tight limits for SIM lock code lengths
Date: Fri, 28 Jan 2011 17:20:12 +0200
Message-ID: <AANLkTimLWEwr9Fzy-rizpMznTdLjpdaN5vauAsQg5f_2@mail.gmail.com>
In-Reply-To: <1296138689.31603.51.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3708796923370208851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Moro Jussi,

2011/1/27 Jussi Kangas <jussi.kangas@tieto.com>:
>> so every single enum has kept some sort of proper namespacing. And I
>> would really prefer to not break this for ofono_sim_password_type.
>
> I suppose u are talking about parameter name here? and
> OFONO_PASSWORD_PIN_TYPE_NET is somehow inproper? Well, how should it be
> then? Code type is named differently because it is not a SIM password. I
> see three possible ways to change this.
>
> 1) Rename enum. I would name it to ofono_password_type and all
> parameters to OFONO_PASSWORD_xxx. Means lot's of more changing in
> different directories and since this version control system is as it is
> I would not like to do that.
>
> 2) Ignore the fact that network password used for call_barring is not
> SIM password and rename it as OFONO_SIM_PASSWORD_TYPE_NET. Little bit
> misguiding but fine with me.
>
> 3) Create new separate definition. I'm fine with this too.

What about PIN_TYPE_PH_PIN and

static enum pin_type sim_get_pin_type(enum ofono_sim_password_type pwtype)

returning PIN_TYPE_PIN, PIN_TYPE_PUK or PIN_TYPE_PH_PIN?

so instead of

	if (!is_valid_pin(pin, PIN_TYPE_PIN))

you would use

	if (!is_valid_pin(pin, sim_get_pin_type(type)))

-- =

Pekka.Pessi mail at nokia.com

--===============3708796923370208851==--

