Content-Type: multipart/mixed; boundary="===============6980899977375976644=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Fri, 18 Apr 2014 09:56:02 -0500
Message-ID: <53513D02.90609@gmail.com>
In-Reply-To: <53511462.9040206@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6980899977375976644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

> Even if the operator database was 100% accurate (which is practically
> impossible) something would still have to be done about the operators
> sharing MCC/MNC and yet using different AP settings.

We already have such a selector, it is called Service Provider Name or
SPN.  This is read from the SIM and just about every provider populates
(they want their operator name to be displayed correctly after all).

Regards,
-Denis

--===============6980899977375976644==--

