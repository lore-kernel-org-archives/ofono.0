Content-Type: multipart/mixed; boundary="===============4007958310006102326=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: Ofono has too tight limits for SIM lock code lengths
Date: Thu, 27 Jan 2011 16:31:29 +0200
Message-ID: <1296138689.31603.51.camel@jussi-desktop>
In-Reply-To: <1296133767.1520.147.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4007958310006102326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Thu, 2011-01-27 at 15:09 +0200, Marcel Holtmann wrote:

> so every single enum has kept some sort of proper namespacing. And I
> would really prefer to not break this for ofono_sim_password_type.

I suppose u are talking about parameter name here? and
OFONO_PASSWORD_PIN_TYPE_NET is somehow inproper? Well, how should it be
then? Code type is named differently because it is not a SIM password. I
see three possible ways to change this. =


1) Rename enum. I would name it to ofono_password_type and all
parameters to OFONO_PASSWORD_xxx. Means lot's of more changing in
different directories and since this version control system is as it is
I would not like to do that. =


2) Ignore the fact that network password used for call_barring is not
SIM password and rename it as OFONO_SIM_PASSWORD_TYPE_NET. Little bit
misguiding but fine with me.

3) Create new separate definition. I'm fine with this too.   =


Br,
-jussi



--===============4007958310006102326==--

