Content-Type: multipart/mixed; boundary="===============0107185570815796484=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Message waiting patches
Date: Thu, 16 Jul 2015 20:23:40 -0500
Message-ID: <55A8591C.4080206@gmail.com>
In-Reply-To: <CACM4vuCBb19LLqmJwKPcVePY2=KvYtHG_YxWmFG1=3ddXxDCfQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0107185570815796484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 07/16/2015 08:08 AM, Alfonso Sanchez-Beato wrote:
> Hi all,
>
> I have just sent to the list a couple of fixes for the message-waiting
> atom. In some cases the EF_MWIS was populated with bad data due to using
> an uninitialized variable: one patch solves this. The other one is for
> properly updating the atom structures when reading EF_MWIS, and it is
> good to have although it was not really affecting anything.
>
> Br,
> Alfonso

Both patches make sense to me.  Applied, thanks!

Regards,
-Denis

--===============0107185570815796484==--

