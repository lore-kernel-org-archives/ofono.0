Content-Type: multipart/mixed; boundary="===============5256323354078641616=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Fri, 26 Jun 2015 18:01:52 -0500
Message-ID: <558DD9E0.3030100@gmail.com>
In-Reply-To: <55927DF9.6020006@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5256323354078641616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

 >
> At the end of a PPP connection, garbage was passed in to the AT command
> parser on the modem chat.

Well, the modem should not be passing in garbage in the first place :)

> This garbage contained a doublequote, which switched the AT syntax
> parser into string mode.
> However, because no second doublequote arrived, it stayed in this mode,
> and kept returning UNSURE result.
>

Do you have a trace/hexdump of what is passed on to the GAtChat object?

> I think this is an major issue that should be fixed in oFono.
> The syntax parser has to be extended to handle such cases.
>

Any suggestions on how oFono should detect this condition?

Regards,
-Denis

--===============5256323354078641616==--

