Content-Type: multipart/mixed; boundary="===============0789777586563903916=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: Re: calypso does not power up from 0.17
Date: Wed, 14 Apr 2010 11:57:33 +0200
Message-ID: <4BC5918D.4010900@djdas.net>
In-Reply-To: <4BC58810.6010901@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0789777586563903916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,
>
> You could set environment variable OFONO_AT_DEBUG to debug AT =

> conversation, like:
>     export set OFONO_AT_DEBUG=3D1
>
> And I found the commit fb918d39ba275cdd327 in Jan 28th has changed the =

> code to:
>          if (read_count > 0 && rbytes =3D=3D 0 && err !=3D G_IO_ERROR_AGA=
IN)
>                   return FALSE;
>
> What's the err value in freerunner?

I discussed this problem with Denis some time ago sending in IRC the log =

of OFONO_AT_DEBUG=3D1, the problem seems a timeout in the response from =

the Calypso, we tried to patch (as suggested by Denis) the code waiting =

more than 20 secs (we used 40 secs) but this gave no results.
As Nicola mentioned, 0.16 version works very well and we use it as daily =

in our distro without any problem so we thought there could be some =

other difference since 0.17 because no other newer version solves the =

problem.
Is there any other test we can do on our devices to make you able to =

investigate the problem?
Thank you very much in advance,
best regards,
Dario.

--===============0789777586563903916==--

