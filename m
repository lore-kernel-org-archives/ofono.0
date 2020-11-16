Content-Type: multipart/mixed; boundary="===============2897754081360774797=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: Re: 4G modem re-register
Date: Tue, 17 Nov 2020 07:23:15 +1100
Message-ID: <CAA=hcWTvzdZ0eiwE0Vo2fWzhAhaA+4eLYzjY-PaGkbjckzep0Q@mail.gmail.com>
In-Reply-To: <CAA=hcWQEVe6OSi_A1eFpG7idW1JmtdimCMpRD2KW0+sGPX3V=A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2897754081360774797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Are there any calllback mechanism in ofono or connman when 4G LTE
modem is deregistered and the network is broken? I am currently
polling it in software to call modem power reset to bring the 4G
reconnected, polling is not efficient.

How do you usually handle 4G modem deregister? Am I the only one
missing something in ofono and connman?

Also, uBlox support advised not to use QMI in ofono, to use AT, how to
configure ofono to use AT rather than QMI?

Thank you and appreciate your kind advice.

Kind regards,

- jh



On 11/6/20, Jupiter <jupiter.hce@gmail.com> wrote:
> Hi,
>
> I am running oFono and Connman for uBlox SARA modem in QMI on iMX6,
> when the modem is deregistered due to low signal, it cannot not be
> re-registered automatically.
>
> The SARA modem is capable of re-register, I can verify that capacity
> in SARA EVK, but why that capacity cannot be performed in an oFono
> device? What could I be missing in oFono configuration?
>
> Thank you.
>
> Kind regards,
>
> - jh
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
--===============2897754081360774797==--

