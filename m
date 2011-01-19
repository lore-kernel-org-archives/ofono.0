Content-Type: multipart/mixed; boundary="===============8045438158091814983=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Wed, 19 Jan 2011 15:00:00 +0200
Message-ID: <AANLkTinZiVpbQguAegPA=Q+oEW=8mvA8TApq8a5LqHkc@mail.gmail.com>
In-Reply-To: <4D360006.1040506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8045438158091814983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/1/18 Denis Kenzior <denkenz@gmail.com>:
> I'm fine with forced-auto, but we might want to add a new error type to
> ofono.h (maybe something like ManualRegistrationNotAllowed) and return
> that error when trying to use Scan or NetworkOperator.Register.

I was reusing the __ofono_error_access_denied(), which I think came
with the lockdown feature.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============8045438158091814983==--

