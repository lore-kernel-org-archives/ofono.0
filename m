Content-Type: multipart/mixed; boundary="===============2543208676056719055=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: CAT-M1 and NB-IoT features support in ofono
Date: Wed, 12 Dec 2018 12:52:02 +0100
Message-ID: <CAKSBH7HBFUOTVyOnDTQgVztcQ30zL=L_-VbEEspn=7SHJB7bKg@mail.gmail.com>
In-Reply-To: <VI1PR08MB37101D219233D9326338267FEBA70@VI1PR08MB3710.eurprd08.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2543208676056719055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 12, 2018 at 12:47 PM Lauri Piikivi <Lauri.Piikivi@arm.com> wr=
ote:
>
>
> Hi,
>
> I wanted to verify whether ofono has implementation, or has plans, to sup=
port the 3GPP CAT-M1 and NB-IoT features? I could not find this on a quick =
browse of the API.

I had, more specifically I was going to integrate CAT-M/M1 and maybe
later -M2 when they appear from Gemalto.
But I have abandoned that due to difficulties I cannot overcome with
the present mindset of the moderator. I am developing another
application, with freeBSD license, that has a dbus interface
compatible with the ofono one. In that I will also have catM modems.

As for cat NB, it might not make sense to use it with ofono, because
in general the applications are not big enough to have a linux
processor.

>
> Especially the power-save-mode, adjusting active time and eDRX and the ra=
te control support are of interest.
> A bit further in future the need for control plane data, both IP and non-=
IP, seems to grow. Non-IP might be a bit wider issue than just ofono adapta=
tion, is there any work being done on that in some other projects?
>
> BR
> -Lauri Piikivi

BR,
Giacinto

>
>
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============2543208676056719055==--

