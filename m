Content-Type: multipart/mixed; boundary="===============0011278640718469565=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: 3G Modem not enabled (Huawei+Vodafone sim)
Date: Sun, 21 Jun 2015 15:12:36 +0200
Message-ID: <5586B844.3080900@dynamicdevices.co.uk>
In-Reply-To: <CADLyyJER8JQp=mXru7MUi053M4CZGQE92DFjpySm5cD8PTYb4w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0011278640718469565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 21/06/2015 12:56, Sriram Sagar wrote:
> Hi,
>
> I am having issue in connecting 3G modem on my arm platform.
>
> I am using connman(1.29) as my network manager and ofonod(1.14) and
>  modem is not been detected.
>
> I have checked the logs =

>
> huawei_probe  function is been called and hung there.
>
> Any body can help on this one.
>

Hi,

Looking at the probe function I can't see any way it could be hanging?

https://github.com/intgr/ofono/blob/65a147eb17260f7fa46cb4e1286a6f338cd831a=
4/plugins/huawei.c#L94

Have you -d debug logging turned on and OFONO_AT_DEBUG=3D1 ?

Maybe add in some debug output to see if it is getting past the probe
function?

Regards,

Alex

--===============0011278640718469565==--

