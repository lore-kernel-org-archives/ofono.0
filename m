Content-Type: multipart/mixed; boundary="===============7268708809036484705=="
MIME-Version: 1.0
From: Leonardo Luiz Padovani da Mata <leonardol@syst.com.br>
Subject: Re: AT+CFUN=7 not supported by Huawei E173
Date: Tue, 12 Jul 2011 14:53:13 -0300
Message-ID: <CAMdu8wEzDhw7jNV0NgLoifRROLK3qoMVE0BqeJLBWsEvr_R7gw@mail.gmail.com>
In-Reply-To: <4E1C6FB1.9090703@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7268708809036484705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm very interested on having this modem working... Is there anything
i contribute with?

On Tue, Jul 12, 2011 at 1:00 PM, nicolas.bertrand
<nicolas.bertrand@linux.intel.com> wrote:
> Hi Marcel,
>
> I got a problem with the change "huawei: Use correct command for setting
> offline mode".
>
> The command AT+CFUN=3D7 is not supported by all Huawei modems and so the =
E173
> is not working anymore.
>
> PCUI: > AT+CFUN=3D7\r
> PCUI: < \r\n+CME ERROR: 50\r\n
>
> This modem supports only these functionality level: 0, 1, 4, 5 and 6.
> I don't have the specification of this modem and so I don't know what lev=
el
> we need to set here.
>
> Do you have an idea on how we can resolve this problem?
>
> Thanks.
>
> --
>
> Nico
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =

Leonardo Luiz Padovani da Mata

International Syst S/A
Metasys Tecnologia
Software Engineer Metasys MeeGo Team

leonardol(a)metasys.com.br
+55-31-3503-9040

"May the force be with you, always"
"Nerd Pride... eu tenho. Voce tem?"

--===============7268708809036484705==--

