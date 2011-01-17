Content-Type: multipart/mixed; boundary="===============0618722382143477378=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC PATCH 0/3] Long phone numbers
Date: Mon, 17 Jan 2011 23:18:51 +0200
Message-ID: <AANLkTi=ZBdVALq+n4EOBMh-nMN2zkMbrzqOFvOor0ZhQ@mail.gmail.com>
In-Reply-To: <1295276368-32233-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0618722382143477378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

2011/1/17 Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>:
> This is a proposal for the "long phone number" task (80 digits max length=
).
> It changes OFONO_MAX_PHONE_NUMBER_LENGTH and splits
> common:valid_phone_number_format(), to make sure long numbers are handled
> appropriately for functions that need manage shorter numbers, like
> numbers written to the SIM, or sms SCA.

Perhaps a validator and type for long phone numbers is better than for
short numbers? I guess long numbers are mostly used when reporting an
outgoing call back to oFono.

BTW, with call forwarding you could have numbers up to 16 digits or if
longForwardedToNumber is supported (by modem and both home and visited
networks) even 28 digits. See TS 29.002 for merry details.

-- =

Pekka.Pessi mail at nokia.com

--===============0618722382143477378==--

