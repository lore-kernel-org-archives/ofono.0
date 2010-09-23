Content-Type: multipart/mixed; boundary="===============4489982432042062472=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Fix valid_ussd_string()
Date: Thu, 23 Sep 2010 17:25:45 +0300
Message-ID: <AANLkTi=hOuTFO11+v=6SaMdegsz=ZKGbb=Z+YaOYPGh3@mail.gmail.com>
In-Reply-To: <1285207918.20811.60.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4489982432042062472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/9/23 Marcel Holtmann <marcel@holtmann.org>:
> this is not an acceptable patch. You are removing functionality and
> lengthy comment without providing a comment in the commit message from
> equal length and detail.
>
> We can not do it like this since 1 month later nobody remembers what has
> been done here and why. This needs proper documentation.

Please care to explain what the reference to the 22.090 was doing
here? A terminal simply do not care how the network routes the USSD.
And from the network point of view, any string that can be encoded in
the ussd-String of processUnstructuredSS-Request according to the
rules of 23.038 is valid USSD string. Most of them fall in the cop-out
of the case d in the 22.090 reference I removed. Like if I sent a USSD
string "Marcel" to network, it is handled according to the case d.

Denis explained to me what this function was supposed to do, and I
tried to fix it according to the explanation. According to Denis, the
function here determines which MMI dial strings are considered as USSD
string (after structured supplementary service control codes are
weeded out).

I can put the explanation into the commit message (and fix the ussd
atom part), if that is required.

-- =

Pekka.Pessi mail at nokia.com

--===============4489982432042062472==--

